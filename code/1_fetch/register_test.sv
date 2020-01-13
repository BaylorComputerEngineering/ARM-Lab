// include functions to verify functionality
`include "verification_functions.sv"

// create module register_test with no arguments
// no arguments implies that it is the top-level module
module register_test;

// import the verification package that was included above
import verification::*;

// create a 1-bit wire for use as a clock signal, oscillating between 0 and 1
wire clk;

// create a 1-bit reg to be used as the reset pin on the D Flip Flop
reg rst;

// create a 64 bit reg that will be used to set the D input of the Flip Flop
reg[`WORD - 1:0] d;

// create a 64 bit wire that will carry the Q output from the Flip Flop
wire[`WORD - 1:0] q;

// create a 64 bit reg that you will set to the correct result (cr) 
reg[`WORD - 1:0] cr;

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

// the initial section is executed one time when the system starts up
// the initial section is a procedural block, meaning that regs must 
// be used for signals that you will be manipulating in the initial section
initial
begin
    // call a verification function at the beginning to start the log
    begin_test();

    // set the reset pin to 0
    rst = 0;
    
    // set in to 0 (sets all 64 bits to a value of 0 in decimal)
    d=`WORD'd0; 
    // wait for one cycle (10ns)
    #`CYCLE;
    
    // set the correct result (cr) to the value that you believe should 
    // be produced on the Q output at this particular point in time
    cr=`WORD'd0; 
    
    // call the verify function from the verification package
    // this function can be viewed in verification_functions.sv
    // the verify function compares the value of cr to the value
    // of ar (actual result, see function definition).  It also 
    // compares the size of ar and cr 
    verify(cr, $bits(cr), q, $bits(q));
    
    // repeat the previous steps using different input values and 
    // different delays
    d=`WORD'd1; 
    #`CYCLE;
    cr=`WORD'd9; 
    verify(cr, $bits(cr), q, $bits(q));

    d=`WORD'd2; 
    #`CYCLE;
    cr=`WORD'd8; 
    verify(cr, $bits(cr), q, $bits(q));

    d=`WORD'd3; 
    #`CYCLE;
    cr=`WORD'd7; 
    verify(cr, $bits(cr), q, $bits(q));
   
    d=`WORD'd4; 
    #(`CYCLE/5);
    cr=`WORD'd3; 
    verify(cr, $bits(cr), q, $bits(q));
    
    d=`WORD'd5; 
    #(`CYCLE*4/5);
    cr=`WORD'd5; 
    verify(cr, $bits(cr), q, $bits(q));
    
    rst=1;
    #(`CYCLE/2);
    cr=`WORD'd6;
    verify(cr, $bits(cr), q, $bits(q));

    #`CYCLE;
    rst=0;
    #(`CYCLE/2);
    cr=`WORD'd5; 
    verify(cr, $bits(cr), q, $bits(q));    

    rst=1;
    #(`CYCLE/2);
    cr=`WORD'd4;
    verify(cr, $bits(cr), q, $bits(q));
        
    #2;
    d=`WORD'd345;
    cr=`WORD'd3;
    verify(cr, $bits(cr), q, $bits(q));

    #3;    
    rst=0;
    cr=`WORD'd2;
    verify(cr, $bits(cr), q, $bits(q));
    
    #`CYCLE;    
    cr=`WORD'd1;
    verify(cr, $bits(cr), q, $bits(q));
    
    // Add an extra cycle delay so that we can see the results on the simulation
    #`CYCLE;
    
    // call the final_result function to tally the results of the test
    // this function is part of the verification package
    final_result();
       
    $finish;
end
endmodule
