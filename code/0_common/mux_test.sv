`include "verification_functions.sv"

module mux_test;

import verification::*;

reg [`WORD-1:0] a_64;
reg [`WORD-1:0] b_64;
reg ctl;
wire [`WORD-1:0] out_64;

reg [4:0] a_5;
reg [4:0] b_5;
wire [4:0] out_5;

reg [`WORD-1:0] cr_64;
reg [4:0] cr_5;

mux #(`WORD) UUT_64(   
    .a_in(a_64),
    .b_in(b_64),
    .control(ctl),
    .mux_out(out_64)
    );

mux #(5) UUT_5(   
    .a_in(a_5),
    .b_in(b_5),
    .control(ctl),
    .mux_out(out_5)
    );

initial
begin
    begin_test();

    a_64=`WORD'd5;
    b_64=`WORD'd10;
    ctl=0;
    #1;
    cr_64=`WORD'd5;
    verify(cr_64, $bits(cr_64), out_64, $bits(out_64));
    
    #(`CYCLE-1);  
        
    ctl=1;
    #1;
    cr_64=`WORD'd10;
    verify(cr_64, $bits(cr_64), out_64, $bits(out_64));
        
    #(`CYCLE-1);
         
    b_64= -`WORD'd350;
    #1;    
    cr_64= -`WORD'd350;    
    verify(cr_64, $bits(cr_64), out_64, $bits(out_64));
    #(`CYCLE-1);    
 
    a_5=`WORD'd5;
    b_5=`WORD'd10;
    ctl=1;
    #1;
    cr_5=`WORD'd10;
    verify(cr_5, $bits(cr_5), out_5, $bits(out_5));
    
    #(`CYCLE-1);  
        
    ctl=0;
    #1;
    cr_5=5'd5;
    verify(cr_5, $bits(cr_5), out_5, $bits(out_5));

    #(`CYCLE-1);
    
    b_5=5'd11;
    #1;    
    cr_5= 5'd5;    
    verify(cr_5, $bits(cr_5), out_5, $bits(out_5));
    
    #(`CYCLE-1);    
          
    a_5=5'd22;
    #1;    
    cr_5= 5'd22;    
    verify(cr_5, $bits(cr_5), out_5, $bits(out_5));
    #(`CYCLE-1);    
    
    final_result();
    $finish;
end

endmodule
