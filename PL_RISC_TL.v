module PL_RISC_TL (
    input           clk, rst,
    input   [7:0]   in_port,

    output  [7:0]   out_port
)
    //PC
    wire [7:0] pc_in, pc_out;
    wire [15:0] inst;

    //IF
    wire [7:0]  PC2;
    wire [7:0]   PC2IF;
    wire [1:0]   ra, rb;
    wire [7:0]   ea;
    wire [15:0]  inst_IF;

    //REG
    wire [7:0] reg_data1, reg_data2;

    //ID
    wire    [7:0]   ea;  
    wire            ex_lr_en;       //Instruction Execution Stage
    wire            ex_brx;
    wire    [3:0]   ex_alu_sel;
    wire    [1:0]   ex_br_sel_ID;
    wire            mem_wr_en;      //Memory Stage 
    wire            mem_imm_sel;
    wire            wb_wb_sel;      //Write Back Stage
    wire            wb_data_sel;
    wire            wb_reg_en;
    wire    [7:0]   A_ID, B_ID;
    wire    [7:0]   PC2_ID;
    wire    [1:0]   ra_ID;
    wire    [7:0]   ea_ID;
    wire            ex_lr_en_ID;       //Instruction Execution Stage Out
    wire            ex_brx_ID;
    wire    [3:0]   ex_alu_sel_ID;
    wire            mem_wr_en_ID;      //Memory Stage Out
    wire            mem_imm_sel_ID;
    wire            wb_wb_sel_ID;      //Write Back Stage Out
    wire            wb_data_sel_ID;
    wire            wb_reg_en_ID;

    wire    [7:0]   LR;

    //DH WB
    wire    [7:0]   A_dh_out, B_dh_out;

    //ALU
    wire    [7:0]   flag;

    //Branch
    wire            brx; //brx 
    wire            _Z, _N;
    wire    [3:0]   ex_alu_sel;
    wire    [1:0]   ex_br_sel;
    wire            br_en;
    wire            br_taken;
    wire            br_sel;
    wire            br_type_sel;

    //Ex
    wire    [7:0]   ALU_EX;
    wire    [1:0]   ra_EX;
    wire    [7:0]   ea_EX;
    wire            mem_wr_en_EX;
    wire            mem_imm_sel_EX;
    wire            wb_wb_sel_EX;
    wire            wb_data_sel_EX;
    wire            wb_reg_en_EX;

    //MEM
    wire    [7:0]   DM_MEM;
    wire    [1:0]   ra_MEM;
    wire    [7:0]   ALU_ea_MEM;
    wire            wb_wb_sel_MEM;
    wire            wb_data_sel_MEM;
    wire            wb_reg_en_MEM;

    //DM
    wire    [7:0]   DM;

    PC PC (
        .clk(clk),
        .rst(rst),
        .pc_in(pc_in),
        .pc_out(pc_out)
    );

    inst_mem IM (
        .pc(pc_out),
        .inst(inst)
    );

    PC2 PC2 (
        .PC(pc_out),
        .PC2(PC2)
    );

    pipeline_IF PL_IF (
        .clk(clk),
        .rst(rst),
        .PC2_in(PC2),
        .PC2_out(PC2IF),
        .inst_in(inst)
        .ra(ra),
        .rb(rb),
        .ea(ea),
        .inst_out(inst_IF)
    );

    mux2_1 reg_write (
        .A(wb_data),
        .B(in_port),
        .sel(wb_data_sel),
        .Y(data)
    );

    register REG (
        .clk(clk),
        .rst(rst),
        .ra(ra),
        .rb(rb),
        .wb(ra_out),
        .data(data),
        .reg_data1(reg_data1),
        .reg_data2(reg_data2)
    );

    out_reg out_reg (
        .clk(clk),
        .rst(rst),
        .en(id_out_en),
        .reg_data1(reg_data1),
        .out_port(out_port)
    );

    controller_CPU controller_CPU (
        .inst(inst_IF),
        .id_out_en(id_out_en),
        .ex_lr_en(ex_lr_en),
        .ex_brx(ex_brx),
        .ex_alu_sel(ex_alu_sel),
        .ex_br_sel(ex_br_sel),
        .mem_wr_en(mem_wr_en),
        .mem_imm_sel(mem_imm_sel),
        .wb_wb_sel(wb_wb_sel),
        .wb_data_sel(wb_data_sel),
        .wb_reg_en(wb_reg_en)
    );

    pipeline_ID PL_ID (
        .A(reg_data1),
        .B(reg_data2),
        .PC2(PC2), 
        .ra(ra),
        .ea(ea),  
        .ex_lr_en(ex_lr_en),       
        .ex_brx(ex_brx),
        .ex_alu_sel(ex_alu_sel),
        .ex_br_sel(ex_br_sel),
        .mem_wr_en(mem_wr_en),      
        .mem_imm_sel(mem_imm_sel),
        .wb_wb_sel(wb_wb_sel),      
        .wb_data_sel(wb_data_sel),
        .wb_reg_en(wb_reg_en),
        .A_out(A_ID), 
        .B_out(B_ID),
        .PC2_out(PC2_ID),
        .ra_out(ra_ID),
        .ea_out(ea_ID),
        .ex_lr_en_out(ex_lr_en_ID),   
        .ex_brx_out(ex_brx_ID),
        .ex_alu_sel_out(ex_alu_sel_ID),
        .ex_br_sel_out(ex_br_sel_ID),
        .mem_wr_en_out(mem_wr_en_ID),  
        .mem_imm_sel_out(mem_imm_sel_ID),
        .wb_wb_sel_out(wb_wb_sel_ID),  
        .wb_data_sel_out(wb_data_sel_ID),
        .wb_reg_en_out(wb_reg_en_ID)
    );

    LR LR (
        .clk(clk),
        .rst(rst),
        .en(ex_lr_en_ID),
        .PC2(PC2_ID),
        .LR(LR)
    );

    mux4_1 A_dh (
        .A(A_ID),
        .B(wb_data),
        .C(ALU_EX),
        .D(ALU_EX),
        .sel(A_dh_sel),
        .Y(A_dh_out)
    );

    mux4_1 B_dh (
        .A(B_ID),
        .B(wb_data),
        .C(ALU_EX),
        .D(ALU_EX),
        .sel(B_dh_sel),
        .Y(B_dh_out)
    );

    ALU ALU (
        .A(A_ID),
        .B(B_ID),
        .Y(ALU_out),
        .sel(ex_alu_sel_ID),
        .flag(flag)
    );

    controller_branch CB (
        .brx(ex_brx), //brx 
        ._Z(_Z), 
        ._N(_N),
        .ex_alu_sel(ex_alu_sel_ID),
        .ex_br_sel(ex_br_sel_ID),
        .en(br_en),
        .br_taken(br_taken),
        .br_sel(br_sel),
        .br_type_sel(br_type_sel)
    );

    flag_reg FR (
        .clk(clk),
        .rst(rst),
        .en(br_en),
        .flag(flag),
        ._Z(_Z),
        ._N(_N)
    );

    pipeline_EX PL_EX(
        .ALU(ALU_out),
        .ra(ra_ID),
        .ea(ea_ID),
        .mem_wr_en(mem_wr_en_ID),      //Memory Stage 
        .mem_imm_sel(mem_imm_sel_ID),
        .wb_wb_sel(wb_data_sel_ID),      //Write Back St
        .wb_data_sel(wb_data_sel_ID),
        .wb_reg_en(wb_reg_en_ID),
        .ALU_out(ALU_EX),
        .ra_out(ra_EX),
        .ea_out(ea_EX),
        .mem_wr_en_out(mem_wr_en_EX),  
        .mem_imm_sel_out(mem_imm_sel_EX),
        .wb_wb_sel_out(wb_wb_sel_EX),  
        .wb_data_sel_out(wb_data_sel_out),
        .wb_reg_en_out(wb_reg_en_EX)
    );

    DM DM (
        .clk(clk),
        .rst(rst),
        .result(ALU_EX),
        .ea(ea_EX),
        .mem_en(mem_wr_en_EX),
        .data(DM)
    );

    mux2_1 mem_imm (
        .A(ALU_EX),
        .B(ea_EX),
        .Y(ALU_ea),
        .sel(mem_imm_sel_EX)
    );

    pipeline_MEM PL_MEM (
        .DM(DM),
        .ALU_ea(ALU_ea),
        .ra(ra_EX),
        .wb_wb_sel(wb_data_sel_EX),
        .wb_data_sel(wb_data_sel_EX),
        .wb_reg_en(wb_reg_en_EX),
        .DM_out(DM_MEM),
        .ra_out(ra_MEM),
        .ALU_ea_out(ALU_ea_MEM),
        .wb_wb_sel_out(wb_wb_sel_MEM),
        .wb_data_sel(wb_data_sel_MEM),
        .wb_reg_en_out(wb_reg_en_MEM),
    );

    mux2_1 

endmodule 