`include "definitions.vh"


module oscillator(
    output reg clk
    );
    always
       #(`CYCLE/2) clk <= ~clk;
       
    initial
        clk<=0;
endmodule
