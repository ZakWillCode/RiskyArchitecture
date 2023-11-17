module link_reg (
    input   clk,
    input   rst,

    input   en,
    input           [7:0]   PC2,

    output  reg     [7:0]   LR     =   8'b0;
);

    always @(negedge clk) begin
        if (rst) begin
            LR <= 8'b0;
        end else if (en) begin
            LR <= PC2;
        end
    end

endmodule