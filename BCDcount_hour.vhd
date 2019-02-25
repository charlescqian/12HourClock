LIBRARY ieee;
USE IEEE.STD_LOGIC_1164.all;
USE IEEE.STD_LOGIC_ARITH.all;
USE IEEE.STD_LOGIC_UNSIGNED.all;

ENTITY BCDcount_hour IS
	port(
	KEY0, SW9, CLK	:IN 	STD_LOGIC;
	SET_HIGH, SET_LOW :IN STD_LOGIC_VECTOR(3 downto 0);
	CARRY    :OUT STD_LOGIC;
	MSD, LSD :OUT STD_LOGIC_VECTOR (0 to 6) 
	);
END BCDcount_hour;

ARCHITECTURE a of BCDcount_hour is
	SIGNAL Internal_Count:	STD_LOGIC_VECTOR(28 downto 0);
	SIGNAL HighDigit: STD_LOGIC_VECTOR(3 downto 0);
	SIGNAL LowDigit: STD_LOGIC_VECTOR(3 downto 0);
	SIGNAL MSD_7SEG, LSD_7SEG: STD_LOGIC_VECTOR(0 to 6);
BEGIN

	LSD<=LSD_7SEG;
	MSD<=MSD_7SEG;
	

	PROCESS(CLK, KEY0, SW9)
	BEGIN
		if(KEY0='1') then
			LowDigit<="0001";
			HighDigit<="0000";
		elsif(SW9='1') then -- reset
			LowDigit<=SET_LOW;
			HighDigit<=SET_HIGH;
		elsif(CLK'event and CLK='1') then
			if (HighDigit=1) then
				if (LowDigit=2) then
					HighDigit<="0000";
					LowDigit<="0001";
				else
					LowDigit<=Lowdigit+'1';
				end if;
			elsif (HighDigit=0) then
				if (LowDigit=9) then
					LowDigit<="0000";
				if (HighDigit=5) then
					HighDigit<="0000";
					CARRY<='1';
				else 
					HighDigit<=HighDigit+'1';
					CARRY<='0';
				end if;
			else
				LowDigit<=LowDigit+'1';
				CARRY<='0';
			end if;
			end if;
		end if;
	END PROCESS;

	PROCESS(LowDigit, HighDigit)
	BEGIN
		case LowDigit is
			when "0000" => LSD_7SEG <= "0000001";
			when "0001" => LSD_7SEG <= "1001111";
			when "0010" => LSD_7SEG <= "0010010";
			when "0011" => LSD_7SEG <= "0000110";
			when "0100" => LSD_7SEG <= "1001100";
			when "0101" => LSD_7SEG <= "0100100";
			when "0110" => LSD_7SEG <= "0100000";
			when "0111" => LSD_7SEG <= "0001111";
			when "1000" => LSD_7SEG <= "0000000";
			when "1001" => LSD_7SEG <= "0000100";
			when others => LSD_7SEG <= "1111111";
		end case;

		case HighDigit is
			when "0000" => MSD_7SEG <= "0000001";
			when "0001" => MSD_7SEG <= "1001111";
			when "0010" => MSD_7SEG <= "0010010";
			when "0011" => MSD_7SEG <= "0000110";
			when "0100" => MSD_7SEG <= "1001100";
			when "0101" => MSD_7SEG <= "0100100";
			when "0110" => MSD_7SEG <= "0100000";
			when "0111" => MSD_7SEG <= "0001111";
			when "1000" => MSD_7SEG <= "0000000";
			when "1001" => MSD_7SEG <= "0000100";
			when others => MSD_7SEG <= "1111111";
		end case;
	END PROCESS;

end a;

	
