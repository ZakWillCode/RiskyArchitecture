module inst_mem (

	input [7:0] pc,

	output reg [15:0] inst
	
);
	reg [7:0] inst_mem[255:0];
		//Hardcode instructions for testing with FPGA
		//Instructions are stored as a set of 2 individual bytes which will then be decoded
		
		//Test program by professor
    always@(*) begin
		inst_mem[0] = 8'b00000000;
        inst_mem[1] = 8'b00000000;
        inst_mem[2] = 8'b00000001;
        inst_mem[3] = 8'b00000000;
        inst_mem[4] = 8'b00000010;
        inst_mem[5] = 8'b00000000;
        inst_mem[6] = 8'b00000011;
        inst_mem[7] = 8'b00000000;
        inst_mem[8] = 8'b00000100;
        inst_mem[9] = 8'b01110000;
        inst_mem[10] = 8'b00000101;
        inst_mem[11] = 8'b00000000;
        inst_mem[12] = 8'b00000110;
        inst_mem[13] = 8'b11100000;
        inst_mem[14] = 8'b00000111;
        inst_mem[15] = 8'b11111111;
        inst_mem[16] = 8'b00001000;
        inst_mem[17] = 8'b11110000;
        inst_mem[18] = 8'b00001001;
        inst_mem[19] = 8'b00000111;
        inst_mem[20] = 8'b00001010;
        inst_mem[21] = 8'b11100000;
        inst_mem[22] = 8'b00001011;
        inst_mem[23] = 8'b00011111;
        inst_mem[24] = 8'b00001100;
        inst_mem[25] = 8'b11110000;
        inst_mem[26] = 8'b00001101;
        inst_mem[27] = 8'b11111111;
        inst_mem[28] = 8'b00001110;
        inst_mem[29] = 8'b11110100;
        inst_mem[30] = 8'b00001111;
        inst_mem[31] = 8'b11111111;
        inst_mem[32] = 8'b00010000;
        inst_mem[33] = 8'b01010000;
        inst_mem[34] = 8'b00010001;
        inst_mem[35] = 8'b00000000;
        inst_mem[36] = 8'b00010010;
        inst_mem[37] = 8'b01000100;
        inst_mem[38] = 8'b00010011;
        inst_mem[39] = 8'b00000000;
        inst_mem[40] = 8'b00010100;
        inst_mem[41] = 8'b10001100;
        inst_mem[42] = 8'b00010101;
        inst_mem[43] = 8'b00000000;
        inst_mem[44] = 8'b00010110;
        inst_mem[45] = 8'b11010000;
        inst_mem[46] = 8'b00010111;
        inst_mem[47] = 8'b11111111;
        inst_mem[48] = 8'b00011000;
        inst_mem[49] = 8'b01010000;
        inst_mem[50] = 8'b00011001;
        inst_mem[51] = 8'b00000000;
        inst_mem[52] = 8'b00011010;
        inst_mem[53] = 8'b11100000;
        inst_mem[54] = 8'b00011011;
        inst_mem[55] = 8'b11111111;
        inst_mem[56] = 8'b00011100;
        inst_mem[57] = 8'b10000011;
        inst_mem[58] = 8'b00011101;
        inst_mem[59] = 8'b00000000;
        inst_mem[60] = 8'b00011110;
        inst_mem[61] = 8'b10100000;
        inst_mem[62] = 8'b00011111;
        inst_mem[63] = 8'b00100100;
        inst_mem[64] = 8'b00100000;
        inst_mem[65] = 8'b00010001;
        inst_mem[66] = 8'b00100001;
        inst_mem[67] = 8'b00000000;
        inst_mem[68] = 8'b00100010;
        inst_mem[69] = 8'b10010000;
        inst_mem[70] = 8'b00100011;
        inst_mem[71] = 8'b00100110;
        inst_mem[72] = 8'b00100100;
        inst_mem[73] = 8'b00110001;
        inst_mem[74] = 8'b00100101;
        inst_mem[75] = 8'b00000000;
        inst_mem[76] = 8'b00100110;
        inst_mem[77] = 8'b01100000;
        inst_mem[78] = 8'b00100111;
        inst_mem[79] = 8'b00000000;
        inst_mem[80] = 8'b00101000;
        inst_mem[81] = 8'b10110000;
        inst_mem[82] = 8'b00101001;
        inst_mem[83] = 8'b00110100;
        inst_mem[84] = 8'b00101010;
        inst_mem[85] = 8'b10000011;
        inst_mem[86] = 8'b00101011;
        inst_mem[87] = 8'b00000000;
        inst_mem[88] = 8'b00101100;
        inst_mem[89] = 8'b10100100;
        inst_mem[90] = 8'b00101101;
        inst_mem[91] = 8'b00110000;
        inst_mem[92] = 8'b00101110;
        inst_mem[93] = 8'b10010000;
        inst_mem[94] = 8'b00101111;
        inst_mem[95] = 8'b00010000;
        inst_mem[96] = 8'b00110000;
        inst_mem[97] = 8'b10010000;
        inst_mem[98] = 8'b00110001;
        inst_mem[99] = 8'b00000100;
        inst_mem[100] = 8'b00110010;
        inst_mem[101] = 8'b00000000;
        inst_mem[102] = 8'b00110011;
        inst_mem[103] = 8'b00000000;
        inst_mem[104] = 8'b00110100;
        inst_mem[105] = 8'b11010000;
        inst_mem[106] = 8'b00110101;
        inst_mem[107] = 8'b00011111;
        inst_mem[108] = 8'b00110110;
        inst_mem[109] = 8'b10001001;
        inst_mem[110] = 8'b00110111;
        inst_mem[111] = 8'b00000000;
        inst_mem[112] = 8'b00111000;
        inst_mem[113] = 8'b11110100;
        inst_mem[114] = 8'b00111001;
        inst_mem[115] = 8'b00000001;
        inst_mem[116] = 8'b00111010;
        inst_mem[117] = 8'b00100001;
        inst_mem[118] = 8'b00111011;
        inst_mem[119] = 8'b00000000;
        inst_mem[120] = 8'b00111100;
        inst_mem[121] = 8'b11100000;
        inst_mem[122] = 8'b00111101;
        inst_mem[123] = 8'b00011111;
        inst_mem[124] = 8'b00111110;
        inst_mem[125] = 8'b10000110;
        inst_mem[126] = 8'b00111111;
        inst_mem[127] = 8'b00000000;
        inst_mem[128] = 8'b01000000;
        inst_mem[129] = 8'b11000000;
        inst_mem[130] = 8'b01000001;
        inst_mem[131] = 8'b00000000;

		
		inst <= {inst_mem[pc],inst_mem[pc+1]};

	end

endmodule