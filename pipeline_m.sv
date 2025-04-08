module pipeline_m(input logic clk,
                  input logic reset,
                  input logic regwriteE,
                  input logic [1:0] resultsrcE,
                  input logic memwriteE,
                  input logic [31:0] aluresultE,
                  input logic [31:0] writedataE,
                  input logic [4:0] rdE,
                  input logic [31:0] pcplus4E,
                  output logic regwriteM,
                  output logic [1:0] resultsrcM,
                  output logic memwriteM,
                  output logic [31:0] aluresultM,
                  output logic [31:0] writedataM,
                  output logic [4:0] rdM,
                  output logic [31:0] pcplus4M);
  
  always_ff @(posedge clk) begin
    if (reset) begin
      regwriteM <= 1'b0;
      resultsrcM <= 2'b0;
      memwriteM <= 1'b0;
      aluresultM <= 32'b0;
      writedataM <= 32'b0;
      rdM <= 5'b0;
      pcplus4M <= 32'b0;
    end
    else begin
      regwriteM <= regwriteE;
      resultsrcM <= resultsrcE;
      memwriteM <= memwriteE;
      aluresultM <= aluresultE;
      writedataM <= writedataE;
      rdM <= rdE;
      pcplus4M <= pcplus4E;
    end 
  end
endmodule
