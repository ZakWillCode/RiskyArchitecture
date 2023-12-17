module controller_hazard (
	
    input 	    clk,
    input           rst,
    input   [1:0]   ra,
    input   [1:0]   rb,
    input   [1:0]   ra_ID,
    input   [1:0]   rb_ID,
    input   [1:0]   ra_EX,
    input   [1:0]   ra_MEM,
    input           br_taken, 
    input	    wb_reg_en_EX,
    input	    wb_reg_en_MEM, 
    input	    mem_read,
    input	    id_store_stall,
    input	    id_out_en,   

    output  reg         br_clr,
    output  reg  	out_en_master,

    output  reg 	pc_en,
    output  reg 	IF_en,
    output  reg 	ID_stall,
	
    output  reg [1:0]   A_dh_sel,
    output  reg [1:0]   B_dh_sel

);
	reg  [2:0]	stall = 3'b00;
	//Store-use hazards
	always @(negedge clk) begin
		if (!mem_read) begin
			if ((id_store_stall || id_out_en) && (stall < 2)) begin
				stall <= stall + 1;
				pc_en <= 1'b0;
				IF_en <= 1'b0;
				ID_stall <= 1'b1;
				out_en_master <=1'b0;
			end else if ((id_out_en) && (stall < 4)) begin
				stall <= stall + 1;
				pc_en <= 1'b0;
				IF_en <= 1'b0;
				ID_stall <= 1'b1;
				out_en_master <=1'b1;
			end else begin 
				stall <= 2'b00;
				pc_en <= 1'b1;
				IF_en <= 1'b1;
				ID_stall <= 1'b0;
				out_en_master <= 1'b0;
			end
		end else begin
			if((ra_ID == ra) || (rb_ID == rb)) begin
				pc_en <= 1'b0;
				IF_en <= 1'b0;
				ID_stall <= 1'b1;
			end else begin
				pc_en <= 1'b1;
				IF_en <= 1'b1;
				ID_stall <= 1'b0;
			end
		end	
	end
    always @(*) begin

			// Branch-use Hazard detection 
				  if(rst || br_taken) begin
						br_clr <= 1'b1;
					end else begin
						br_clr <= 1'b0;
					end

			// Forwarding unit
				  /*
				  ra_ex = ra => mem -> A
				  ra_mem = ra => wb -> A
				  ra_ex = rb => mem -> B
				  ra_mem = rb => wb -> B
					*/
			
			A_dh_sel = 2'b00;
			B_dh_sel = 2'b00;

				  if (wb_reg_en_EX) begin 
				if (ra_EX == ra_ID) begin      //Hazards for A 
							A_dh_sel = 2'b10;
				end

				if (ra_EX == rb_ID) begin
					B_dh_sel = 2'b10;
				end
			end 
			if (wb_reg_en_MEM) begin 
				if (ra_MEM == ra_ID) begin      //Hazards for A 
							A_dh_sel <= 2'b01;
				end

				if (ra_MEM == rb_ID) begin
					B_dh_sel <= 2'b01;
				end
			end
    end

endmodule