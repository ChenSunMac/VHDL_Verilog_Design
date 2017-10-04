module lab3part1(LEDR, SW);
	input [9:0] SW;
	// need the output to be type reg for always block
	output reg LEDR;		
	// need * in the parentheses for combinational block
	always @(*)		
	begin
		case(SW[9:7])
			3'b000: LEDR = SW[0];
			3'b001: LEDR = SW[1];
			3'b010: LEDR = SW[2];
			3'b011: LEDR = SW[3];
			3'b100: LEDR = SW[4];
			3'b101: LEDR = SW[5];
			3'b110: LEDR = SW[6];
			default: LEDR = 0;
		endcase
	end
	
endmodule

