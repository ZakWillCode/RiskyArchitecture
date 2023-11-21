module pipeline_IF (
    input clk, rst, 

    input [7:0]  PC2_in,
    input [15:0] inst_in,

    output  reg     [7:0]   PC2_out = 8'b0,

    output  reg     [1:0]   ra = 2'b0, rb = 2'b0,
    output  reg     [7:0]   ea = 8'b0,
    output  reg     [15:0]  inst_out = 16'b0

);

    always @(posedge clk) begin
        if (rst) begin
            PC2_out <=  8'b00000000;
            ra <=       2'b00;
            rb <=       2'b00;
            ea <=       8'b00000000;
            inst_out <= 16'b0000000000000000;
        end
        else begin
            PC2_out <= PC2_in;
            inst_out <= inst_in;

            ra <= inst_in[11:10];
            rb <= inst_in[9:8];
            ea <= inst_in[7:0];
        end 
    end 
endmodule 