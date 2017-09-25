`include "definitions.vh"


module delay(
    input a,
    output reg a_delayed
    );
    always@(*)
       #(`CYCLE/10) a_delayed <= a;
    initial
        a_delayed<=a;
endmodule
