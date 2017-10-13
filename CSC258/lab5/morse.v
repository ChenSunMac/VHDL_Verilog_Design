`timescale 1ns / 1ns // `timescale time_unit/time_precision

module morse(SW, CLOCK_50, KEY, LEDR);
	input CLOCK_50;
	input[2:0] SW;
	input [1:0] KEY; // KEY[0]: Asynchronous reset, KEY[1]: load value of SW
	
	output [0:0]LEDR;
	
	reg [11:0] code;
	reg [24:0] counter = 25'd24999999;
	wire pulse;
	
	always@(*)
		case(SW[2:0])
			3'b000: code= 12'b101110000000; //a
			3'b001: code= 12'b111010101000; //b
			3'b010: code= 12'b111010111010; //c
			3'b011: code= 12'b111010100000; //d
			3'b100: code= 12'b100000000000; //e
			3'b101: code= 12'b101011101000; //f
			3'b110: code= 12'b111011101000; //g
			3'b111: code= 12'b101010100000; //h
		endcase

	rateDivider rateDivider(counter, CLOCK_50, pulse);
	shiftRegister a(CLOCK_50, pulse, KEY[0], KEY[1], code, LEDR[0]);		
endmodule

module shiftRegister(clock, enable, reset, load, in, out);
	input clock, reset, load, enable;
	input [11:0] in;
	
	reg [0:11] q;
	
	output reg out;
	
	always @(posedge clock, negedge reset) 
	begin
		if (reset == 1'b0) begin
			q<=0;
			out<=0;
		end
		if (load== 1'b0)
			q<=in;
		else if (enable == 1'b1) begin
			out<=q[0];
			q<=q<<1;
		end
	end
endmodule

module rateDivider(d, clock, enable);
	input [0:27] d;
	input clock;

	reg [0:27] q;
	
	output reg enable;
	
	always@ (posedge clock)
	begin
		if(q==0) begin
			q<=d;
			enable<=0;
		end
		else begin
			q<=q-1;
			enable<=1;
		end	
	end
endmodule
