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

reg [`WORD-1:0] er_out_64;
reg [4:0] er_out_5;

string out_64_string = "|out_64|";
string out_5_string = "|out_5|";

int tc = 1;
int ts = 1;

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

    $display("\nTest Case %0d", tc++);
    a_64=`WORD'd5;
    b_64=`WORD'd10;
    ctl=0;
    er_out_64=`WORD'd5;
    #1;
    $display("Inputs: a_64 = %0d | b_64 = %0d | ctl = %0d", $signed(a_64), $signed(b_64), ctl);     
    verify(ts, out_64_string, er_out_64, $bits(er_out_64), out_64, $bits(out_64), `S_DEC);
    
    #(`CYCLE-1);  
    
    $display("\nTest Case %0d", tc++);
    ctl=1;
    er_out_64=`WORD'd10;
    #1;
    $display("Inputs: a_64 = %0d | b_64 = %0d | ctl = %0d", $signed(a_64), $signed(b_64), ctl);     
    verify(ts, out_64_string, er_out_64, $bits(er_out_64), out_64, $bits(out_64), `S_DEC);
        
    #(`CYCLE-1);

    $display("\nTest Case %0d", tc++);
    b_64= -`WORD'd350;
    er_out_64= -`WORD'd350;    
    #1;    
    $display("Inputs: a_64 = %0d | b_64 = %0d | ctl = %0d", $signed(a_64), $signed(b_64), ctl);     
    verify(ts, out_64_string, er_out_64, $bits(er_out_64), out_64, $bits(out_64), `S_DEC);
    #(`CYCLE-1);    
 
    $display("\nTest Case %0d", tc++);
    a_5=`WORD'd5;
    b_5=`WORD'd10;
    ctl=1;
    er_out_5=`WORD'd10;
    #1;
    $display("Inputs: a_5 = %0d | b_5 = %0d | ctl = %0d", a_5, b_5, ctl);     
    verify(ts, out_5_string, er_out_5, $bits(er_out_5), out_5, $bits(out_5), `US_DEC);
    
    #(`CYCLE-1);  
        
    $display("\nTest Case %0d", tc++);
    ctl=0;
    er_out_5=5'd5;
    #1;
    $display("Inputs: a_5 = %0d | b_5 = %0d | ctl = %0d", a_5, b_5, ctl);     
    verify(ts, out_5_string, er_out_5, $bits(er_out_5), out_5, $bits(out_5), `US_DEC);

    #(`CYCLE-1);
    
    $display("\nTest Case %0d", tc++);
    b_5=5'd11;
    er_out_5= 5'd5;    
    #1;    
    $display("Inputs: a_5 = %0d | b_5 = %0d | ctl = %0d", a_5, b_5, ctl);     
    verify(ts, out_5_string, er_out_5, $bits(er_out_5), out_5, $bits(out_5), `US_DEC);
    
    #(`CYCLE-1);    
          
    $display("\nTest Case %0d", tc++);
    a_5=5'd22;
    er_out_5= 5'd22;    
    #1;    
    $display("Inputs: a_5 = %0d | b_5 = %0d | ctl = %0d", a_5, b_5, ctl);     
    verify(ts, out_5_string, er_out_5, $bits(er_out_5), out_5, $bits(out_5), `US_DEC);
    #(`CYCLE-1);    
    
    final_result();
    $finish;
end

endmodule
