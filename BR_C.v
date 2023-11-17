module controller_branch (
    input           brx, //brx = 0 => Z, brx = 1 => N 
    input           _Z, _N,
    input   [3:0]   ex_alu_sel,
    input   [1:0]   ex_br_sel,

    output  reg     en,
    output  reg     br_taken,
    output  reg     br_sel,
    output  reg     br_type_sel
);

    always @(*) begin
        case (ex_alu_sel) //cases for enable to be triggered 
            4'b0000: en <= 1'b0;
            4'b0001: en <= 1'b1;
            4'b0010: en <= 1'b1;
            4'b0011: en <= 1'b1;
            4'b0100: en <= 1'b1;
            4'b0101: en <= 1'b1;
            4'b0110: en <= 1'b0;
            4'b0111: en <= 1'b0;
            4'b1000: en <= 1'b0;
            4'b1001: en <= 1'b0;
            4'b1010: en <= 1'b0;
            4'b1011: en <= 1'b0;
            4'b1100: en <= 1'b0;
            4'b1101: en <= 1'b0;
            4'b1110: en <= 1'b0;
            4'b1111: en <= 1'b0;
        default: en <= 1'b0;
        endcase

        case (ex_br_sel) 
            2'b00: begin
                br_sel <= 1'b0;
                br_type_sel <= 1'b0;
                br_taken <= 1'b0;
            end
            2'b01: begin
                br_sel <= 1'b1;
                br_type_sel <= 1'b0;
                br_taken <= 1'b1;
            end
            2'b10: begin
                if (!brx) begin
                    if(_Z)   begin
                        br_sel <= 1'b1;
                        br_type_sel <= 1'b0;       //ea
                        br_taken <= 1'b1;
                    end else begin
                        br_sel <= 1'b0;
                        br_type_sel <= 1'b0;
                        br_taken <= 1'b0;
                    end
                end else begin
                    if(_N)   begin
                        br_sel <= 1'b1;
                        br_type_sel <= 1'b0;       //ea
                        br_taken <= 1'b1;
                    end else begin
                        br_sel <= 1'b0;
                        br_type_sel <= 1'b0;
                        br_taken <= 1'b0;
                    end
                end
            end
            2'b11: begin
                br_sel <= 1'b1;
                br_type_sel <= 1'b1;
                br_taken <= 1'b1;
            end

        endcase

    end

endmodule