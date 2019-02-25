LIBRARY ieee;
USE IEEE.STD_LOGIC_1164.all;
USE IEEE.STD_LOGIC_ARITH.all;
USE IEEE.STD_LOGIC_UNSIGNED.all;

ENTITY BCDfilter IS
	port(
	BCD_IN	:IN 	 STD_LOGIC_VECTOR(3 downto 0);
	BCD_OUT :OUT STD_LOGIC_VECTOR (3 downto 0) 
	);
END BCDfilter;

ARCHITECTURE a of BCDfilter is
	SIGNAL BCD_FILTERED: STD_LOGIC_VECTOR(3 downto 0);
BEGIN

	BCD_OUT<=BCD_FILTERED;


	PROCESS(BCD_IN, BCD_FILTERED)
	BEGIN
		case BCD_IN is
			when "0000" => BCD_FILTERED <= "0000";
			when "0001" => BCD_FILTERED <= "0001";
			when "0010" => BCD_FILTERED <= "0010";
			when "0011" => BCD_FILTERED <= "0011";
			when "0100" => BCD_FILTERED <= "0100";
			when "0101" => BCD_FILTERED <= "0101";
			when "0110" => BCD_FILTERED <= "0110";
			when "0111" => BCD_FILTERED <= "0111";
			when "1000" => BCD_FILTERED <= "1000";
			when "1001" => BCD_FILTERED <= "1001";
			when others => BCD_FILTERED <= "0000";
		end case;

	END PROCESS;

end a;

	
