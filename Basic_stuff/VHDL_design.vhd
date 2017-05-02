//D - Flip Flop

entity DFF1 is

Port ( d,res,clk : in STD_LOGIC;
q : out STD_LOGIC);

end DFF1;

architecture Behavioral of DFF1 is

begin
process(clk)
begin
if (res ='1')then q<='0';
elsif clk'event and clk='1'
then q<=d;
end if;
end process;
end Behavioral;