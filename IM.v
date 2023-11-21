module inst_mem (

	input [7:0] pc,

	output reg [15:0] inst
	
);
	reg [7:0] inst_mem[255:0];
		//Hardcode instructions for testing with FPGA
		//Instructions are stored as a set of 2 individual bytes which will then be decoded
		
		//Test program by professor
    always@(*) begin
      inst_mem[0] <= 8'b00000000;
      inst_mem[1] <= 8'b00000000;
      inst_mem[2] <= 8'b00000000;
      inst_mem[3] <= 8'b00000000;
      inst_mem[4] <= 8'b01110000;
      inst_mem[5] <= 8'b00000000;
      inst_mem[6] <= 8'b11100000;
      inst_mem[7] <= 8'b11111111;
      inst_mem[8] <= 8'b11110000;
      inst_mem[9] <= 8'b00000111;
      inst_mem[10] <= 8'b11100000;
      inst_mem[11] <= 8'b00011111;
      inst_mem[12] <= 8'b11110000;
      inst_mem[13] <= 8'b11111111;
      inst_mem[14] <= 8'b11110100;
      inst_mem[15] <= 8'b11111111;
      inst_mem[16] <= 8'b01010000;
      inst_mem[17] <= 8'b00000000;
      inst_mem[18] <= 8'b01000100;
      inst_mem[19] <= 8'b00000000;
      inst_mem[20] <= 8'b10001100;
      inst_mem[21] <= 8'b00000000;
      inst_mem[22] <= 8'b11010000;
      inst_mem[23] <= 8'b11111111;
      inst_mem[24] <= 8'b01010000;
      inst_mem[25] <= 8'b00000000;
      inst_mem[26] <= 8'b11100000;
      inst_mem[27] <= 8'b11111111;
      inst_mem[28] <= 8'b10000011;
      inst_mem[29] <= 8'b00000000;
      inst_mem[30] <= 8'b10100000;
      inst_mem[31] <= 8'b00100100;
      inst_mem[32] <= 8'b00010001;
      inst_mem[33] <= 8'b00000000;
      inst_mem[34] <= 8'b10010000;
      inst_mem[35] <= 8'b00100110;
      inst_mem[36] <= 8'b00110001;
      inst_mem[37] <= 8'b00000000;
      inst_mem[38] <= 8'b01100000;
      inst_mem[39] <= 8'b00000000;
      inst_mem[40] <= 8'b10110000;
      inst_mem[41] <= 8'b00110100;
      inst_mem[42] <= 8'b10000011;
      inst_mem[43] <= 8'b00000000;
      inst_mem[44] <= 8'b10100100;
      inst_mem[45] <= 8'b00110000;
      inst_mem[46] <= 8'b10010000;
      inst_mem[47] <= 8'b00010000;
      inst_mem[48] <= 8'b10010000;
      inst_mem[49] <= 8'b00000100;
      inst_mem[50] <= 8'b00000000;
      inst_mem[51] <= 8'b00000000;
      inst_mem[52] <= 8'b11010000;
      inst_mem[53] <= 8'b00011111;
      inst_mem[54] <= 8'b10001001;
      inst_mem[55] <= 8'b00000000;
      inst_mem[56] <= 8'b11110100;
      inst_mem[57] <= 8'b00000001;
      inst_mem[58] <= 8'b00100001;
      inst_mem[59] <= 8'b00000000;
      inst_mem[60] <= 8'b11100000;
      inst_mem[61] <= 8'b00011111;
      inst_mem[62] <= 8'b10000110;
      inst_mem[63] <= 8'b00000000;
      inst_mem[64] <= 8'b11000000;
      inst_mem[65] <= 8'b00000000;


		
		inst <= {inst_mem[pc],inst_mem[pc+1]};

	end

endmodule