`include "definitions.vh"

module instr_mem#(
    parameter SIZE=1024)(
    input clk,
    input [`WORD - 1:0] pc,
    output reg [`INSTR_LEN - 1:0] instruction
    );
    
    reg[`INSTR_LEN - 1:0] imem [SIZE-1:0];
    integer i;
    
    //handle output
    always @(posedge(clk))
        instruction<= imem[pc/4];
    
    //initialize memory from file
    initial
        $readmemb(`IMEMFILE, imem);

endmodule