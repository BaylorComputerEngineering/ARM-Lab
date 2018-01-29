`include "definitions.vh"


module delay(
    input a,
    output reg a_delayed
    );
    always@(*) begin
       #1; 
       a_delayed <= a;
    end
    initial
        a_delayed<=a;
endmodule
