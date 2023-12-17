module counter_clk (
    input clk_f, rst,
    output clk_s
);

    reg [15:0] count ;

    always@(posedge clk_f) begin
	if (rst) begin
		count <= 20'h00000;
	end else begin
        	count <= count + 1;
	end
    end

    assign clk_s = count[15];

endmodule
