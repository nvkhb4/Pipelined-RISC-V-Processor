module forwarding_unit(input logic RegWriteM,
                       input logic RegWriteW,
                       input logic [4:0] Rs1E,
                       input logic [4:0] Rs2E,
                       input logic [4:0] RdM,
                       input logic [4:0] RdW,
                       output logic [1:0] ForwardAE,
                       output logic [1:0] ForwardBE);
  
  always_comb begin
    if ((Rs1E == RdM) && RegWriteM && (Rs1E != 0)) begin //copied this logic from the book so not much explaining to do
    ForwardAE = 2'b10;
  end
  else if ((Rs1E == RdW) && RegWriteW && (Rs1E != 0)) begin
    ForwardAE = 2'b01;
  end
  else begin
    ForwardAE = 2'b00;
  end

  if ((Rs2E == RdM) && RegWriteM && (Rs2E != 0)) begin
    ForwardBE = 2'b10;
  end
  else if ((Rs2E == RdW) && RegWriteW && (Rs2E != 0)) begin
    ForwardBE = 2'b01;
  end
  else begin
    ForwardBE = 2'b00;
  end
end
endmodule
