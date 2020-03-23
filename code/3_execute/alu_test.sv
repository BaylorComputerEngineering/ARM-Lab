`include "verification_functions.sv"

module alu_test;

import verification::*;

int tc = 1;

reg[`WORD-1:0] a;
reg[`WORD-1:0] b;
reg [3:0] alu_control;
wire [`WORD-1:0] alu_result;
wire zero;

reg [`WORD-1:0] cr_alu_result;
reg cr_zero;

string alu_result_string = "|alu_result|";
string zero_string = "|zero|";

alu myALU(
        .a_in(a),
        .b_in(b),
        .alu_control(alu_control),
        .alu_result(alu_result),
        .zero(zero)
        );
        
initial
begin
    begin_test();

    $display("\nTest Case %0d: | (10 + 15)", tc++);
    a = `WORD'd10;
    b = `WORD'd15;
    alu_control = `ALU_ADD;
    cr_alu_result = `WORD'd25;
    cr_zero = 1'b0;

    #5;
    verify(alu_result_string, cr_alu_result, $bits(cr_alu_result), alu_result, $bits(alu_result), `S_DEC);    
    verify(zero_string, cr_zero, $bits(cr_zero), zero, $bits(zero), `BINARY);
    
    #5;
    $display("\nTest Case %0d: | (10 - 15)", tc++);
    a = `WORD'd10;
    b = `WORD'd15;
    alu_control = `ALU_SUB;
    cr_alu_result = -`WORD'd5;
    cr_zero = 1'b0;    
 
    #5;
    verify(alu_result_string, cr_alu_result, $bits(cr_alu_result), alu_result, $bits(alu_result), `S_DEC);    
    verify(zero_string, cr_zero, $bits(cr_zero), zero, $bits(zero), `BINARY);
     
    
    $display("\nTest Case %0d: | (10 & 15)", tc++);
    a = `WORD'd10;
    b = `WORD'd15;
    alu_control = `ALU_AND;
    cr_alu_result = `WORD'd10;
    cr_zero = 1'b0;

    #5;
    verify(alu_result_string, cr_alu_result, $bits(cr_alu_result), alu_result, $bits(alu_result), `S_DEC);    
    verify(zero_string, cr_zero, $bits(cr_zero), zero, $bits(zero), `BINARY);    
        
    $display("\nTest Case %0d: | (10 | 15)", tc++);
    a = `WORD'd10;
    b = `WORD'd15;
    alu_control = `ALU_ORR;
    cr_alu_result = `WORD'd15;
    cr_zero = 1'b0;

    #5;
    verify(alu_result_string, cr_alu_result, $bits(cr_alu_result), alu_result, $bits(alu_result), `S_DEC);    
    verify(zero_string, cr_zero, $bits(cr_zero), zero, $bits(zero), `BINARY);
    
    $display("\nTest Case %0d: | PASS b=15", tc++);
    a = `WORD'd10;
    b = `WORD'd15;
    alu_control = `ALU_PASS;
    cr_alu_result = `WORD'd15;
    cr_zero = 1'b0;

    #5;
    verify(alu_result_string, cr_alu_result, $bits(cr_alu_result), alu_result, $bits(alu_result), `S_DEC);    
    verify(zero_string, cr_zero, $bits(cr_zero), zero, $bits(zero), `BINARY);    
            
    $display("\nTest Case %0d: | PASS b=0", tc++);
    a = `WORD'd256;
    b = `WORD'd0;
    alu_control = `ALU_PASS;
    cr_alu_result = `WORD'd0;
    cr_zero = 1'b1;

    #5;
    verify(alu_result_string, cr_alu_result, $bits(cr_alu_result), alu_result, $bits(alu_result), `S_DEC);    
    verify(zero_string, cr_zero, $bits(cr_zero), zero, $bits(zero), `BINARY);  
                
    $display("\nTest Case %0d: | (65536 + 65536)", tc++);
    a = `WORD'd65536;
    b = `WORD'd65536;
    alu_control = `ALU_ADD;
    cr_alu_result = `WORD'd131072;
    cr_zero = 1'b0;

    #5;
    verify(alu_result_string, cr_alu_result, $bits(cr_alu_result), alu_result, $bits(alu_result), `S_DEC);    
    verify(zero_string, cr_zero, $bits(cr_zero), zero, $bits(zero), `BINARY);
    
    #5;
    $display("\nTest Case %0d: | (65536 - 65536)", tc++);
    a = `WORD'd65536;
    b = `WORD'd65536;
    alu_control = `ALU_SUB;
    cr_alu_result = `WORD'd0;
    cr_zero = 1'b1;    
 
    #5;
    verify(alu_result_string, cr_alu_result, $bits(cr_alu_result), alu_result, $bits(alu_result), `S_DEC);    
    verify(zero_string, cr_zero, $bits(cr_zero), zero, $bits(zero), `BINARY);
                             
    final_result();    
end        

endmodule
