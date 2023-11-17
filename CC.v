module counter_clk (
    input clk_f,
    output clk_s
);

    reg [19:0] count;

    always@(posedge clk_f) begin
        count = count + 1;
    end

    assign clk_s = count[19];

endmodule
