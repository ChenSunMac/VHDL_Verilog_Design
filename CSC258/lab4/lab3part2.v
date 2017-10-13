module lab3part2(SW, KEY, LEDR, HEX0, HEX2, HEX4, HEX5, HEX1, HEX3);
	input [3:0]KEY;		// KEY[0] as clock, KEY[3:1] as ALU function input
	input [9:0]SW;			// use [3:0] as Data input, SW[9] as Reset_b
	output reg [7:0]LEDR;	// output of ALU & register in binary

	wire [4:0]rippleout;
	wire [4:0]sumout;
	wire [7:0]xorabout;
	wire [7:0]sigabout;
	wire singleorout;
	wire singleandout;
	wire [3:0]leftshiftout;
	wire [3:0]rightshiftout;
	wire [7:0]productout;

	output [0:6]HEX0;		// displays the hex value of Data (SW[3:0])
	output [0:6]HEX1;		// set to 0 or blank
	output [0:6]HEX2;		// set to 0 or blank
	output [0:6]HEX3;		// set to 0 or blank
	output [0:6]HEX4;		// least-significant 4 bits of Register
	output [0:6]HEX5;		// most-significant 4 bits of Register

	
	// results of all parts of ALU
	ripplecarry4bit a(.a(SW[7:4]), .b(LEDR[3:0]), .cin(SW[8]), .s(rippleout[3:0]), .cout(rippleout[4]));
	add b(.a(SW[7:4]), .b(LEDR[3:0]), .sum(sumout[4:0]));
	xorab c(.a(SW[7:4]), .b(LEDR[3:0]), .out(xorabout[7:0]));
	singleor d(.a(SW[7:4]), .b(LEDR[3:0]), .out(singleorout));
	singleand e(.a(SW[7:4]), .b(LEDR[3:0]), .out(singleandout));
	//sigab f(.a(SW[7:4]), .b(LEDR[3:0]), .out(sigabout[7:0]));

	leftshift f(.a(SW[7:4]), .b(LEDR[3:0]), .out(leftshiftout[3:0]));
	rightshift g(.a(SW[7:4]), .b(LEDR[3:0]), .out(rightshiftout[3:0]));
	multiply h(.a(SW[7:4]), .b(LEDR[3:0]), .product(productout[7:0]));

	// HEX0 displays the value of the input SW[3:0]
	hex h0(.in(SW[3:0]), .out(HEX0[0:6]));
	// set HEX1, HEX2 and HEX3 to 0 or blank
	hex h2(.in(4'b0000), .out(HEX2[0:6]));
	hex h1(.in(4'b0000), .out(HEX1[0:6]));
	hex h3(.in(4'b0000), .out(HEX3[0:6]));


	always@(*)
	begin
		case(KEY[3:1])
		// 2016: just load A into LEDR[7:4], B -> LEDR[3:0]
			0: begin		// A+B using adder from Lab 2 part 2, output is 5 bits
				LEDR[4:0]= rippleout[4:0];
				LEDR[7:5]=0;
				end
			1: begin		// A+B using the + operator
				LEDR[4:0]= sumout[4:0];
				LEDR[7:5]=0;
				end
			2: begin		// A XOR B and A OR B
				LEDR[7:0]= xorabout[7:0];
				end
			3: begin 	// return 1 if not 0 with one OR
				LEDR[0]= singleorout;
				LEDR[7:1]=0;
				end
			4: begin 	// check if all ones with one AND
				LEDR[0]= singleandout;
				LEDR[7:1]=0;
				end
			5: begin		// left shift B by A bits
				LEDR[3:0] = leftshiftout[3:0];
				LEDR[7:4] = 0;
				end
			6: begin		// right shift B by A bits (logical shift >>)
				LEDR[3:0] = rightshiftout[3:0];
				LEDR[7:4] = 0;
				end
			7: begin
				LEDR[7:0] = productout[7:0];
				end
			default: LEDR[7:0]=7'b0000000;
		endcase
		case(KEY[0])
			0:
			begin
					LEDR[7:0] = 0;
				end
			1:
				 begin
					LEDR[7:0]= LEDR[7:0];
				end
			default: LEDR[7:0]=0;
		endcase
	end

	// display output of the output
	hex h4(.in(LEDR[3:0]), .out(HEX4[0:6]));
	hex h5(.in(LEDR[7:4]), .out(HEX5[0:6]));
endmodule








// ================================================
// ==============MODULES===========================
// ================================================
// ripplecarry4bit input
module ripplecarry4bit(a,b,cin,s,cout);
	input [3:0]a;
	input [3:0]b;
	input cin;
	wire w1,w2,w3;
	output [3:0]s;
	output cout;

	// series of full adders
	fa add0(.a(a[0]), .b(b[0]), .cin(cin), .s(s[0]), .cout(w1));
	fa add1(.a(a[1]), .b(b[1]), .cin(w1), .s(s[1]), .cout(w2));
	fa add2(.a(a[2]), .b(b[2]), .cin(w2), .s(s[2]), .cout(w3));
	fa add3(.a(a[3]), .b(b[3]), .cin(w3), .s(s[3]), .cout(cout));
endmodule

// full adder module
module fa(a,b,cin,s,cout);
	input a, b, cin;
	output s, cout;

	assign s= a^b^cin;
	assign cout= (b&a) | (a&cin) | (b&cin);
endmodule

// convert signals into a hex display
module hex(out,in);
	input [3:0]in;
	output reg [0:6]out;
	always@(in)
		case(in)
			0 : out=7'b0000001;
			1 : out=7'b1001111;
			2 : out=7'b0010010;
			3 : out=7'b0000110;
			4 : out=7'b1001100;
			5 : out=7'b0100100;
			6 : out=7'b0100000;
			7 : out=7'b0001111;
			8 : out=7'b0000000;
			9 : out=7'b0000100;
			10 : out=7'b0001000;
			11 : out=7'b1100000;
			12 : out=7'b0110001;
			13 : out=7'b1000010;
			14 : out=7'b0110000;
			15 : out=7'b0111000;
			default: out=7'b0000000;
		endcase
endmodule

module add(a, b, sum);
	input [3:0]a;
	input [3:0]b;
	output [4:0] sum;

	assign sum= a+b;
endmodule

module xorab(a,b,out);
	input [3:0]a;
	input[3:0]b;
	output [7:0]out;

	assign out1= a^b;
	assign out2= a|b;

	assign out= {a|b, a^b};
endmodule

module singleor(a,b,out);
	input [3:0]a;
	input [3:0]b;
	output out;

	assign out= |{b,a};
endmodule

module singleand(a,b,out);
	input [3:0]a;
	input [3:0]b;
	output out;

	assign out= &{b,a};
endmodule

// Case 5
module leftshift(a, b, out);
	input [3:0]a;
	input [3:0]b;
	output [3:0]out;

	assign out = a <<< b;
endmodule

// Case 6
module rightshift(a, b, out);
	input [3:0]a;
	input [3:0]b;
	output [3:0]out;

	assign out = a >> b;
endmodule

// multiply for the ALU's case 7
module multiply(a, b, product);
	input [3:0]a;
	input [3:0]b;
	output [7:0] product;

	assign product[3:0]= a*b;
	assign product[7:4] = 0;
endmodule
