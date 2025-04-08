module alu(input logic [31:0] SrcA,
           input logic [31:0] SrcB,
           input logic [2:0] ALUControl,
           output logic [31:0] Result,
           output logic Zero);
  always@(*) begin
    
    if ( ALUControl == 3'b000 ) // ADD
     Result = SrcA + SrcB;
    else if ( ALUControl == 3'b001 ) // SUBTRACT
     Result = SrcA  + (~SrcB + 1'b1);
    else if ( ALUControl == 3'b010 ) // AND
     Result = SrcA & SrcB;
    else if ( ALUControl == 3'b011 )// OR
     Result = SrcA | SrcB;
    else if ( ALUControl == 3'b101 )// SLT
     Result = SrcA < SrcB;
    else
     Result = 32'h00000000; 
  end
  assign Zero = &(~Result);
endmodule
