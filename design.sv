`include "Single_Cycle_Processor.sv"
`include "Controller.sv"
`include "Main_Decoder.sv"
`include "ALU_Decoder.sv"
`include "Datapath.sv"
`include "Adder.sv"
`include "Extend_Unit.sv"
`include "Resettable_Flip_Flop.sv"
`include "Resettable_Flip_Flop_With_Enable.sv"
`include "Multiplexer.sv"
`include "Multiplexer1.sv"
`include "Instruction_Memory.sv"
`include "Data_Memory.sv"
`include "Register_File.sv"
`include "ALU.sv"
`include "pipeline_d.sv"
`include "pipeline_e.sv"
`include "pipeline_m.sv"
`include "pipeline_w.sv"

module top(input logic clk, reset,
output logic [31:0] WriteData, DataAdr,
output logic MemWrite);
logic [31:0] PC, ReadData;
 
// instantiate processor and memories
 
riscvpipelined rvpipelined(clk, reset, PC, MemWrite,DataAdr, WriteData, ReadData);

endmodule
