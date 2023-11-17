module controller_hazard (

    input           rst,
    input   [1:0]   ra,
    input   [1:0]   rb,
    input   [1:0]   ra_EX,
    input   [1:0]   ra_MEM,
    input           br_taken,      

    output  reg         br_clr,

    output  reg [1:0]   A_dh_sel,
    output  reg [1:0]   B_dh_sel

);

    always @(*) begin
        if(rst)
            br_clr <= 1'b1;
        else if (br_taken)
            br_clr <= 1'b1;
        else
            br_clr <= 1'b0;

        /*
        ra_ex = ra => mem -> A
        ra_mem = ra => wb -> A
        ra_ex = rb => mem -> B
        ra_mem = rb => wb -> B
         */

        if (ra_EX == ra)        //Hazards for A 
            A_dh_sel <= 2'b10;
        else if (ra_MEM == ra)
            A_dh_sel <= 2'b01;
        else
            A_dh_sel <= 2'b00;

        if (ra_EX == rb)        //Hazards for B
            B_dh_sel <= 2'b10;
        else if (ra_MEM == rb)
            B_dh_sel <= 2'b01;
        else
            B_dh_sel <= 2'b00;


    end

endmodule