`timescale 1ns / 1ns // `timescale time_unit/time_precision

module lab4part2(SW, CLOCK_50, HEX0);
  input [9:0]SW;
	input CLOCK_50;
	output reg [6:0]HEX0;
  

	reg Enable;
	reg [27:0]counter;
  
	reg [3:0]hexc;
	wire[6:0] out;
  hex h2(.out(out), .in(hexc[3:0]));
  /*
	* SW:
		* 1:0 speed
		* 2   clear
		* hex0 display
	*/
  always@(posedge CLOCK_50)
	begin
		// reset case
	  if (SW[2] == 1'b0)
	    counter <= 0;
		// case 1hz
		else
		begin
			counter <= counter - 1; 
			// case 1hz
			if(SW[1:0] == 2'b01 && counter == 0)
			begin
				counter <= 50000000 - 1;
		    Enable <= (counter == 0) ? 1:0;
			end
			// case .5hz
			else if(SW[1:0] == 2'b10 && counter == 0)
			begin
				counter <= 100000000 - 1; 
			end
			// case .25hz
			else if(SW[1:0] == 2'b11 && counter == 0)
			begin
				counter <= 200000000 - 1;
			end
			// case full
			else if(SW[1:0] == 2'b00 && counter == 0)
			begin
				counter <= 1;
			end
		end
		Enable <= (counter == 0) ? 1:0;
		if (Enable == 1)
			hexc <= hexc + 1;
      case(hexc)
			0 : HEX0 = 7'b1000000;
			1 : HEX0 =7'b1111001;
			2 : HEX0 =7'b0101000;
			3 : HEX0 =7'b0110000;
			4 : HEX0 =7'b0011001;
			5 : HEX0 =7'b0010010;
			6 : HEX0 =7'b0000010;
			7 : HEX0 =7'b1111000;
			8 : HEX0 =7'b0000000;
			9 : HEX0 =7'b0010000;
			10 : HEX0 =7'b0001000;
			11 : HEX0 =7'b0000011;
			12 : HEX0 =7'b1000110;
			13 : HEX0 =7'b0100001;
			14 : HEX0 =7'b0000110;
			15 : HEX0 =7'b0001110;
			default: HEX0 =7'b0000000;
		endcase

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

/*
* Cycle to the next letter iff enable is 1
* Letters 0 - f
*/
// module hexLooper(current, enable, next);
//   input [3:0] current;
// 	input enable;
// 	output reg [3:0] next;
// 
// 	if (enable == 1'b1) 
//     assign next <= current + 4'b0001;	
//   else
// 	  assign next <= current;
// 
// endmodule	

