`include "verification_functions.sv"

module iFetch_test;
import verification::*;
wire clk;
reg reset;
reg pc_src;
reg [`WORD-1:0] branch_target;
wire [`WORD-1:0] cur_pc;
wire [`INSTR_LEN-1:0] instruction;

reg [`INSTR_LEN-1:0] er_instruction;
reg [`WORD-1:0] er_cur_pc;
string pc_string = "|cur_pc|";
string instr_string = "|instruction|";
int ts = 1;
int tc = 1;

oscillator clk_gen(clk);

delay clk_delay_1(
    .a(clk),
    .a_delayed(clk_plus_1)
    );   

iFetch#(.SIZE(16))  iF(
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


///// TEST CASE 1 /////
$display("Test Case %0d", tc++);
ts = 1;
branch_target=`WORD'd44;
pc_src=0;

// set reset to 1 to keep the program counter set to 0 during the
// first clock cycle. Otherwise it will increment and we will 
// never fetch the first instruction.
reset=1;
#(`CYCLE);
// set reset back to 0 to allow the program counter to increment 
//  on the next positive clock edge
reset=0;

er_cur_pc=`WORD'd0; 
verify(ts++, pc_string, er_cur_pc, $bits(er_cur_pc), cur_pc, $bits(cur_pc), `S_DEC);
er_instruction = `INSTR_LEN'hABCDEF12;
verify(ts++, instr_string, er_instruction, $bits(er_instruction), instruction, $bits(instruction), `HEX);

///// TEST CASE 2 /////
$display("Test Case %0d", tc++);
ts = 1;
#`CYCLE;
er_cur_pc=`WORD'd4; 
verify(ts++, pc_string, er_cur_pc, $bits(er_cur_pc), cur_pc, $bits(cur_pc), `S_DEC);
er_instruction = `INSTR_LEN'hBCDEF123;
verify(ts++, instr_string, er_instruction, $bits(er_instruction), instruction, $bits(instruction), `HEX);

///// TEST CASE 3 /////
$display("Test Case %0d", tc++);
ts = 1;
#`CYCLE;
er_cur_pc=`WORD'd8; 
verify(ts++, pc_string, er_cur_pc, $bits(er_cur_pc), cur_pc, $bits(cur_pc), `S_DEC);
er_instruction = `INSTR_LEN'hCDEF1234;
verify(ts++, instr_string, er_instruction, $bits(er_instruction), instruction, $bits(instruction), `HEX);

///// TEST CASE 4 /////
$display("Test Case %0d", tc++);
ts = 1;
#(`CYCLE+2);
er_cur_pc=`WORD'd12; 
verify(ts++, pc_string, er_cur_pc, $bits(er_cur_pc), cur_pc, $bits(cur_pc), `S_DEC);
er_instruction = `INSTR_LEN'hDEF12345;
verify(ts++, instr_string, er_instruction, $bits(er_instruction), instruction, $bits(instruction), `HEX);

///// TEST CASE 5 /////
$display("Test Case %0d", tc++);
ts = 1;
pc_src = 1;
#`CYCLE;
er_cur_pc=branch_target; 
verify(ts++, pc_string, er_cur_pc, $bits(er_cur_pc), cur_pc, $bits(cur_pc), `S_DEC);
er_instruction = `INSTR_LEN'h6789ABCD;
verify(ts++, instr_string, er_instruction, $bits(er_instruction), instruction, $bits(instruction), `HEX);
pc_src = 0;

///// TEST CASE 6 /////
$display("Test Case %0d", tc++);
ts = 1;
#`CYCLE;
er_cur_pc=branch_target+4; 
verify(ts++, pc_string, er_cur_pc, $bits(er_cur_pc), cur_pc, $bits(cur_pc), `S_DEC);
er_instruction = `INSTR_LEN'h789ABCDE;
verify(ts++, instr_string, er_instruction, $bits(er_instruction), instruction, $bits(instruction), `HEX);

///// TEST CASE 7 /////
$display("Test Case %0d", tc++);
ts = 1;
#(`CYCLE/5);
er_cur_pc=branch_target+4; 
verify(ts++, pc_string, er_cur_pc, $bits(er_cur_pc), cur_pc, $bits(cur_pc), `S_DEC);
er_instruction = `INSTR_LEN'h789ABCDE;
verify(ts++, instr_string, er_instruction, $bits(er_instruction), instruction, $bits(instruction), `HEX);

///// TEST CASE 8 /////
$display("Test Case %0d", tc++);
ts = 1;
branch_target = `WORD'd20;
pc_src = 1;
#`CYCLE;
er_cur_pc=branch_target; 
verify(ts++, pc_string, er_cur_pc, $bits(er_cur_pc), cur_pc, $bits(cur_pc), `S_DEC);
er_instruction = `INSTR_LEN'hF1234567;
verify(ts++, instr_string, er_instruction, $bits(er_instruction), instruction, $bits(instruction), `HEX);

///// TEST CASE 9 /////
$display("Test Case %0d", tc++);
ts = 1;
branch_target = `WORD'd32;
#`CYCLE;
er_cur_pc=branch_target; 
verify(ts++, pc_string, er_cur_pc, $bits(er_cur_pc), cur_pc, $bits(cur_pc), `S_DEC);
er_instruction = `INSTR_LEN'h3456789A;
verify(ts++, instr_string, er_instruction, $bits(er_instruction), instruction, $bits(instruction), `HEX);
pc_src = 0;

///// TEST CASE 10 /////
$display("Test Case %0d", tc++);
ts = 1;
#`CYCLE;
er_cur_pc=branch_target+4; 
verify(ts++, pc_string, er_cur_pc, $bits(er_cur_pc), cur_pc, $bits(cur_pc), `S_DEC);
er_instruction = `INSTR_LEN'h456789AB;
verify(ts++, instr_string, er_instruction, $bits(er_instruction), instruction, $bits(instruction), `HEX);

///// TEST CASE 11 /////
$display("Test Case %0d", tc++);
ts = 1;
#`CYCLE;
er_cur_pc=branch_target+8; 
verify(ts++, pc_string, er_cur_pc, $bits(er_cur_pc), cur_pc, $bits(cur_pc), `S_DEC);
er_instruction = `INSTR_LEN'h56789ABC;
verify(ts++, instr_string, er_instruction, $bits(er_instruction), instruction, $bits(instruction), `HEX);

final_result();

$finish;
end
endmodule
