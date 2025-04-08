module hazard_unit(input logic [4:0] Rs1D,
                   input logic [4:0] Rs2D,
                   input logic [4:0] RdE,
                   input logic ResultSrco,
                   input logic PCSrcE,
                   output logic StallF,
                   output logic StallD,
                   output logic FlushE,
                  output logic FlushD);
  
  logic lwStall;
  
  always_comb begin
    if (ResultSrco && ((Rs1D == RdE) | (Rs2D == RdE))) begin
      StallF <= 1'b0;
      StallD <= 1'b0;
      lwStall <= 1'b1; 
    end
    else begin
    	StallF <= 1'b1;
    	StallD <= 1'b1;
    	lwStall <= 1'b0;
    end
    FlushD <= PCSrcE;
    FlushE <= PCSrcE | lwStall;
  end
endmodule
