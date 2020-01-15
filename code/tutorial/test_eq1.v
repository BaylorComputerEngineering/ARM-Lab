`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/23/2017 11:44:19 AM
// Design Name: 
// Module Name: test_eq1
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

module test_eq1;
    // No port declaration indicates it is the top level module

    // signal declarations
    // use reg for test inputs so that you can assign values explicitly like a variable
    reg test_in0, test_in1;
    
    // use wire for test outputs because outputs are always wires
    wire test_out, test_out_always, test_out_non_blocking;
    
    // module declarations
    eq1 uut(.i0(test_in0), .i1(test_in1), .eq(test_out));
    eq1_always uut_always(.i0(test_in0), .i1(test_in1), .eq(test_out_always));
    eq1_non_blocking uut_non_blocking(.i0(test_in0), .i1(test_in1), .eq(test_out_non_blocking));
    
    initial
    begin
    // set inputs to each combination, then wait 200 ns
    test_in0 = 1'b0;
    test_in1 = 1'b0;
    #200
    test_in0 = 1'b0;
    test_in1 = 1'b1;    
    #200
    test_in0 = 1'b1;
    test_in1 = 1'b0;   
    #200
    test_in0 = 1'b1;
    test_in1 = 1'b1;   
    #200
    test_in0 = 1'b1;
    test_in1 = 1'b0;            
      
    end
endmodule
