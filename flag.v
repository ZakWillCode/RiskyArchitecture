module flag_reg(

    input           en, rst, clk,
    input   [1:0]   flag,

    output  reg     _Z, _N

);

    always @(negedge clk) begin
        if(rst) begin
            _Z <= 1'b0;
            _N <= 1'b0;
        end else begin
            if (en) begin
                _Z <= flag[1];
                _N <= flag[0];
            end
        end
    end

endmodule