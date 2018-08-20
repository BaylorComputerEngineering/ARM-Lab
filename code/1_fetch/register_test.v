`include "definitions.vh"


module register_test;

wire clk;
reg rst;
reg[`WORD - 1:0] d;
wire[`WORD - 1:0] q;

oscillator clk_gen(clk);

register UUT(
    .clk(clk),
    .reset(rst),
    .D(d),
    .Q(q)
    );

initial
begin
    rst = 0;
    d<=`WORD'd0; #`CYCLE;
    d<=`WORD'd1; #`CYCLE;
    d<=`WORD'd2; #`CYCLE;
    rst = 1;
    d<=`WORD'd3; #`CYCLE;
    d<=`WORD'd4; #(`CYCLE/5);
    rst = 0;
    d<=`WORD'd5; #(`CYCLE*4/5);
end

endmodule
