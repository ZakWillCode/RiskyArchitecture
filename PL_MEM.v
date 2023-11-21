module pipeline_MEM (
    input clk, rst, 

    input   [7:0]   DM,
    input   [7:0]   ALU_ea,

    input   [1:0]   ra,

    input           wb_wb_sel,      //Write Back Stage
    input           wb_data_sel,
    input           wb_reg_en,

    output  reg     [7:0]   DM_out = 8'b0,

    output  reg     [1:0]   ra_out = 1'b0,
    output  reg     [7:0]   ALU_ea_out = 8'b0,

    output  reg             wb_wb_sel_out = 1'b0,      //Write Back Stage Out
    output  reg             wb_data_sel_out = 1'b0,
    output  reg             wb_reg_en_out = 1'b0

);

    always @(posedge clk) begin
    if (rst) begin
      // Clear all registers on reset
      ALU_ea_out <= 8'b0;
      ra_out <= 2'b0;
      DM_out <= 8'b0;
      wb_wb_sel_out <= 1'b0;
      wb_data_sel_out <= 1'b0;
      wb_reg_en_out <= 1'b0;
    end else begin
      // Assign inputs to outputs on positive clock edge
      ALU_ea_out <= ALU_ea;
      ra_out <= ra;
      DM_out <= DM;
      wb_wb_sel_out <= wb_wb_sel;
      wb_data_sel_out <= wb_data_sel;
      wb_reg_en_out <= wb_reg_en;
    end
  end
endmodule 