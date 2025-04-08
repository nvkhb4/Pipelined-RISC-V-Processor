module pipeline_e(input logic clk,
                  input logic reset,
                  input logic clr,
                  input logic regwriteD,
                  input logic [1:0] resultsrcD,
                  input logic memwriteD,
                  input logic jumpD,
                  input logic branchD,
                  input logic [2:0] alucontrolD,
                  input logic alusrcD,
                  input logic [31:0] rd1D,
                  input logic [31:0] rd2D,
                  input logic [31:0] pcD,
                  input logic [31:0] pcplus4D,
                  input logic [4:0] rs1D,
                  input logic [4:0] rs2D,
                  input logic [4:0] rdD,
                  input logic [2:0] funct3D,
                  input logic [31:0] immextD,
                  output logic regwriteE,
                  output logic [1:0] resultsrcE,
                  output logic memwriteE,
                  output logic jumpE,
                  output logic branchE,
                  output logic [2:0] alucontrolE,
                  output logic alusrcE,
                  output logic [31:0] rd1E,
                  output logic [31:0] rd2E,
                  output logic [31:0] pcE,
                  output logic [31:0] pcplus4E,
                  output logic [4:0] rs1E,
                  output logic [4:0] rs2E,
                  output logic [4:0] rdE,
                  output logic [2:0] funct3E,
                  output logic [31:0] immextE);
  
  always_ff @(posedge clk) begin
    if (reset | clr) begin
      regwriteE <= 1'b0;
      resultsrcE <= 2'b0;
      memwriteE <= 1'b0;
      jumpE <= 1'b0;
      branchE <= 1'b0;
      alucontrolE <= 3'b0;
      alusrcE <= 1'b0;
      rd1E <= 32'b0;
      rd2E <= 32'b0;
      pcE <= 32'b0;
      pcplus4E <= 32'b0;
      rdE <= 5'b0;
      immextE <= 32'b0;
      rs1E <= 5'b0;
      rs2E <= 5'b0;
      funct3E <= 3'b0;
    end
    else begin
      regwriteE <= regwriteD;
      resultsrcE <= resultsrcD;
      memwriteE <= memwriteD;
      jumpE <= jumpD;
      branchE <= branchD;
      alucontrolE <= alucontrolD;
      alusrcE <= alusrcD;
      rd1E <= rd1D;
      rd2E <= rd2D;
      pcE <= pcD;
      pcplus4E <= pcplus4D;
      rdE <= rdD;
      immextE <= immextD;
      rs1E <= rs1D;
      rs2E <= rs2D;
      funct3E <= funct3D;
    end
  end
endmodule
