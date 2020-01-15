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


module eq1
    // port declaration
    (
    input wire i0, i1,
    output wire eq
    );
    
    // signal declaration
    wire p0, p1;
    
    // continuous assignments for combinational logic
    
    // sum of product terms
    assign eq = p0 | p1;
    
    // product terms
    assign p0 = ~i0 & ~i1;
    assign p1 = i0 & i1;
endmodule
