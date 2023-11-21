module pl_risc_tb ();

	reg 	[0:7] 	in_port = 8'b0;
	reg 	clk, rst;
	
	wire 	[7:0]	out_port;

	PL_RISC_TL pl_risc_tl(
		.clk(clk),
		.rst(rst),
		.in_port(in_port),
		.out_port(out_port)
	);
	
	initial begin
		#10 
		clk = 1;
		rst = 1;
		#10
		clk = 0;
		#10
		clk = 1;
		#10
		clk = 0;
		#10
		clk = 1;
		rst = 0;
		forever begin
		#10 clk = !clk;
		end
	end

endmodule