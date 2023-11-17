module pipeline_EX (
    input clk, rst, 

    input   [7:0]   ALU,

    input   [1:0]   ra,
    input   [7:0]   ea,

    input           mem_wr_en,      //Memory Stage 
    input           mem_imm_sel,

    input           wb_wb_sel,      //Write Back Stage
    input           wb_data_sel,
    input           wb_reg_en,

    output  reg     [7:0]   ALU_out = 8'b0,

    output  reg     [1:0]   ra_out = 2'b0,
    output  reg     [7:0]   ea_out = 8'b0,

    output  reg             mem_wr_en_out = 1'b0,      //Memory Stage Out
    output  reg             mem_imm_sel_out = 1'b0,

    output  reg             wb_wb_sel_out = 1'b0,      //Write Back Stage Out
    output  reg             wb_data_sel_out = 1'b0,
    output  reg             wb_reg_en_out = 1'b0

);

    always @(posedge clk) begin
    if (rst) begin
      // Clear all registers on reset
      ALU_out <= 8'b0;
      ra_out <= 2'b0;
      ea_out <= 8'b0;
      mem_wr_en_out <= 1'b0;
      mem_imm_sel_out <= 1'b0;
      wb_wb_sel_out <= 1'b0;
      wb_data_sel_out <= 1'b0;
      wb_reg_en_out <= 1'b0;
    end else begin
      // Assign inputs to outputs on positive clock edge
      ALU_out <= ALU;
      ra_out <= ra;
      ea_out <= ea;
      mem_wr_en_out <= mem_wr_en;
      mem_imm_sel_out <= mem_imm_sel;
      wb_wb_sel_out <= wb_wb_sel;
      wb_data_sel_out <= wb_data_sel;
      wb_reg_en_out <= wb_reg_en;
    end
  end
endmodule 