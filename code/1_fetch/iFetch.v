`include "definitions.vh"

module iFetch#(parameter STEP=`WORD'd4, SIZE=1024)(
    input clk,
    input reset,
    input PCSrc,
    input [`WORD-1:0] BrDest,
    output [`WORD-1:0] nPC,
    output [`INSTR_LEN-1:0] IR
    );
    wire [`WORD-1:0] PC;
    wire [`WORD-1:0] new_PC;
    wire[`WORD-1:0] nextPC;
    
    assign nPC=nextPC;
    
    mux#(`WORD) PCsel(
    .Ain(),
    .Bin(),
    .control(),
    .mux_out()
    );
        
    register myPC(
    .clk(),
    .reset(),
    .D(),
    .Q()
    );
    
    adder incrementer(
    .Ain(),
    .Bin(),
    .add_out()
    );
    
    instr_mem#(SIZE) iMemory(
    .clk(),
    .pc(),
    .instruction()
    );
endmodule
