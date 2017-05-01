library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity VHDL_design is
    Port ( CLK		 : in  STD_LOGIC;
           D_in1   : in  STD_LOGIC_VECTOR (7 downto 0);
           D_in2   : in  STD_LOGIC_VECTOR (7 downto 0);
			  D_in3   : in  STD_LOGIC_VECTOR (7 downto 0);
			  D_in4   : in  STD_LOGIC_VECTOR (7 downto 0);
			  D_in5   : in  STD_LOGIC_VECTOR (7 downto 0);
			  D_in6   : in  STD_LOGIC_VECTOR (7 downto 0);
			  D_in7   : in  STD_LOGIC_VECTOR (7 downto 0);
			  D_in8   : in  STD_LOGIC_VECTOR (7 downto 0);
			  D_in9   : in  STD_LOGIC_VECTOR (7 downto 0);
			  D_in10   : in  STD_LOGIC_VECTOR (7 downto 0);
			  D_in11   : in  STD_LOGIC_VECTOR (7 downto 0);	  
           Sel   : in STD_LOGIC_VECTOR (3 downto 0);
			  
			  R_out	:	out STD_LOGIC_VECTOR (7 downto 0) );
end VHDL_design;


architecture Behavioral of VHDL_design is

signal  R1,R2,R3,R4,R5,R6,R7,R8,R9,R10,R11 : STD_LOGIC_VECTOR (7 downto 0);

begin


P : PROCESS (CLK)

BEGIN
	 IF (rising_edge(CLK)) THEN
		R1 <= D_in1;
	   R2 <= D_in2;
		R3 <= D_in3;
		R4 <= D_in4;
		R5 <= D_in5;
		R6 <= D_in6;
		R7 <= D_in7;
		R8 <= D_in8;
		R9 <= D_in9;
		R10 <= D_in10;
		R11 <= D_in11;
		CASE Sel IS
			WHEN "0001"  => R_out <= R1;
			WHEN "0010"  => R_out <= R2;
			WHEN "0011"  => R_out <= R3;
			WHEN "0100"  => R_out <= R4;
			WHEN "0101"  => R_out <= R5;
			WHEN "0110"  => R_out <= R6;
			WHEN "0111"  => R_out <= R7;
			WHEN "1000"  => R_out <= R8;
			WHEN "1001"  => R_out <= R9;
			WHEN "1010"  => R_out <= R10;
			WHEN "1011"  => R_out <= R11;
			when others=> R_out<= "00000000";
		END CASE;


   END IF;
END PROCESS;

end Behavioral;
