//D - Latch

entity DLatch is 
	port (
	signal d, clk: in std_logic;
	signal q: out std_logic
);

architecture behavior of DLatch1 is

state: process (clk,d)
	if (clk = '1') then
		q <= d;
	end if;
	end process;
end behavior;