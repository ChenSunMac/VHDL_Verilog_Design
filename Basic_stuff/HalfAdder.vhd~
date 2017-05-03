-- Half Adder
-- A VHDL code has Entity, Architecture and package part.


-- ENTITY declares the in and out (black box)
entity half_adder is
	port (
	din1, din2: std_logic;
	sum,carry:out std_logic
	     );
end half_adder

-- Architecture defines the functionality of the circuit
-- respect to ports

architecture behavior of half_adder is
begin
	sum <= din1 xor din2;
	carry <= din1 and din2;
end behavior



