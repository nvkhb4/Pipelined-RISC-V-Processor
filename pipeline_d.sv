module pipeline_d(input logic clk,
                  input logic reset,
                  input logic en,
                  input logic clr,
                  input logic [31:0] instrF,
                  input logic [31:0] pcF,
                  input logic [31:0] pcplus4F,
                  output logic [31:0] instrD,
                  output logic [31:0] pcD,
                  output logic [31:0] pcplus4D);
  
  always_ff @(posedge clk) begin
    if (reset | clr) begin
      instrD <= 32'b0;
      pcD <= 32'b0;
      pcplus4D <= 32'b0;
    end
    else if (en) begin
    	instrD <= instrF;
    	pcD <= pcF;
    	pcplus4D <= pcplus4F;
    end
  end
  
endmodule
