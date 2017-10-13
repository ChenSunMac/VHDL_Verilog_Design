`timescale 1ns / 1ns // `timescale time_unit/time_precision
/**
The main module for an 8 bit right switcher with an optional arithmetic right switch option

Date Due: Feb 8, 2016
*/
module lab3part3(SW, KEY, LEDR);


	// SW[7:0] = LoadVal[7:0]
	// SW[9] = synchronous active low reset
	input [9:0] SW;


	// KEY[0] = clock input: BEWARE OF SWITCH BOUNCING
	// KEY[1] = Load_n input
	// KEY[2] = ShiftRight input
	// KEY[3] = ASR input
	input [3:0] KEY;
	
	output [7:0] LEDR;


	reg first_in; 
	always @ (*)
	begin
	  case (KEY[3]	)
		  0: begin first_in = 0; end
		  1: begin first_in = SW[7]; end
		endcase
	end	
	
	
	shifter_bit b7(.load_val(SW[7]), .reset_n(SW[9]), .clk(KEY[0]), .load_n(KEY[1]), .shift(KEY[2]), .in(first_in), .out(LEDR[7]));
	shifter_bit b6(.load_val(SW[6]), .reset_n(SW[9]), .clk(KEY[0]), .load_n(KEY[1]), .shift(KEY[2]), .in(LEDR[7]), .out(LEDR[6]));
	shifter_bit b5(.load_val(SW[5]), .reset_n(SW[9]), .clk(KEY[0]), .load_n(KEY[1]), .shift(KEY[2]), .in(LEDR[6]), .out(LEDR[5]));
	shifter_bit b4(.load_val(SW[4]), .reset_n(SW[9]), .clk(KEY[0]), .load_n(KEY[1]), .shift(KEY[2]), .in(LEDR[5]), .out(LEDR[4]));
	shifter_bit b3(.load_val(SW[3]), .reset_n(SW[9]), .clk(KEY[0]), .load_n(KEY[1]), .shift(KEY[2]), .in(LEDR[4]), .out(LEDR[3]));
	shifter_bit b2(.load_val(SW[2]), .reset_n(SW[9]), .clk(KEY[0]), .load_n(KEY[1]), .shift(KEY[2]), .in(LEDR[3]), .out(LEDR[2]));
	shifter_bit b1(.load_val(SW[1]), .reset_n(SW[9]), .clk(KEY[0]), .load_n(KEY[1]), .shift(KEY[2]), .in(LEDR[2]), .out(LEDR[1]));
	shifter_bit b0(.load_val(SW[0]), .reset_n(SW[9]), .clk(KEY[0]), .load_n(KEY[1]), .shift(KEY[2]), .in(LEDR[1]), .out(LEDR[0]));
endmodule




/**
Module for a 2-to-1 mux
*/
module mux2to1(a, y, s, m);
    input a; //selected when s is 0
    input y; //selected when s is 1
    input s; //select signal
    output m; //output


    assign m = s & y | ~s & a;
endmodule


/**
D Flip flop shown in Figure 2 of Lab 3
*/
module dflipflop(d, q, clock, reset_n);
	input d, clock, reset_n;


	output reg q;


	always @(posedge clock)
	case(reset_n)
			0:
			  begin		// A+B using adder from Lab 2 part 2

					q = 0;
				end
			1:
				begin

					q = d;
				end
			default: q = 0;
		endcase
endmodule



/**
Module for each ShiftBit as shown in the image in Figure 5 of Lab 3
*/
module shifter_bit(load_val, reset_n, clk, load_n, shift, in, out);
	input load_val, reset_n, clk, load_n, shift, in;
	output out;


	wire muxtomux;
	wire muxtoff;		// muxtoff == mux to flip flop


	mux2to1 m1(.a(out), .y(in), .s(shift), .m(muxtomux));
	mux2to1 m2(.a(load_val), .y(muxtomux), .s(load_n), .m(muxtoff));


	dflipflop d1(.d(muxtoff), .q(out), .clock(clk), .reset_n(reset_n));
endmodule
