module cc_tb ();

	reg 	clk, rst;
	
	wire 	clk_s;

	counter_clk uut(
		.clk_f(clk),
		.clk_s(clk_s),
		.rst(rst)
	);
	
	initial begin
		#5 
		clk = 1;
		rst = 1;
		#5
		clk = 0;
		#5
		clk = 1;
		#5
		clk = 0;
		#5
		clk = 1;
		rst = 0;
		forever begin
		#5 clk = !clk;
		end
	end

endmodule