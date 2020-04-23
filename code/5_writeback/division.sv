`include "verification_functions.sv"

module division;

import verification::*;

int tc = 1;

wire clk;
reg reset;
wire pc_src;
wire [`WORD-1:0] cur_pc;
wire [`INSTR_LEN-1:0] instruction;
wire read_clk;
wire write_clk;
wire [`WORD-1:0] write_data;
wire [`WORD-1:0] sign_extended_output;
wire reg2_loc;
wire uncondbranch;
wire branch;
wire mem_read;
wire mem_to_reg;
wire [1:0] alu_op;
wire mem_write;
wire alu_src;
wire reg_write;
wire [`WORD-1:0]read_data1;
wire [`WORD-1:0]read_data2;
wire [10:0] opcode;
wire[`WORD-1:0] branch_target;
wire [`WORD-1:0] alu_result;
wire zero;
wire [`WORD-1:0]mem_read_data;

reg [`WORD -1:0] cr_read_data2;

string read_data2_string = "|read_data2|";
    
iFetch#(.SIZE(16))  iF(
    .clk(clk),
    .clk_delayed(clk_plus_1),
    .reset(reset),
    .pc_src(pc_src),
    .branch_target(branch_target),
    .instruction(instruction),
    .cur_pc(cur_pc)
    );    
    
// Add the other 4 stage modules here


oscillator myOsc(clk);

delay #(1) clk_delay_1(
    .a(clk),
    .a_delayed(clk_plus_1)
    );   

// create the rest of your clocks here

initial 
begin

begin_test();
reset = 1;
#`CYCLE;
reset = 0;
      
#330;

cr_read_data2 = `WORD'd7;
verify(read_data2_string, cr_read_data2, $bits(cr_read_data2), read_data2, $bits(read_data2), `S_DEC);
#10;

final_result();

$finish;

end
endmodule