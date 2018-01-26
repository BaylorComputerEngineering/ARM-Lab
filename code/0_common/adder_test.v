`include "definitions.vh"

module adder_test;

reg[`WORD - 1:0] a;
reg[`WORD - 1:0] b;
wire[`WORD - 1:0] add_out;

adder UUT(
    .a_in(a),
    .b_in(b),
    .add_out(add_out)
    );

initial
begin
    a<=`WORD'd0;
    b<=`WORD'd5; #`CYCLE;
    a<=`WORD'd55; #`CYCLE;   
    b<=`WORD'd59000; #`CYCLE;
    a<=`WORD'd1; #(`CYCLE/2);
    b<=`WORD'd24; #(2*`CYCLE);
    b<=`WORD'd8; #`CYCLE
    $finish;
end
endmodule