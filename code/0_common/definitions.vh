`timescale 1ns / 1ps
`define CYCLE 10
`define WORD  64
`define INSTR_LEN 32
`define DMEMFILE  "C:/Users/potterst/Documents/CompOrg/testfiles/fibD.data"
`define IMEMFILE  "C:/Users/potterst/Documents/CompOrg/testfiles/fibI.data"
`define RMEMFILE  "C:/Users/potterst/Documents/CompOrg/testfiles/fibR.data"
//`define DMEMFILE  "C:/Users/schubertk/Documents/Baylor/classes/3338/Project/testfiles/sumD.data"
//`define IMEMFILE  "C:/Users/schubertk/Documents/Baylor/classes/3338/Project/testfiles/sumI.data"
//`define RMEMFILE  "C:/Users/schubertk/Documents/Baylor/classes/3338/Project/testfiles/sumR.data"
//`define DMEMFILE  "C:/Users/schubertk/Documents/Baylor/classes/3338/Project/verilog/Keith/dmem_sample.list"
//`define IMEMFILE  "C:/Users/schubertk/Documents/Baylor/classes/3338/Project/verilog/Keith/imem_sample.list"
//`define RMEMFILE  "C:/Users/schubertk/Documents/Baylor/classes/3338/Project/verilog/Keith/dmem_sample.list"

`define ADD  11'b10001011000
`define SUB  11'b11001011000
`define AND  11'b10001010000
`define ORR  11'b10101010000
`define LDUR 11'b11111000010
`define STUR 11'b11111000000
`define CBZ  11'b00010110100

`define ALU_ADD 4'b0010
`define ALU_SUB 4'b0110
`define ALU_AND 4'b0000
`define ALU_OR  4'b0001
`define ALU_NOR 4'b1100
`define ALU_SLT 4'b0111

`define ALUOp_RTYPE   2'b10
`define ALUOp_DTYPE   2'b00
`define ALUOp_CBZ     2'b01


`define CLOG2(x) \
   (x <= 2) ? 1 : \
   (x <= 4) ? 2 : \
   (x <= 8) ? 3 : \
   (x <= 16) ? 4 : \
   (x <= 32) ? 5 : \
   (x <= 64) ? 6 : \
   (x <= 128) ? 7 : \
   (x <= 256) ? 8 : \
   (x <= 512) ? 9 : \
   (x <= 1024) ? 10 : \
   (x <= 2048) ? 11 : \
   (x <= 4096) ? 12 : \
   (x <= 8192) ? 13 : \
   (x <= 16384) ? 14 : \
   (x <= 32768) ? 15 : \
   (x <= 65536) ? 16 : \
//   (x <= 4294967296) ? 32 : \
   -1
