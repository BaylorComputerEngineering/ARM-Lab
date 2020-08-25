// include functions to verify functionality
`include "verification_functions.sv"

// create module register_test with no arguments
// no arguments implies that it is the top-level module
module register_test;

// import the verification package that was included above
import verification::*;

// declare a test case variable to clearly indicate which
// test case is being run
// this variable will be incremented after each test case
int tc = 1;

// declare a test case variable to clearly indicate which
// test step is being run
// this variable will be incremented after each test step
// but will be set back to 1 for each new test case
// each test case has one or more test steps
int ts = 1;

// create a 1-bit wire for use as a clock signal, oscillating between 0 and 1
wire clk;

// create a 1-bit reg to be used as the reset pin on the D Flip Flop
reg rst;

// create a 64 bit reg that will be used to set the D input of the Flip Flop
reg[`WORD - 1:0] d;

// create a 64 bit wire that will carry the Q output from the Flip Flop
wire[`WORD - 1:0] q;

// create a 64 bit reg that you will set to the expected result (er) of q 
reg[`WORD - 1:0] er_q;

// create an instance of the oscillator module (provided) that will toggle the
// clock signal with a cycle time of 10ns
oscillator clk_gen(clk);

// create an instance of the register module called myreg
// use the clk, rst, in, and out signals as inputs/outputs
// to this instance of the register module
// note that the name that comes after the dot is the port name
// and the the name in parentheses is the signal name that connects
// to that port.  They can be the same but do not have to be the same
register myreg(
    .clk(clk),
    .reset(rst),
    .D(d),
    .Q(q)
    );

// create strings for each item to be verified
// these are used to clearly indicate which signal 
// is being verified
string q_string = "|q|";

// the initial section is executed one time when the system starts up
// the initial section is a procedural block, meaning that regs must 
// be used for signals that you will be manipulating in the initial section
initial
begin
    // call a verification function at the beginning to start the log
    begin_test();

///// TEST CASE 1 /////
    $display("Test Case %0d", tc++);

    // set the reset pin to 0
    rst = 0;
    
    // set in to 0 (sets all 64 bits to a value of 0 in decimal)
    d = `WORD'd0; 
    // wait for one cycle (10ns)
    #`CYCLE;
    
    // set the expected result (er) to the value that you believe should 
    // be produced on the Q output at this particular point in time
    er_q=`WORD'dX; 
    
    // call the verify function from the verification package
    // this function can be viewed in verification_functions.sv
    // the verify function compares the value of er to the value
    // of ar (actual result, see function definition).  It also 
    // compares the size of ar and er 
    $display("Inputs: rst = %0d | d = %0d", rst, $signed(d)); 
    verify(ts, q_string, er_q, $bits(er_q), q, $bits(q), `S_DEC);

///// TEST CASE 2 /////
  
    // repeat the previous steps using different input values and 
    // different delays
    $display("\nTest Case %0d", tc++);    
    d = `WORD'd527; 
    #`CYCLE;
    er_q = `WORD'dX;
    $display("Inputs: rst = %0d | d = %0d", rst, $signed(d)); 
    verify(ts, q_string, er_q, $bits(er_q), q, $bits(q), `S_DEC);

///// TEST CASE 3 /////

    $display("\nTest Case %0d", tc++);
    d = -`WORD'd8; 
    #`CYCLE;
    er_q = -`WORD'dX; 
    $display("Inputs: rst = %0d | d = %0d", rst, $signed(d)); 
    verify(ts, q_string, er_q, $bits(er_q), q, $bits(q), `S_DEC);

///// TEST CASE 4 /////

    $display("\nTest Case %0d", tc++);
    d = `WORD'h3456789ABCDEF012; 
    #`CYCLE;
    er_q = `WORD'hX; 
    $display("Inputs: rst = %0d | d = %0d", rst, $signed(d)); 
    verify(ts, q_string, er_q, $bits(er_q), q, $bits(q), `HEX);

///// TEST CASE 5 /////
   
    $display("\nTest Case %0d", tc++);
    d = `WORD'd77; 
    #`CYCLE;
    er_q = `WORD'dX; 
    $display("Inputs: rst = %0d | d = %0d", rst, $signed(d)); 
    verify(ts, q_string, er_q, $bits(er_q), q, $bits(q), `S_DEC);

///// TEST CASE 6 /////
   
    $display("\nTest Case %0d", tc++);
    d = `WORD'd4; 
    #(`CYCLE/5);
    er_q = `WORD'dX; 
    $display("Inputs: rst = %0d | d = %0d", rst, $signed(d)); 
    verify(ts, q_string, er_q, $bits(er_q), q, $bits(q), `S_DEC);

///// TEST CASE 7 /////
    
    $display("\nTest Case %0d", tc++);
    d = `WORD'd18; 
    #(`CYCLE*4/5);
    er_q = `WORD'dX; 
    $display("Inputs: rst = %0d | d = %0d", rst, d); 
    verify(ts, q_string, er_q, $bits(er_q), q, $bits(q), `S_DEC);

///// TEST CASE 8 /////
    
    $display("\nTest Case %0d", tc++);
    #3;
    rst = 1;
    #1;
    er_q = `WORD'dX;
    $display("Inputs: rst = %0d | d = %0d", rst, $signed(d)); 
    verify(ts, q_string, er_q, $bits(er_q), q, $bits(q), `S_DEC);

///// TEST CASE 9 /////

    $display("\nTest Case %0d", tc++);
    #(`CYCLE/2);
    rst = 0;
    d = `WORD'd981;    
    #(`CYCLE/2);
    er_q = `WORD'dX; 
    $display("Inputs: rst = %0d | d = %0d", rst, $signed(d)); 
    verify(ts, q_string, er_q, $bits(er_q), q, $bits(q), `S_DEC);

///// TEST CASE 10 /////

    $display("\nTest Case %0d", tc++);
    #(`CYCLE/2);
    er_q = `WORD'dX; 
    $display("Inputs: rst = %0d | d = %0d", rst, $signed(d)); 
    verify(ts, q_string, er_q, $bits(er_q), q, $bits(q), `S_DEC);
    
///// TEST CASE 11 ///// 

    $display("\nTest Case %0d", tc++);
    #1;
    rst=1;
    #(`CYCLE/2);
    er_q = `WORD'dX;
    $display("Inputs: rst = %0d | d = %0d", rst, $signed(d)); 
    verify(ts, q_string, er_q, $bits(er_q), q, $bits(q), `S_DEC);

///// TEST CASE 12 /////
        
    $display("\nTest Case %0d", tc++);
    #2;
    d = `WORD'd345;
    er_q = `WORD'dX;
    $display("Inputs: rst = %0d | d = %0d", rst, $signed(d)); 
    verify(ts, q_string, er_q, $bits(er_q), q, $bits(q), `S_DEC);

///// TEST CASE 13 /////

    $display("\nTest Case %0d", tc++);
    #2;    
    rst = 0;
    #1
    er_q = `WORD'dX;
    $display("Inputs: rst = %0d | d = %0d", rst, $signed(d)); 
    verify(ts, q_string, er_q, $bits(er_q), q, $bits(q), `S_DEC);

///// TEST CASE 14 /////
    
    $display("\nTest Case %0d", tc++);
    #`CYCLE;    
    er_q = `WORD'dX;
    $display("Inputs: rst = %0d | d = %0d", rst, $signed(d)); 
    verify(ts, q_string, er_q, $bits(er_q), q, $bits(q), `S_DEC);
    
    // Add an extra cycle delay so that we can see the results on the simulation
    #`CYCLE;
    
    // call the final_result function to tally the results of the test
    // this function is part of the verification package
    final_result();
       
    $finish;
end
endmodule
