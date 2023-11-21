module out_reg (
    input   clk,
    input   rst,

    input   en,
    input           [7:0]   reg_data1,

    output  reg     [7:0]   out_port     =   8'b0
);

    always @(negedge clk) begin
        if (rst) begin
            out_port <= 8'b0;
        end else if (en) begin
            out_port <= reg_data1;
        end
    end

endmodule