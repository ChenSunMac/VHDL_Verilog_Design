//MUX 4_1

entity Mux_4 is 
	port (
	in1 : in std_logic; -- mux input1
in2 : in std_logic; -- mux input2
in3 : in std_logic; -- mux input3
in4 : in std_logic; -- mux input4
sel : in std_logic_vector(1 downto 0); -- selection line
dataout : out std_logic); 
end Mux_4

architecture behavior of Mux_4 is

begin

process(sel,in1,in2,in3,in4)
begin

case sel is
when "00" => dataout <= in1;
when "01" => dataout <= in2;
when "10" => dataout <= in3;
when "11" => dataout <= in4;

end process

end behavioral;