module PL_RISC_TL (
    input           clk_f, rst_n,
    input   [7:0]   in_port,

    output  [7:0]   out_port
);
    //PC
    wire [7:0] pc_in, pc_out;
    wire [15:0] inst;
    wire clk;
	 wire rst;
	 assign rst = !rst_n;

    //IF
    wire [7:0]  PC2;
    wire [7:0]   PC2_IF;
    wire [1:0]   ra, rb;
    wire [7:0]   ea;
	wire [7:0] ALU_ea;
    wire [15:0]  inst_IF;

    //REG
    wire [7:0] reg_data1, reg_data2, data;

    //ID
    wire            ex_lr_en;       //Instruction Execution Stage
    wire            ex_brx;
    wire    [3:0]   ex_alu_sel;
    wire    [1:0]   ex_br_sel_ID;
    wire            mem_wr_en;      //Memory Stage 
    wire            mem_imm_sel;
    wire            wb_wb_sel;      //Write Back Stage
    wire            wb_reg_en;
    wire    [7:0]   A_ID, B_ID;
    wire    [7:0]   PC2_ID;
    wire    [1:0]   ra_ID;
    wire    [1:0]   rb_ID;
    wire    [7:0]   ea_ID;
    wire            ex_lr_en_ID;       //Instruction Execution Stage Out
    wire            ex_brx_ID;
    wire    [3:0]   ex_alu_sel_ID;
    wire            mem_wr_en_ID;      //Memory Stage Out
    wire            mem_imm_sel_ID;
    wire            wb_wb_sel_ID;      //Write Back Stage Out
    wire            wb_reg_en_ID;

    wire    [7:0]   LR;

    //DH WB
    wire    [7:0]   A_dh_out, B_dh_out;

    //ALU
	wire	[7:0]	ALU_out;
    wire    [1:0]   flag;

    //Branch 
    wire            _Z, _N;
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
    wire            wb_reg_en_EX;

    //MEM
    wire    [7:0]   DM_MEM;
    wire    [1:0]   ra_MEM;
    wire    [7:0]   ALU_ea_MEM;
    wire            wb_wb_sel_MEM;
    wire            wb_reg_en_MEM;
	wire 	[7:0]	wb_data;

    //DM
    wire    [7:0]   DM;
	
	//HZ  
	wire 	        br_clr;
	wire 	[1:0]   A_dh_sel;
    	wire	[1:0]   B_dh_sel;
	
	//pc feedback controls 
	wire 	[7:0]	pc_type;
	
	counter_clk cc(
		.rst(rst),
		.clk_f(clk_f),
		.clk_s(clk)
	);
	
	mux2_1 br_type (
	.A(ea_ID),
	.B(LR),
	.Y(pc_type),
	.sel(br_type_sel)
	);
	
	mux2_1 br_ (
	.A(PC2),
	.B(pc_type),
	.Y(pc_in),
	.sel(br_sel)
	);
	
    PC pc (
        .clk(clk),
        .rst(rst),
	.pc_en(pc_en),
        .pc_in(pc_in),
        .pc_out(pc_out)
    );

    inst_mem im (
	.clk(clk),
	.rst(rst),
        .pc(pc_out),
        .inst(inst)
    );

    PC2 pc2 (
        .PC(pc_out),
        .PC2(PC2)
    );

    pipeline_IF pl_if (
        .clk(clk),
        .rst(br_clr),
	.IF_en(IF_en),
        .PC2_in(PC2),
        .PC2_out(PC2_IF),
        .inst_in(inst),
        .ra(ra),
        .rb(rb),
        .ea(ea),
        .inst_out(inst_IF)
    );

    mux2_1 reg_write (
        .A(wb_data),
        .B(in_port),
        .sel(id_data_sel),
        .Y(data)
    );

    register register (
        .clk(clk),
        .rst(rst),
        .ra(ra),
        .rb(rb),
        .wb(ra_MEM),
        .data(data),
	.reg_en(wb_reg_en_MEM),
	.reg_in_en(id_reg_en),
        .reg_data1(reg_data1),
        .reg_data2(reg_data2)
    );

    out_reg out_reg (
        .clk(clk),
        .rst(rst),
        .en(out_en_master),
        .reg_data1(reg_data1),
        .out_port(out_port)
    );

    controller_CPU controller_cpu (
        .inst(inst_IF),
        .id_out_en(id_out_en),
	.id_data_sel(id_data_sel),
	.id_reg_en(id_reg_en),
	.id_store_stall(id_store_stall),
        .ex_lr_en(ex_lr_en),
        .ex_brx(ex_brx),
        .ex_alu_sel(ex_alu_sel),
        .ex_br_sel(ex_br_sel),
        .mem_wr_en(mem_wr_en),
        .mem_imm_sel(mem_imm_sel),
	.mem_read(mem_read),
        .wb_wb_sel(wb_wb_sel),
        .wb_reg_en(wb_reg_en)
    );

    pipeline_ID pl_id (
	.clk(clk),
	.rst(br_clr),
	.ID_stall(ID_stall),
        .A(reg_data1),
        .B(reg_data2),
        .PC2(PC2_IF), 
        .ra(ra),
	.rb(rb),
        .ea(ea),  
        .ex_lr_en(ex_lr_en),       
        .ex_brx(ex_brx),
        .ex_alu_sel(ex_alu_sel),
        .ex_br_sel(ex_br_sel),
        .mem_wr_en(mem_wr_en),      
        .mem_imm_sel(mem_imm_sel),
	.mem_read(mem_read),
        .wb_wb_sel(wb_wb_sel),     
        .wb_reg_en(wb_reg_en),
        .A_out(A_ID), 
        .B_out(B_ID),
        .PC2_out(PC2_ID),
        .ra_out(ra_ID),
	.rb_out(rb_ID),
        .ea_out(ea_ID),
        .ex_lr_en_out(ex_lr_en_ID),   
        .ex_brx_out(ex_brx_ID),
        .ex_alu_sel_out(ex_alu_sel_ID),
        .ex_br_sel_out(ex_br_sel_ID),
        .mem_wr_en_out(mem_wr_en_ID),  
        .mem_imm_sel_out(mem_imm_sel_ID),
	.mem_read_out(mem_read_ID),
        .wb_wb_sel_out(wb_wb_sel_ID),  
        .wb_reg_en_out(wb_reg_en_ID)
    );

    link_reg lr (
        .clk(clk),
        .rst(rst),
        .en(ex_lr_en_ID),
        .PC2(PC2_ID),
        .LR(LR)
    );

    mux4_1 a_dh (
        .A(A_ID),
        .B(wb_data),
        .C(ALU_ea),
        .D(ALU_ea),
        .sel(A_dh_sel),
        .Y(A_dh_out)
    );

    mux4_1 b_dh (
        .A(B_ID),
        .B(wb_data),
        .C(ALU_ea),
        .D(ALU_ea),
        .sel(B_dh_sel),
        .Y(B_dh_out)
    );

    ALU alu (
        .A(A_dh_out),
        .B(B_dh_out),
        .Y(ALU_out),
        .sel(ex_alu_sel_ID),
        .flag(flag)
    );

    controller_branch controller_b (
        .brx(ex_brx_ID), //brx 
        ._Z(_Z), 
        ._N(_N),
        .ex_alu_sel(ex_alu_sel_ID),
        .ex_br_sel(ex_br_sel_ID),
        .en(br_en),
        .br_taken(br_taken),
        .br_sel(br_sel),
        .br_type_sel(br_type_sel)
    );

    flag_reg freg (
        .clk(clk),
        .rst(rst),
        .en(br_en),
        .flag(flag),
        ._Z(_Z),
        ._N(_N)
    );

    pipeline_EX pl_ex(
	.clk(clk),
	.rst(rst),
        .ALU(ALU_out),
        .ra(ra_ID),
        .ea(ea_ID),
        .mem_wr_en(mem_wr_en_ID),      //Memory Stage 
        .mem_imm_sel(mem_imm_sel_ID),
	.wb_wb_sel(wb_wb_sel_ID),
        .wb_reg_en(wb_reg_en_ID),
        .ALU_out(ALU_EX),
        .ra_out(ra_EX),
        .ea_out(ea_EX),
        .mem_wr_en_out(mem_wr_en_EX),  
        .mem_imm_sel_out(mem_imm_sel_EX),
        .wb_wb_sel_out(wb_wb_sel_EX),  
        .wb_reg_en_out(wb_reg_en_EX)
    );

    data_mem dm (
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

    pipeline_MEM pl_mem (
	.clk(clk),
	.rst(rst),
        .DM(DM),
        .ALU_ea(ALU_ea),
        .ra(ra_EX),
        .wb_wb_sel(wb_wb_sel_EX),
        .wb_reg_en(wb_reg_en_EX),
        .DM_out(DM_MEM),
        .ra_out(ra_MEM),
        .ALU_ea_out(ALU_ea_MEM),
        .wb_wb_sel_out(wb_wb_sel_MEM),
        .wb_reg_en_out(wb_reg_en_MEM)
    );

    mux2_1 mux_wb (
        .A(ALU_ea_MEM),
        .B(DM_MEM),
        .Y(wb_data),
        .sel(wb_wb_sel_MEM)
    );
	
	controller_hazard hz_c (
		.clk(clk),
		.rst(rst),
		.wb_reg_en_EX(wb_reg_en_EX),
		.wb_reg_en_MEM(wb_reg_en_MEM),
		.mem_read(mem_read_ID),
		.id_store_stall(id_store_stall),
		.id_out_en(id_out_en),
		.ra(ra),
		.rb(rb),
		.ra_ID(ra_ID),
		.rb_ID(rb_ID),
		.ra_EX(ra_EX),
		.ra_MEM(ra_MEM),
		.br_taken(br_taken),
		.br_clr(br_clr),
		.A_dh_sel(A_dh_sel),
		.B_dh_sel(B_dh_sel),
		.pc_en(pc_en),
		.IF_en(IF_en),
		.ID_stall(ID_stall),
		.out_en_master(out_en_master)
	);

endmodule 