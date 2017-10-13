

/**
* Encompassing module for the morse code encoder
*/
module lab4part3(CLOCK_50, SW, KEY, LEDR);
	input CLOCK_50;
	input [2:0] SW;	// choose which letter to output
	
	// KEY[0]: Asynchronous reset
	// KEY[1]: load the value of SW
	input [1:0] KEY;
	output reg [0:0] LEDR;	// outputs the Morse Code
	
	// goes up to 33 million
	reg [24:0] counter = 25'd24999999;
	reg [11:0] code;
	reg [3:0] Enable;
	reg [3:0] index;
	initial
	  index = 0;
		
	always @ (posedge KEY[1], posedge CLOCK_50)
	begin
		case(SW[1:0])
			0: code <= 12'b1011_1000_0000;
			1: code <= 12'b1110_1010_1000;
			2: code <= 12'b1110_1011_1010;
			3: code <= 12'b1110_1010_0000;
			4: code <= 12'b1000_0000_0000;
			5: code <= 12'b1010_1110_1000;
			6: code <= 12'b1110_1110_1000;
			7: code <= 12'b1010_1010_0000;
		endcase
	
		// somehow release each bit every 0.5 seconds
			
		// count up to 25 million
		
		Enable <= (counter == 0) ? 1 : 0;
		
		counter <= counter - 1;
		
		
		if (counter == 0)
		begin
			counter <= 25'd25000000 - 1;
		end
		
		if (Enable == 1) 
		begin
			LEDR <= code[index];
			index <= index + 1;
			if (index == 4'd12)
			    index <= 0;
		end
	
		// asynchronous reset
		if (KEY[0] == 1)
			code <= 12'b0;
			
	end
	
	
	
endmodule
