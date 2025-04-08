module imem(input logic [31:0] a,
             output logic [31:0] rd);
  logic [31:0] RAM[63:0];
 initial
   begin
     
     //test for forwarding
     /*RAM[0] <= 32'h00800a13; //addi x20, x0, 8
     RAM[1] <= 32'h00a00a93; //addi x21, x0, 10
     RAM[2] <= 32'h00600993; //addi x19, x0, 6
     RAM[3] <= 32'h00400393; //addi x7, x0, 4
     RAM[4] <= 32'h00c00f93; //addi x31, x0, 12
     RAM[5] <= 32'h015a0c33; //add x24, x20, x21
     RAM[6] <= 32'h413c0933; //sub x18, x24, x19
     RAM[7] <= 32'h018fecb3; //or x25, x31, x24
     RAM[8] <= 32'h007c7bb3; //and x23, x24, x7 */
     
     //hazard unit testing
     /* RAM[0] <= 32'h00a00a93; //addi x21 x0 10
     RAM[1] <= 32'h00600e13; //addi x28, x0, 6
     RAM[2] <= 32'h00c00b13; //addi x22, x0, 12
     RAM[3] <= 32'h00400913; //addi x18, x0, 4
     RAM[4] <= 32'h028aab83; //lw x23, 40(x21) load 3 at 23
     RAM[5] <= 32'h01cbfc33; //and x24, x23, x28 (3 and 6) should be 2
     RAM[6] <= 32'h017b63b3; //or x7, x22, x23 (12 or 3) should be 15
     RAM[7] <= 32'h412b89b3; //sub x19, x23, x18 */
     
     //hazard unit testing for b-type
     RAM[0] <= 32'h00100493; //addi x9, x0, 1
     RAM[1] <= 32'h00100913; //addi x18, x0, 1
     RAM[2] <= 32'h00100993; //addi x19, x0, 1
     RAM[3] <= 32'h00100a13; //addi x20, x0, 1
     RAM[4] <= 32'h00100a93; //addi x21, x0, 1
     RAM[5] <= 32'h00100313; //addi x6, x0, 1
     RAM[6] <= 32'h00100f93; //addi x31, x0, 1
     RAM[7] <= 32'h00990663; //beq x9, x18, 12
     RAM[8] <= 32'h41330c33; //sub x24, x6, x19
     RAM[9] <= 32'h015fecb3; //or x25, x31, x21
     RAM[10] <= 32'h01498bb3; //add x23, x19, x20 (branch target)
     
  end
 assign rd = RAM[a[31:2]]; // word aligned
endmodule
