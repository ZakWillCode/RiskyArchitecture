module PC (
	
	input clk, rst,
	input pc_en,
	input [7:0] pc_in,

	output reg [7:0] pc_out = 8'b0

);
	always @(posedge clk) begin
		if (rst) begin
			pc_out <= 8'b0;
		end 
		else if (pc_en) begin
			pc_out <= pc_in;
		end
	end
endmodule