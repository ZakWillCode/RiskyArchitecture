module ALU(

	input signed [7:0] A, B,
	input [3:0] sel,
	output signed [7:0] Y,
    output [1:0] flag // flag[1] = Z, flag[0] = N
	
);

    reg Z, N;
    reg signed [7:0] result;

	always @(*)
	begin

		case (sel)
			4'b0001: begin//ADD
				result <= (A + B);

                //Check for Zero and Negative 
                if (Y == 1'b0) begin
                    Z <= 1'b1;
                    N <= 1'b0;
                end
		        else if (Y[7] == 1'b1) begin
                    N <= 1'b1;
                    Z <= 1'b0;
                end 
		        else begin
                    Z <= 1'b0;
                    N <= 1'b0;
                end
            end
			4'b0010: begin//SUB
				result <= (A - B);

                //Check for Zero and Negative 
                if (Y == 1'b0) begin
                    Z <= 1'b1;
                    N <= 1'b0;
                end
		        else if (Y[7] == 1'b1) begin
                    N <= 1'b1;
                    Z <= 1'b0;
                end 
		        else begin
                    Z <= 1'b0;
                    N <= 1'b0;
                end
                end
			4'b0011: begin//NAND
				result <= ~(A & B);

                //Check for Zero and Negative 
                if (Y == 1'b0) begin
                    Z <= 1'b1;
                    N <= 1'b0;
                end
		        else if (Y[7] == 1'b1) begin
                    N <= 1'b1;
                    Z <= 1'b0;
                end 
		        else begin
                    Z <= 1'b0;
                    N <= 1'b0;
                end
            end
			4'b0100: begin//SHL
				result <= A << 1;

                Z <= A[7];
            end
			4'b0101: begin//SHR
				result <= A >> 1;

                Z <= A[0];
            end
			4'b0110: //OUT
				result <= A;
			4'b0111: //IN
				result <= 8'b0;
			4'b1000: //MOV
				result <= B;
			4'b1001: //STORE
				result <= A;
			default: begin//NOP
                result = 8'b0;
                Z = 1'b0;
                N = 1'b0;
            end
		endcase
	end

    assign Y = result;
    assign flag = {Z,N};
	
endmodule