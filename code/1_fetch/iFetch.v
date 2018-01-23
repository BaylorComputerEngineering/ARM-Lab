`include "definitions.vh"

module iFetch#(parameter STEP=`WORD'd4, SIZE=1024)(
    input clk,
    input reset,
    input pc_src,
    input [`WORD-1:0] branch_target,
    output [`WORD-1:0] incremented_pc,
    output [`INSTR_LEN-1:0] instruction,
    output[`WORD-1:0] cur_pc
    );
    wire [`WORD-1:0] new_pc;

    mux#(`WORD) pc_mux(
    .a_in(),
    .b_in(),
    .control(),
    .mux_out()
    );
    
    register pc_register(
    .clk(),
    .reset(),
    .D(),
    .Q()
    );
    
    adder incrementer(
    .a_in(),
    .b_in(),
    .add_out()
    );
       
    instr_mem#(SIZE) instr_mem(
    .clk(),
    .pc(),
    .instruction()
    );
endmodule