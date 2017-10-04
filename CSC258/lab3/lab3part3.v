module lab3part3(SW, KEY, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, LEDR);
  output [6:0] HEX5;
  output [6:0] HEX4;
  output [6:0] HEX3;
  output [6:0] HEX2;
  output [6:0] HEX1;
  output [6:0] HEX0;
  output reg [7:0] LEDR;
  input [7:0] SW;
  input [2:0] KEY;
  wire [7:0] x;
	fulladder fa(x, SW);
	integer my_int;
	always @(*)
	begin
		case(KEY[2:0])
			3'b000: LEDR[7:0] = x;
			3'b001: LEDR[7:0] = {SW[7:4] + SW[3:0], 4'b000};
			3'b010: LEDR[7:0] =  {SW[7:4] ^ SW[3:0] , SW[7:4] | SW[3:0]};
			3'b011:  
			  begin
					my_int = SW[7:4]|SW[3:0];
					begin
						if (my_int > 0)
							LEDR[7:0] = 8'b00000001;
					end
			  end
			3'b100:
			  begin
					my_int = SW[7:4]&SW[3:0];
					begin
						if (my_int == 511)
							LEDR[7:0] = 8'b00000001;
					end
			  end
		  3'b101: LEDR[7:0] = {SW[7:4], SW[3:0]};	
			default: LEDR[7:0] = 8'b0000000;
		endcase
	end
	// set HEX1 and HEX3 to 0
 assign HEX1 = 0;
 assign HEX3 = 0;
 
	// set HEX0 to B in hex
	display_hex d2(HEX0[6:0], SW[3:0]);
	
	
  //	 set HEX2 to A in hex
	display_hex d3(HEX2[6:0], SW[7:4]);
	
	
//	 set HEX4 to LEDR[3:0] in hex
	display_hex d4(HEX4[6:0], LEDR[3:0]);
	
	
//	 set HEX5 to LEDR[7:4] in hex
	display_hex d5(HEX5[6:0], LEDR[7:4]);
endmodule


// 4-bits converted to the 7-segment display
module display_hex(HEX, SW);
    input [3:0] SW;
    output [6:0] HEX;

	 assign HEX[0] = ~SW[0] & ~SW[1] & ~SW[2] & SW[3] | ~SW[0] & SW[1] & ~SW[2] & ~SW[3] | SW[0] & SW[1] & ~SW[2] & SW[3] | SW[0] & ~SW[1] & SW[2] & SW[3];
	 assign HEX[1] = SW[1] & SW[2] & ~SW[3] | SW[0] & SW[1] & ~SW[3] | SW[0] & SW[2] & SW[3] | ~SW[0] & SW[1] & ~SW[2] & SW[3];
	 assign HEX[2] = ~SW[0] & ~SW[1] & SW[2] & ~SW[3] | SW[0] & SW[1] & SW[2] | SW[0] & SW[1] & ~SW[3];
	 assign HEX[3] = ~SW[0] & ~SW[1] & ~SW[2] & SW[3] | ~SW[0] & SW[1] & ~SW[2] & ~SW[3] | SW[1] & SW[2] & SW[3] | SW[0] & ~SW[1] & SW[2] & ~SW[3];
	 assign HEX[4] = ~SW[0] & SW[3] | ~SW[1] & ~SW[2] & SW[3] | ~SW[0] & SW[1] & ~SW[2];
	 assign HEX[5] = SW[0] & SW[1] & ~SW[2] & SW[3] | ~SW[0] & ~SW[1] & SW[3] | ~SW[0] & ~SW[1] & SW[2] | ~SW[0] & SW[2] & SW[3];
	 assign HEX[6] = ~SW[0] & ~SW[1] & ~SW[2] | ~SW[0] & SW[1] & SW[2] & SW[3] | SW[0] & SW[1] & ~SW[2] & ~SW[3];

endmodule

 //Case 0: Adder from Part 2
//module regularAdditoin(i,o);
//  input [7:0] i;
 // output [9:0] o;
	//assign o = i[3:0] + i[7:4];
//endmodule

// returns 8'b00000001 if not 8'h00
module check_zero();
	
endmodule
	
 //Case 4
module check_max();
	
endmodule

 //Case 5: Concatenate A and B together

// ==============================
// PART 2 STUFF
// ==============================
module fulladder(LEDR, SW);
	input [9:0] SW;
	output [9:0] LEDR;

	wire w1,w2,w3;
	adder a1(
		.c_in(SW[8]),
    .a(SW[4]),
	  .b(SW[0]),
	  .s(LEDR[0]),
	  .c_out(w1)	
	);;
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
	  .c_out(LEDR[9])	// changed this from LEDR[3] to LEDR[9]
	);

endmodule

module adder(c_in, a, b, s, c_out);
  input c_in,a,b;
	output s,c_out;
	wire w1;

  mux2to1 m1(
		.a(c_1),
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