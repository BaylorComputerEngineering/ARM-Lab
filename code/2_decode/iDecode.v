`include "definitions.vh"

module iDecode(
    input clk,
    input reset,
    input [`WORD-1:0] nPC,
    input [`INSTR_LEN-1:0] Instruction,
    output [4:0]Rm_num,
    output [4:0]Rn_num,
    output [4:0]Rd_num,
    output [8:0]Address,
    output [10:0]Opcode
    );

    // Add code to populate outputs

endmodule
