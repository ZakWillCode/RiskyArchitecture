module controller_CPU(
    input   [15:0]  inst,
     
    output  	reg    		id_out_en,      //Instruction Decoding Stage
    output  	reg		id_reg_en,
    output  	reg		id_data_sel,
    output      reg		id_store_stall,

    output 	reg 	        ex_lr_en,       //Instruction Execution Stage
    output 	reg 	        ex_brx,
    output 	reg 	[3:0]   ex_alu_sel,
    output 	reg 	[1:0]   ex_br_sel,        //if BR LR
			
    output 	reg 	        mem_wr_en,      //Memory Stage 
    output 	reg 	        mem_imm_sel,
    output 	reg		mem_read,
			
    output 	reg 	        wb_wb_sel,      //Write Back Stage
    output 	reg 	        wb_reg_en

);


    always @(*) begin

        case (inst[15:12])
            4'b0000:    begin   //NOP
                id_out_en <=        1'b0; 
		id_reg_en <=        1'b0; 
		id_data_sel <=      1'b0; 
		id_store_stall <=   1'b0;

                ex_lr_en <=         1'b0;
                ex_brx <=           1'b0;
                ex_alu_sel <=       4'b0000;
                ex_br_sel <=        2'b00;

                mem_wr_en <=        1'b0;
                mem_imm_sel <=      1'b0;
		mem_read <= 	    1'b0;

                wb_wb_sel <=        1'b0;
                wb_reg_en <=        1'b0;
            end
            4'b0001:    begin   //ADD
                id_out_en <=        1'b0; 
		id_reg_en <=        1'b0; 
		id_data_sel <=      1'b0; 
		id_store_stall <=   1'b0;

                ex_lr_en <=         1'b0;
                ex_brx <=           1'b0;
                ex_alu_sel <=       4'b0001;
                ex_br_sel <=        2'b00;

                mem_wr_en <=        1'b0;
                mem_imm_sel <=      1'b0; 
		mem_read <= 1'b0;

                wb_wb_sel <=        1'b0;
                wb_reg_en <=        1'b1;
            end
            4'b0010:    begin   //SUB
                id_out_en <=        1'b0; 
		id_reg_en <=        1'b0; 
		id_data_sel <=      1'b0; 
		id_store_stall <=   1'b0;

                ex_lr_en <=         1'b0;
                ex_brx <=           1'b0;
                ex_alu_sel <=       4'b0010;
                ex_br_sel <=        2'b00;

                mem_wr_en <=        1'b0;
                mem_imm_sel <=      1'b0; 
		mem_read <= 1'b0;

                wb_wb_sel <=        1'b0;
                wb_reg_en <=        1'b1;
            end
            4'b0011:    begin   //NAND
                id_out_en <=        1'b0; 
		id_reg_en <=        1'b0; 
		id_data_sel <=      1'b0; 
		id_store_stall <=   1'b0;

                ex_lr_en <=         1'b0;
                ex_brx <=           1'b0;
                ex_alu_sel <=       4'b0011;
                ex_br_sel <=        2'b00;

                mem_wr_en <=        1'b0;
                mem_imm_sel <=      1'b0; 
		mem_read <= 1'b0;

                wb_wb_sel <=        1'b0;
                wb_reg_en <=        1'b1;
            end
            4'b0100:    begin   //SHL   
                id_out_en <=        1'b0; 
		id_reg_en <=        1'b0; 
		id_data_sel <=      1'b0; 
		id_store_stall <=   1'b0;

                ex_lr_en <=         1'b0;
                ex_brx <=           1'b0;
                ex_alu_sel <=       4'b0100;
                ex_br_sel <=        2'b00;

                mem_wr_en <=        1'b0;
                mem_imm_sel <=      1'b0; 
		mem_read <= 1'b0;

                wb_wb_sel <=        1'b0;
                wb_reg_en <=        1'b1;
            end
            4'b0101:    begin   //SHR
                id_out_en <=        1'b0; 
		id_reg_en <=        1'b0; 
		id_data_sel <=      1'b0; 
		id_store_stall <=   1'b0;

                ex_lr_en <=         1'b0;
                ex_brx <=           1'b0;
                ex_alu_sel <=       4'b0101;
                ex_br_sel <=        2'b00;

                mem_wr_en <=        1'b0;
                mem_imm_sel <=      1'b0; 
		mem_read <= 1'b0;

                wb_wb_sel <=        1'b0;
                wb_reg_en <=        1'b1;
            end
            4'b0110:    begin   //OUT
                id_out_en <=        1'b1; 
		id_reg_en <=	    1'b0;
		id_data_sel <=      1'b0;
		id_store_stall <=   1'b0;

                ex_lr_en <=         1'b0;
                ex_brx <=           1'b0;
                ex_alu_sel <=       4'b0110;
                ex_br_sel <=        2'b00;

                mem_wr_en <=        1'b0;
                mem_imm_sel <=      1'b0; 
		mem_read <= 1'b0;

                wb_wb_sel <=        1'b0;
                wb_reg_en <=        1'b0;
            end
            4'b0111:    begin   //IN
                id_out_en <=        1'b0; 
		id_reg_en <=        1'b1; 
		id_data_sel <=      1'b1;
		id_store_stall <=   1'b0;

                ex_lr_en <=         1'b0;
                ex_brx <=           1'b0;
                ex_alu_sel <=       4'b0111;
                ex_br_sel <=        2'b00;

                mem_wr_en <=        1'b0;
                mem_imm_sel <=      1'b0; 
		mem_read <= 1'b0;

                wb_wb_sel <=        1'b0;
                wb_reg_en <=        1'b0;
            end
            4'b1000:    begin   //MOV
                id_out_en <=        1'b0; 
		id_reg_en <=        1'b0; 
		id_data_sel <=      1'b0; 
		id_store_stall <=   1'b0;

                ex_lr_en <=         1'b0;
                ex_brx <=           1'b0;
                ex_alu_sel <=       4'b1000;
                ex_br_sel <=        2'b00;

                mem_wr_en <=        1'b0;
                mem_imm_sel <=      1'b0; 
		mem_read <= 1'b0;

                wb_wb_sel <=        1'b0;
                wb_reg_en <=        1'b1;
            end
            4'b1001:    begin   //BR
                id_out_en <=        1'b0; 
		id_reg_en <=        1'b0; 
		id_data_sel <=      1'b0; 
		id_store_stall <=   1'b0;

                ex_lr_en <=         1'b0;
                ex_brx <=           1'b0;
                ex_alu_sel <=       4'b0000;
                ex_br_sel <=          2'b01;

                mem_wr_en <=        1'b0;
                mem_imm_sel <=      1'b0; 
		mem_read <= 1'b0;

                wb_wb_sel <=        1'b0;
                wb_reg_en <=        1'b0;
            end
            4'b1010:    begin   //BR.Z/BR.N 
                id_out_en <=        1'b0; 
		id_reg_en <=        1'b0; 
		id_data_sel <=      1'b0; 
		id_store_stall <=   1'b0;

                ex_lr_en <=         1'b0;
                ex_brx <=           inst[11];
                ex_alu_sel <=       4'b0000;
                ex_br_sel <=        2'b10;

                mem_wr_en <=        1'b0;
                mem_imm_sel <=      1'b0; 
		mem_read <= 1'b0;

                wb_wb_sel <=        1'b0;
                wb_reg_en <=        1'b0;
            end
            4'b1011:    begin   //BR.SUB
                id_out_en <=        1'b0; 
		id_reg_en <=        1'b0; 
		id_data_sel <=      1'b0; 
		id_store_stall <=   1'b0;

                ex_lr_en <=         1'b1;
                ex_brx <=           1'b0;
                ex_alu_sel <=       4'b0000;
                ex_br_sel <=        2'b01;

                mem_wr_en <=        1'b0;
                mem_imm_sel <=      1'b0; 
		mem_read <= 1'b0;

                wb_wb_sel <=        1'b0;
                wb_reg_en <=        1'b0;
            end
            4'b1100:    begin   //RETURN
                id_out_en <=        1'b0; 
		id_reg_en <=        1'b0; 
		id_data_sel <=      1'b0; 
		id_store_stall <=   1'b0;

                ex_lr_en <=         1'b0;
                ex_brx <=           1'b0;
                ex_alu_sel <=       4'b0000;
                ex_br_sel <=          2'b11;

                mem_wr_en <=        1'b0;
                mem_imm_sel <=      1'b0; 
		mem_read <= 1'b0;

                wb_wb_sel <=        1'b0;
                wb_reg_en <=        1'b0;
            end
            4'b1101:    begin   //LOAD
                id_out_en <=        1'b0; 
		id_reg_en <=        1'b0; 
		id_data_sel <=      1'b0; 
		id_store_stall <=   1'b0;

                ex_lr_en <=         1'b0;
                ex_brx <=           1'b0;
                ex_alu_sel <=       4'b0000;
                ex_br_sel <=        2'b00;

                mem_wr_en <=        1'b0;
                mem_imm_sel <=      1'b0; 
		mem_read <= 	    1'b1;

                wb_wb_sel <=        1'b1;
                wb_reg_en <=        1'b1;
            end
            4'b1110:    begin   //STORE
                id_out_en <=        1'b0; 
		id_reg_en <=        1'b0; 
		id_data_sel <=      1'b0; 
		id_store_stall <=   1'b1;

                ex_lr_en <=         1'b0;
                ex_brx <=           1'b0;
                ex_alu_sel <=       4'b1001;
                ex_br_sel <=        2'b00;

                mem_wr_en <=        1'b1;
                mem_imm_sel <=      1'b0; 
		mem_read <= 1'b0;

                wb_wb_sel <=        1'b0;
                wb_reg_en <=        1'b0;
            end
            4'b1111:    begin   //LOADIMM
                id_out_en <=        1'b0; 
		id_reg_en <=        1'b0; 
		id_data_sel <=      1'b0; 
		id_store_stall <=   1'b0;

                ex_lr_en <=         1'b0;
                ex_brx <=           1'b0;
                ex_alu_sel <=       4'b0000;
                ex_br_sel <=        2'b00;

                mem_wr_en <=        1'b0;
                mem_imm_sel <=      1'b1;
		mem_read <= 	    1'b1;

                wb_wb_sel <=        1'b0;
                wb_reg_en <=        1'b1;
            end
            default: begin      //NOP
                id_out_en <=        1'b0; 
		id_reg_en <=        1'b0; 
		id_data_sel <=      1'b0; 
		id_store_stall <=   1'b0;

                ex_lr_en <=         1'b0;
                ex_brx <=           1'b0;
                ex_alu_sel <=       4'b0000;
                ex_br_sel <=        2'b00;

                mem_wr_en <=        1'b0;
                mem_imm_sel <=      1'b0; 
		mem_read <= 1'b0;

                wb_wb_sel <=        1'b0;
                wb_reg_en <=        1'b0;
            end

        endcase

    end


endmodule