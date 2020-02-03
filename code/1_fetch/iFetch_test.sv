`include "verification_functions.sv"

module iFetch_test;
import verification::*;
wire clk, clk_plus_1;
reg reset;
reg pc_src;
reg [`WORD-1:0] branch_target;
wire [`WORD-1:0] cur_pc;
wire [`INSTR_LEN-1:0] instruction;

reg [`INSTR_LEN-1:0] cr_instruction;
reg [`WORD-1:0] cr_cur_pc;
string pc_string = "|cur_pc|";
string instr_string = "|instruction|";

oscillator clk_gen(clk);

// Takes input of clk and produces a clock signal that is delay by 1 ns (clk_plus_1)  
delay clk_delay_1(
    .a(clk),
    .a_delayed(clk_plus_1)
    );   

iFetch#(.SIZE(64))  iF(
    .clk(clk),
    .clk_delayed(clk_plus_1),
    .reset(reset),
    .pc_src(pc_src),
    .branch_target(branch_target),
    .instruction(instruction),
    .cur_pc(cur_pc)
    );


initial 
begin
begin_test();

pc_src=0;
branch_target=`WORD'd44;

reset=1;
#(`CYCLE);
reset=0;
cr_cur_pc=`WORD'd0; 
//$display("Verify PC");
verify(pc_string, cr_cur_pc, $bits(cr_cur_pc), cur_pc, $bits(cur_pc), `S_DEC);
//$display("Verify Instruction");
cr_instruction = `INSTR_LEN'hABCDEF12;
verify(instr_string, cr_instruction, $bits(cr_instruction), instruction, $bits(instruction), `HEX);

#`CYCLE;
cr_cur_pc=`WORD'd4; 
verify(pc_string, cr_cur_pc, $bits(cr_cur_pc), cur_pc, $bits(cur_pc), `S_DEC);
cr_instruction = `INSTR_LEN'hBCDEF123;
verify(instr_string, cr_instruction, $bits(cr_instruction), instruction, $bits(instruction), `HEX);

#`CYCLE;
cr_cur_pc=`WORD'd8; 
verify(pc_string, cr_cur_pc, $bits(cr_cur_pc), cur_pc, $bits(cur_pc), `S_DEC);
cr_instruction = `INSTR_LEN'hCDEF1234;
verify(instr_string, cr_instruction, $bits(cr_instruction), instruction, $bits(instruction), `HEX);

#(`CYCLE+2);
cr_cur_pc=`WORD'd12; 
verify(pc_string, cr_cur_pc, $bits(cr_cur_pc), cur_pc, $bits(cur_pc), `S_DEC);
cr_instruction = `INSTR_LEN'hDEF12345;
verify(instr_string, cr_instruction, $bits(cr_instruction), instruction, $bits(instruction), `HEX);

pc_src = 1;
#`CYCLE;
cr_cur_pc=branch_target; 
verify(pc_string, cr_cur_pc, $bits(cr_cur_pc), cur_pc, $bits(cur_pc), `S_DEC);
cr_instruction = `INSTR_LEN'h6789ABCD;
verify(instr_string, cr_instruction, $bits(cr_instruction), instruction, $bits(instruction), `HEX);
pc_src = 0;

#`CYCLE;
cr_cur_pc=branch_target+4; 
verify(pc_string, cr_cur_pc, $bits(cr_cur_pc), cur_pc, $bits(cur_pc), `S_DEC);
cr_instruction = `INSTR_LEN'h789ABCDE;
verify(instr_string, cr_instruction, $bits(cr_instruction), instruction, $bits(instruction), `HEX);

#(`CYCLE/5);
cr_cur_pc=branch_target+4; 
verify(pc_string, cr_cur_pc, $bits(cr_cur_pc), cur_pc, $bits(cur_pc), `S_DEC);
cr_instruction = `INSTR_LEN'h789ABCDE;
verify(instr_string, cr_instruction, $bits(cr_instruction), instruction, $bits(instruction), `HEX);

branch_target = `WORD'd20;
pc_src = 1;
#`CYCLE;
cr_cur_pc=branch_target; 
verify(pc_string, cr_cur_pc, $bits(cr_cur_pc), cur_pc, $bits(cur_pc), `S_DEC);
cr_instruction = `INSTR_LEN'hF1234567;
verify(instr_string, cr_instruction, $bits(cr_instruction), instruction, $bits(instruction), `HEX);

branch_target = `WORD'd32;
#`CYCLE;
cr_cur_pc=branch_target; 
verify(pc_string, cr_cur_pc, $bits(cr_cur_pc), cur_pc, $bits(cur_pc), `S_DEC);
cr_instruction = `INSTR_LEN'h3456789A;
verify(instr_string, cr_instruction, $bits(cr_instruction), instruction, $bits(instruction), `HEX);
pc_src = 0;

#`CYCLE;
cr_cur_pc=branch_target+4; 
verify(pc_string, cr_cur_pc, $bits(cr_cur_pc), cur_pc, $bits(cur_pc), `S_DEC);
cr_instruction = `INSTR_LEN'h456789AB;
verify(instr_string, cr_instruction, $bits(cr_instruction), instruction, $bits(instruction), `HEX);

#`CYCLE;
cr_cur_pc=branch_target+8; 
verify(pc_string, cr_cur_pc, $bits(cr_cur_pc), cur_pc, $bits(cur_pc), `S_DEC);
cr_instruction = `INSTR_LEN'h56789ABC;
verify(instr_string, cr_instruction, $bits(cr_instruction), instruction, $bits(instruction), `HEX);

#1;
cr_cur_pc=branch_target+8; 
verify(pc_string, cr_cur_pc, $bits(cr_cur_pc), cur_pc, $bits(cur_pc), `S_DEC);
cr_instruction = `INSTR_LEN'h56789ABC;
verify(instr_string, cr_instruction, $bits(cr_instruction), instruction, $bits(instruction), `HEX);

#1;
cr_cur_pc=branch_target+12; 
verify(pc_string, cr_cur_pc, $bits(cr_cur_pc), cur_pc, $bits(cur_pc), `S_DEC);
cr_instruction = `INSTR_LEN'h56789ABC;
verify(instr_string, cr_instruction, $bits(cr_instruction), instruction, $bits(instruction), `HEX);

#1;
cr_cur_pc=branch_target+12; 
verify(pc_string, cr_cur_pc, $bits(cr_cur_pc), cur_pc, $bits(cur_pc), `S_DEC);
cr_instruction = `INSTR_LEN'h6789ABCD;
verify(instr_string, cr_instruction, $bits(cr_instruction), instruction, $bits(instruction), `HEX);
final_result();

$finish;
end
endmodule
