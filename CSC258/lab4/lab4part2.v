module shifterbit(load_val, in, shift, load_n, clk, reset_n, out);
input load_val, load_n, in ....;
output reg out;

    

always @(posedge clk) 
begin
	if (reset_n == 1’b0) 
		out <= 0;
	else
		out <= d;
end



endmodule


module mux2to1 