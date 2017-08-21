`timescale 1ns / 1ps
`define CYCLE 10
`define DELAY `CYCLE/8
`define WORD  64
`define INST_LEN 32
`define ZERO `WORD'b0
`define ONE `WORD'b1
`define DMEMFILE  "../../../../testfiles/sumD.data"
`define IMEMFILE  "../../../../testfiles/sumI.data"
`define RMEMFILE  "../../../../testfiles/sumR.data"

`define RTYPE 6'b000000
`define LW    6'b100011
`define SW    6'b101011
`define BEQ   6'b000100

`define F_ADD 6'b100000
`define F_SUB 6'b100010
`define F_AND 6'b100100
`define F_OR  6'b100101
`define F_NOR 6'b100111
`define F_SLT 6'b101010

`define ALU_ADD 4'b0010
`define ALU_SUB 4'b0110
`define ALU_AND 4'b0000
`define ALU_OR  4'b0001
`define ALU_NOR 4'b1100
`define ALU_SLT 4'b0111

`define ALUOp_R   2'b10
`define ALUOp_ADD 2'b00
`define ALUOp_SUB 2'b01

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
