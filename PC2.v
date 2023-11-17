module PC2 (
  input [7:0] PC,
  output reg [7:0] PC2
);

  always @(*) begin
    PC2 = PC + 2;
  end

endmodule