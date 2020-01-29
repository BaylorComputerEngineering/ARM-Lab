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


reg [`INSTR_LEN-1:0] cr;
string instr_string = "|instruction|";

initial
begin
    // call a verification function at the beginning to start the log
    begin_test();
    
    pc = `WORD'd0;
    #`CYCLE;
    cr = `INSTR_LEN'hABCDEF12;
    verify(instr_string, cr, $bits(cr), instr, $bits(instr), `HEX);
    
    pc = `WORD'd4;
    #`CYCLE;
    cr = `INSTR_LEN'hBCDEF123;
    verify(instr_string, cr, $bits(cr), instr, $bits(instr), `HEX);
       
    pc = `WORD'd8;
    #8;    
    cr = `INSTR_LEN'hCDEF1234;
    verify(instr_string, cr, $bits(cr), instr, $bits(instr), `HEX);
    
    pc = `WORD'd12;
    #4;    
    cr = `INSTR_LEN'hCDEF1234;
    verify(instr_string, cr, $bits(cr), instr, $bits(instr), `HEX);
    
    pc = `WORD'd16;
    #4;   
    cr = `INSTR_LEN'hEF123456;
    verify(instr_string, cr, $bits(cr), instr, $bits(instr), `HEX);

    pc = `WORD'd52;
    #`CYCLE;
    cr = `INSTR_LEN'h89ABCDEF;
    verify(instr_string, cr, $bits(cr), instr, $bits(instr), `HEX);

    pc = `WORD'd56;
    #`CYCLE;
    cr = `INSTR_LEN'h9ABCDEF1;
    verify(instr_string, cr, $bits(cr), instr, $bits(instr), `HEX);

    pc = `WORD'd28;
    #`CYCLE;
    cr = `INSTR_LEN'h23456789;
    verify(instr_string, cr, $bits(cr), instr, $bits(instr), `HEX);

    final_result();
       
    $finish;
end
endmodule
