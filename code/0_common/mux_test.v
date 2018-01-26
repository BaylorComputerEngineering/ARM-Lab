`include "definitions.vh"

module mux_test;

reg[`WORD - 1:0] a;
reg[`WORD - 1:0] b;
reg control;
wire[`WORD - 1:0] mux_out;

mux#(64) UUT(
    .a_in(a),
    .b_in(b),
    .control(control),
    .mux_out(mux_out)
    );

initial
begin
    control<=1'b0;
    a<=`WORD'd0;
    b<=`WORD'd5; #`CYCLE;
    a<=`WORD'd55; #`CYCLE;  
    control<=1'b1; #(`CYCLE/2);    
    b<=`WORD'd59000; #`CYCLE;
    a<=`WORD'd1; #(`CYCLE/2);
    control<=1'b0;
    b<=`WORD'd24; #(2*`CYCLE);
    b<=`WORD'd8; #`CYCLE
    $finish;
end
endmodule
