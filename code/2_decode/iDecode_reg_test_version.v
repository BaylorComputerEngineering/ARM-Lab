`include "definitions.vh"

module iDecode(
    input clk,
    input reset,
    input [`WORD-1:0] nPC,
    input [`INSTR_LEN-1:0] Instruction,
    input [`WORD-1:0] Write_data,
    input Reg2Loc,
    input RegWrite,
    output reg [4:0]Rm_num,
    output reg [4:0]Rn_num,
    output reg [4:0]Rd_num,
    output reg [4:0]Read_register1,
    output reg [4:0]Read_register2,
    output reg [4:0]Write_register,
    output [`WORD-1:0]Read_data1,
    output [`WORD-1:0]Read_data2,
    output reg [8:0]Address,
    output reg [10:0]Opcode
    );
    
endmodule
