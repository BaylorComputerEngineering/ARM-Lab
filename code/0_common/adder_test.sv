`include "verification_functions.sv"

module adder_test;

import verification::*;

reg [`WORD-1:0] a;
reg [`WORD-1:0] b;
wire [`WORD-1:0] sum;

reg [`WORD-1:0] cr;

adder UUT(   
    .a_in(a),
    .b_in(b),
    .add_out(sum)
    );

initial
begin
    begin_test();

    a=`WORD'd5;
    b=`WORD'd10;
    #1;
    cr=`WORD'd15;
    verify(cr, $bits(cr), sum, $bits(sum));
    
    #(`CYCLE-1);
        
    a=`WORD'd280;
    b=`WORD'd1000;
    #1;    
    cr=`WORD'd1280;    
    verify(cr, $bits(cr), sum, $bits(sum));
    #(`CYCLE-1);
    
    a=`WORD'd280;
    b= -`WORD'd1000;
    #1;    
    cr= -`WORD'd720;    
    verify(cr, $bits(cr), sum, $bits(sum));
    #(`CYCLE-1);    
    
    a= -`WORD'd280;
    b= `WORD'd1000;
    #1;    
    cr= `WORD'd720;    
    verify(cr, $bits(cr), sum, $bits(sum));
    #(`CYCLE-1);        
    
    final_result();
    $finish;
end

endmodule
