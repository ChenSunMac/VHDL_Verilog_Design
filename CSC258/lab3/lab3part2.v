module lab3part2(LEDR, SW);
  	input [9:0] SW;
	output [9:0] LEDR;

	// A = SW[7:4]
	// B = SW[3:0]
	// c_in = SW[8]
	// S is LEDR[3:0]
	// c_out is LEDR[9]
	
	wire w1,w2,w3;
	adder a1(
		.c_in(SW[8]),
    .a(SW[4]),
	  .b(SW[0]),
	  .s(LEDR[0]),
	  .c_out(w1)	
	);
	adder a2(
		.c_in(w1),
    .a(SW[5]),
	  .b(SW[1]),
	  .s(LEDR[1]),
	  .c_out(w2)	
	);
	adder a3(
		.c_in(w2),
    .a(SW[6]),
	  .b(SW[2]),
	  .s(LEDR[2]),
	  .c_out(w3)	
	);
	adder a4(
		.c_in(w3),
    	.a(SW[7]),
	  	.b(SW[3]),
	  	.s(LEDR[3]),
	  	.c_out(LEDR[9])	
	);

endmodule

module adder(c_in, a, b, s, c_out);
  input c_in,a,b;
	output s,c_out;
	wire w1;

  mux2to1 m1(
		.a(c_in),
		.b(b),
		.s(a^b),
		.o(c_out)
	);
	
	assign s = (a^b)^c_in;

endmodule

module mux2to1(a,b,s,o);
  	input a,b,s;
	output o;

	assign o = a & ~s | b & s;
endmodule
