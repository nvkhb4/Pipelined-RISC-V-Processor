module pipeline_w(input logic clk,
                  input logic reset,
                  input logic regwriteM,
                  input logic [1:0] resultsrcM,
                  input logic [31:0] aluresultM,
                  input logic [31:0] readdataM,
                  input logic [4:0] rdM,
                  input logic [31:0] pcplus4M,
                  output logic regwriteW,
                  output logic [1:0] resultsrcW,
                  output logic [31:0] aluresultW,
                  output logic [31:0] readdataW,
                  output logic [4:0] rdW,
                  output logic [31:0] pcplus4W);
  
  always_ff @(posedge clk) begin
    if (reset) begin
      regwriteW <= 1'b0;
      resultsrcW <= 2'b0;
      aluresultW <= 32'b0;
      readdataW <= 32'b0;
      rdW <= 5'b0;
      pcplus4W <= 32'b0;
    end
    else begin
      regwriteW <= regwriteM;
      resultsrcW <= resultsrcM;
      aluresultW <= aluresultM;
      readdataW <= readdataM;
      rdW <= rdM;
      pcplus4W <= pcplus4M;
    end
    
  end
endmodule
