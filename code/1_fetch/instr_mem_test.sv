// include functions to verify functionality
`include "verification_functions.sv"

// create module register_test with no arguments
// no arguments implies that it is the top-level module
module instr_mem_test;

// import the verification package that was included above
import verification::*;

// create a 1-bit wire for use as a clock signal, oscillating between 0 and 1
wire clk;
reg [`WORD-1:0] pc;
wire [`INSTR_LEN-1:0] instr;

oscillator clk_gen(clk);

instr_mem #(64) UUT (
    .clk(clk),
    .pc(pc),
    .instruction(instr)
    );


reg [`INSTR_LEN-1:0] er;
string instr_string = "|instruction|";
int tc = 1;
int ts = 1;

initial
begin
    // call a verification function at the beginning to start the log
    begin_test();
    
    ///// TEST CASE 1 /////
    $display("Test Case %0d", tc++);
    pc = `WORD'd0;
    #`CYCLE;
    er = `INSTR_LEN'hABCDEF12;
    verify(ts, instr_string, er, $bits(er), instr, $bits(instr), `HEX);
    
    ///// TEST CASE 2 /////
    $display("Test Case %0d", tc++);
    pc = `WORD'd4;
    #`CYCLE;
    er = `INSTR_LEN'hBCDEF123;
    verify(ts, instr_string, er, $bits(er), instr, $bits(instr), `HEX);
       
    ///// TEST CASE 3 /////
    $display("Test Case %0d", tc++);    
    pc = `WORD'd8;
    #8;    
    er = `INSTR_LEN'hCDEF1234;
    verify(ts, instr_string, er, $bits(er), instr, $bits(instr), `HEX);
    
    ///// TEST CASE 4 /////
    $display("Test Case %0d", tc++);    
    pc = `WORD'd12;
    #4;    
    er = `INSTR_LEN'hCDEF1234;
    verify(ts, instr_string, er, $bits(er), instr, $bits(instr), `HEX);
    
    ///// TEST CASE 5 /////
    $display("Test Case %0d", tc++);    
    pc = `WORD'd16;
    #4;   
    er = `INSTR_LEN'hEF123456;
    verify(ts, instr_string, er, $bits(er), instr, $bits(instr), `HEX);

    ///// TEST CASE 6 /////
    $display("Test Case %0d", tc++);
    pc = `WORD'd52;
    #`CYCLE;
    er = `INSTR_LEN'h89ABCDEF;
    verify(ts, instr_string, er, $bits(er), instr, $bits(instr), `HEX);

    ///// TEST CASE 7 /////
    $display("Test Case %0d", tc++);
    pc = `WORD'd56;
    #`CYCLE;
    er = `INSTR_LEN'h9ABCDEF1;
    verify(ts, instr_string, er, $bits(er), instr, $bits(instr), `HEX);

    ///// TEST CASE 8 /////
    $display("Test Case %0d", tc++);
    pc = `WORD'd28;
    #`CYCLE;
    er = `INSTR_LEN'h23456789;
    verify(ts, instr_string, er, $bits(er), instr, $bits(instr), `HEX);

    final_result();
       
    $finish;
end
endmodule
