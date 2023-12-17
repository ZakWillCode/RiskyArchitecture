module ALU(

	input signed [7:0] A, B,
	input [3:0] sel,
	output signed [7:0] Y,
    output [1:0] flag // flag[1] = _Z, flag[0] = N
	
);

    reg _Z, N;
    reg signed [7:0] result;

	always @(*)
	begin

		case (sel)
			4'b0001: begin//ADD
				result <= (A + B);

                		//Check for _Zero and Negative 
                		if (Y == 1'b0) begin
                    			_Z <= 1'b1;
                    			N <= 1'b0;
                		end
		        	else if (Y[7] == 1'b1) begin
                    			N <= 1'b1;
                    			_Z <= 1'b0;
                		end 
		        	else begin
                    			_Z <= 1'b0;
                    			N <= 1'b0;
                		end
            		end
			4'b0010: begin//SUB
				result <= (A - B);

                		//Check for _Zero and Negative 
                		if (Y == 1'b0) begin
                    			_Z <= 1'b1;
                    			N <= 1'b0;
                		end
		        	else if (Y[7] == 1'b1) begin
                    			N <= 1'b1;
                    			_Z <= 1'b0;
                		end 
		        	else begin
                    			_Z <= 1'b0;
                    			N <= 1'b0;
                		end
                	end
			4'b0011: begin//NAND
				result <= ~(A & B);

                		//Check for _Zero and Negative 
                		if (Y == 1'b0) begin
                    			_Z <= 1'b1;
                    			N <= 1'b0;
                		end
		       		else if (Y[7] == 1'b1) begin
                    			N <= 1'b1;
                    			_Z <= 1'b0;
                		end 
		        	else begin
                    			_Z <= 1'b0;
                    			N <= 1'b0;
              			end
            		end
			4'b0100: begin//SHL
				result <= {A[6:0],1'b0};
                		_Z <= A[7];
                		N = 1'b0;
            		end
			4'b0101: begin//SHR
				result <= {1'b0, A[7:1]};
                		_Z <= A[0];
                		N = 1'b0;
           		end
			4'b0110: begin //OUT
				result <= A;
				_Z = 1'b0;
                		N = 1'b0;
			end
			4'b0111: begin //IN
				result <= 8'b0;
				_Z = 1'b0;
                		N = 1'b0;
			end
			4'b1000: begin //MOV
				result <= B;
				_Z = 1'b0;
                		N = 1'b0;
			end
			4'b1001: begin //STORE
				result <= A;
				_Z = 1'b0;
                		N = 1'b0;
			end
			default: begin//NOP
                		result = 8'b0;
                		_Z = 1'b0;
                		N = 1'b0;
            		end
		endcase
	end

    assign Y = result;
    assign flag = {_Z,N};
	
endmodule