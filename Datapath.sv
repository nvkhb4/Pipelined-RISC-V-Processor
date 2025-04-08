module datapath(input logic clk, reset,
                input logic [1:0] ResultSrcD,
input logic ALUSrcD,
input logic RegWriteD,
                input logic [1:0] ImmSrcD,
                input logic [2:0] ALUControlD,
                input logic MemWriteD,
                input logic JumpD,
                input logic BranchD,
output logic ZeroE,
                output logic [31:0] PCF,
                output logic [31:0] ALUResultW, WriteData,
                input logic [31:0] ReadData,
                output logic [31:0] InstrD);
  logic [31:0] InstrF;
  logic [31:0] PCNextF, PCPlus4F, PCTargetE;
  logic [31:0] PCD, PCPlus4D, PCE, PCPlus4E, PCPlus4M, PCPlus4W;
  logic [31:0] ImmExtD, ImmExtE;
  logic [31:0] SrcAD, SrcAE, SrcBE;
  logic [31:0] ResultW;
  logic [31:0] WriteDataD, WriteDataE, WriteDataM;
  logic RegWriteW, RegWriteE, RegWriteM;
  logic [1:0] ResultSrcE, ResultSrcM, ResultSrcW;
  logic MemWriteE, MemWriteM;
  logic JumpE, BranchE;
  logic [2:0] ALUControlE;
  logic ALUSrcE;
  logic [31:0] ALUResultE, ALUResultM;
  logic [31:0] ReadDataM, ReadDataW;
  logic [4:0] RdE, RdM, RdW;
  logic [1:0] ForwardAE, ForwardBE;
  logic [31:0] out_aE, out_bE, out_bM;
  logic [4:0] Rs1E, Rs2E;
  logic StallF, StallD, FlushE,FlushD;
  logic PCSrcE;
  
 // next PC logic
  flopenr #(32) pcreg(clk, reset, StallF, PCNextF, PCF);
  
  //instruction memory logic
  imem imem(PCF, InstrF);
  
  adder pcadd4(PCF, 32'd4, PCPlus4F);
  
  //decode stage pipeline
  pipeline_d pd(clk, reset, StallD, FlushD, InstrF, PCF, PCPlus4F, InstrD, PCD, PCPlus4D);
 
 // register file logic
  regfile rf(clk,RegWriteW,InstrD[19:15],InstrD[24:20],RdW,ResultW,SrcAD,WriteDataD);
  //extend unit logic
  extend ext(InstrD[31:7], ImmSrcD, ImmExtD);
  
  //execute stage pipeline
  pipeline_e pe(clk, reset, FlushE, RegWriteD, ResultSrcD, MemWriteD, JumpD, BranchD, ALUControlD, ALUSrcD, SrcAD, WriteDataD, PCD, PCPlus4D, InstrD[19:15], InstrD[24:20], InstrD[11:7], InstrD[14:12], ImmExtD, RegWriteE, ResultSrcE, MemWriteE, JumpE, BranchE, ALUControlE, ALUSrcE, SrcAE, WriteDataE, PCE, PCPlus4E, Rs1E, Rs2E, RdE, funct3E, ImmExtE);
  
  //forwarding logic
  forwarding_unit fu(RegWriteM, RegWriteW, Rs1E, Rs2E, RdM, RdW, ForwardAE, ForwardBE);
  mux3 #(32) forward_a_mux(SrcAE, ResultW, ALUResultM, ForwardAE, out_aE); //out_aE is the new SrcAE now
  mux3 #(32) forward_b_mux(WriteDataE, ResultW, ALUResultM, ForwardBE, out_bE); //out_BE is the new writedata now
  
 // ALU logic
  mux2 #(32) srcbmux(out_bE, ImmExtE, ALUSrcE, SrcBE); 
  alu alu(out_aE, SrcBE, ALUControlE, ALUResultE, ZeroE); //srcBE is the new out_bE now
  
  //branching logic - shifted from controller to here
  always_comb begin
    if (JumpE) begin
      PCSrcE = 1; //jal only
    end
    else if (BranchE) begin //for all b-type instructions
      case(funct3E)
          3'b000: PCSrcE <= ZeroE; //beq only if subtraction yields 0     
          3'b001: PCSrcE <= ~ZeroE; //bne only if subtraction yields non-zero
        3'b100: PCSrcE <= ALUResultE[0]; //blt if srca < srcb yields true
        3'b101: PCSrcE <= ~ALUResultE[0]; //bge if srca < srcb yields false,
          default: PCSrcE <= 1'b0;
        endcase        
    end
    else PCSrcE <= 1'b0;
  end
  
  //branch adder logic
  adder pcaddbranch(PCE, ImmExtE, PCTargetE);
  mux2 #(32) pcmux(PCPlus4F, PCTargetE, PCSrcE, PCNextF);
  
  //memory stage pipeline
  pipeline_m pm(clk, reset, RegWriteE, ResultSrcE, MemWriteE, ALUResultE, out_bE, RdE, PCPlus4E, RegWriteM, ResultSrcM, MemWriteM, ALUResultM, out_bM, RdM, PCPlus4M); 
  
  //data memory logic
  dmem dmem(clk, MemWriteM, ALUResultM, out_bM, ReadDataM);
  
  //writeback stage pipeline
  pipeline_w pw(clk, reset, RegWriteM, ResultSrcM, ALUResultM, ReadDataM, RdM, PCPlus4M, RegWriteW, ResultSrcW, ALUResultW, ReadDataW, RdW, PCPlus4W);
  
  //result mux logic
  mux3 #(32) resultmux(ALUResultW, ReadDataW, PCPlus4W,
ResultSrcW, ResultW);
  
  //hazard unit logic
  hazard_unit hu(InstrD[19:15], InstrD[24:20], RdE, ResultSrcE[0], PCSrcE, StallF, StallD, FlushE, FlushD);
endmodule
