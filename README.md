# Pipelined-RISC-V-Processor
Project for my Computer Architecture and Assembly Language course. Adapted from the Single Cycle Processor in Digital Design and Computer Architecture - RISC-V edition (David Harris and Sarah Harris).

This processor is complete with the following components:
1. Forwarding unit
2. Hazard logic for load instructions
3. Hazard logic for branch instructions

Instructions implemented:
1. I-type: lw, addi, slti, ori, andi
2. S-type: sw
3. R-type: add, sub, or, and, slt
4. B-type: beq, bne, blt, bge

Note: seperate machine codes for forwarding and hazard unit testing are present in the instruction memory.
(will be adding more soon)
