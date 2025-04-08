module riscvpipelined(input logic clk, reset,
                   output logic [31:0] PCF,
				   output logic MemWrite,
				   output logic [31:0] ALUResult, WriteData,
				   input logic [31:0] ReadData);
	logic ALUSrc, RegWrite, Jump, Branch, Zero,PCSrc;
	logic [1:0] ResultSrc, ImmSrc;
	logic [2:0] ALUControl;
  logic [31:0] InstrD;
  controller c (InstrD[6:0], 
                 InstrD[14:12],
                 InstrD[30], 
                 Zero,
				 ResultSrc, 
                 MemWrite, 
                 PCSrc, 
                 ALUSrc, 
                 RegWrite, 
                 Jump,
                 Branch,
			 	 ImmSrc,
                 ALUControl);
   datapath dp(clk, 
               reset, 
               ResultSrc, 
               ALUSrc, 
               RegWrite, 
               ImmSrc, 
               ALUControl, 
               MemWrite,
               Jump,
               Branch,
               Zero, 
               PCF,  
               ALUResult, 
               WriteData,
               ReadData,
              InstrD);
endmodule
