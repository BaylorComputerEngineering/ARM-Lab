`include "verification_functions.sv"

module instr_parse_test;
import verification::*;

// create signals to be be passed into/out of the instruction_parse module

// create er signals that have the same names of the signals above except that they
// have er_ appended to the beginning of the name....for example, er_rm_num

// use this instruction_parse instance for this test
instr_parse parser(
.instruction(instruction),
.rm_num(rm_num),
.rn_num(rn_num),
.rd_num(rd_num),
.address(address),
.opcode(opcode)
    );
    
initial
begin
begin_test();

// populate instructions below with the binary form of the assembly instructions
// listed in the comments.  Note that these are almost very similar to the instructions
// shown in the lecture on Machine Code


///////////////////////////////////////////////////////////////////////////////////////////////
// LDUR X9, [X22, #240]

///// TEST CASE 1 /////
$display("Test Case %0d", tc++);
$display("LDUR X9, [X22, #240]");

// set instruction to the binary equivalent of the instruction listed above

// wait for 2 ns

// DO NOT verify rm_num is correct because it is not relevant for a D Type instruction
// verify rn_num is correct

// verify rd_num is correct

// verify address is correct

// verify opcode is correct

// wait for 8 ns


///////////////////////////////////////////////////////////////////////////////////////////////
// ADD X10, X21, X9

///// TEST CASE 2 /////
$display("\nTest Case %0d", tc++);
$display("ADD X10, X21, X9");

// set instruction to the binary equivalent of the instruction listed above

// wait for 2 ns

// verify rm_num is correct

// verify rn_num is correct

// verify rd_num is correct

// DO NOT verify address is correct because it is not relevant for an R Type instruction

// verify opcode is correct

// wait for 8 ns


///////////////////////////////////////////////////////////////////////////////////////////////
// STUR X10, [X23, #64]

///// TEST CASE 3 /////
$display("\nTest Case %0d", tc++);
$display("STUR X10, [X23, #64]");

// set instruction to the binary equivalent of the instruction listed above

// wait for 2 ns

// DO NOT verify rm_num is correct because it is not relevant for a D Type instruction
// verify rn_num is correct

// verify rd_num is correct

// verify address is correct

// verify opcode is correct

// wait for 8 ns

///////////////////////////////////////////////////////////////////////////////////////////////

final_result();
$finish;
end
endmodule
