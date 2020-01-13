`include "definitions.vh"

module delay #(
    parameter DELAYAMT = 1)
    (
    input a,
    output reg a_delayed
    );
    
    initial
       a_delayed <= a;
           
    always@(*)
    begin
       a_delayed <= #DELAYAMT a;
    end
            
endmodule