`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/23/2017 11:42:15 AM
// Design Name: 
// Module Name: eq1
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module eq1_always
    (
    input wire i0, i1,
    output reg eq
    );
    
    reg p0, p1;
    
    // always block with sensitivity list of i0 and i1
    always @(i0, i1)
    begin
    // procedural statements with blocking assignments
    // blocking assignments wait for one to complete before 
    // executing the next assignment (used for combinational circuits)
    eq = p0 | p1;
    p0 = ~i0 & ~i1;
    p1 = i0 & i1;
//    eq = p0 | p1;
    end
endmodule
