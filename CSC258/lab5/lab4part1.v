

/**
* Creating an 8-bit asynchronous clear counter
*/
module lab4part1(SW, KEY, HEX1, HEX0);

	input [0:0] KEY;			// KEY[0] = clock

	// SW[1] = enable
	// SW[0] = clear_b
	input [1:0] SW;

	output [6:0] HEX1;	// more significant
	output [6:0] HEX0;	// less significant
	
	wire [7:0] num;	// the counter number


	tflipflop t0(.t(SW[1]), .clock(KEY[0]), .clear_b(SW[0]), .q(num[0]));
	tflipflop t1(.t(SW[1] & num[0]), .clock(KEY[0]), .clear_b(SW[0]), .q(num[1]));
	tflipflop t2(.t(SW[1] & num[1] & num[0]), .clock(KEY[0]), .clear_b(SW[0]), .q(num[2]));
	tflipflop t3(.t(SW[1] & num[2] & num[1] & num[0]), .clock(KEY[0]), .clear_b(SW[0]), .q(num[3]));
	tflipflop t4(.t(SW[1] & num[3] & num[2] & num[1] & num[0]), .clock(KEY[0]), .clear_b(SW[0]), .q(num[4]));
	tflipflop t5(.t(SW[1] & num[4] & num[3] & num[2] & num[1] & num[0]), .clock(KEY[0]), .clear_b(SW[0]), .q(num[5]));
	tflipflop t6(.t(SW[1] & num[5] & num[4] & num[3] & num[2] & num[1] & num[0]), .clock(KEY[0]), .clear_b(SW[0]), .q(num[6]));
	tflipflop t7(.t(SW[1] & num[6] & num[5] & num[4] & num[3] & num[2] & num[1] & num[0]), .clock(KEY[0]), .clear_b(SW[0]), .q(num[7]));
	
	// display the result on the hex
	hex h1(.in(num[7:4]), .out(HEX1[6:0]));
	hex h0(.in(num[3:0]), .out(HEX0[6:0]));
endmodule


/**
* Module for the t flip flop
*/
module tflipflop(t, clock, clear_b, q);
	input t, clock, clear_b;
	output reg q;
	
	// TODO: how to always check for the value of clear_b?
	// compiler won't let me check posedge and negedge
	always@(posedge clock, negedge clear_b)
	begin
	if (clear_b == 0)
		q <= 0;
	else if (clock && t)
		q <= ~q;		// toggle
	
	else
		q <= q;		// keep old value
	end
	
endmodule

// convert signals into a hex display, changed from [0:6] to [6:0]
module hex(out,in);
	input [3:0]in;
	output reg [6:0]out;
	always@(in)
		case(in)
			0 : out=7'b1000000;
			1 : out=7'b1111001;
			2 : out=7'b0101000;
			3 : out=7'b0110000;
			4 : out=7'b0011001;
			5 : out=7'b0010010;
			6 : out=7'b0000010;
			7 : out=7'b1111000;
			8 : out=7'b0000000;
			9 : out=7'b0010000;
			10 : out=7'b0001000;
			11 : out=7'b0000011;
			12 : out=7'b1000110;
			13 : out=7'b0100001;
			14 : out=7'b0000110;
			15 : out=7'b0001110;
			default: out=7'b0000000;
		endcase
endmodule
