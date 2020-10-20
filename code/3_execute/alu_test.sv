`include "verification_functions.sv"

module alu_test;

import verification::*;

int tc = 1;
int ts = 1;

reg[`WORD-1:0] a;
reg[`WORD-1:0] b;
reg [3:0] alu_control;
wire [`WORD-1:0] alu_result;
wire zero;

reg [`WORD-1:0] er_alu_result;
reg er_zero;

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
    ts = 1;
    a = `WORD'd10;
    b = `WORD'd15;
    alu_control = `ALU_ADD;
    er_alu_result = `WORD'd25;
    er_zero = 1'b0;

    #5;
    verify(ts++, alu_result_string, er_alu_result, $bits(er_alu_result), alu_result, $bits(alu_result), `S_DEC);    
    verify(ts++, zero_string, er_zero, $bits(er_zero), zero, $bits(zero), `BINARY);
    
    #5;
    $display("\nTest Case %0d: | (10 - 15)", tc++);
    ts = 1;
    a = `WORD'd10;
    b = `WORD'd15;
    alu_control = `ALU_SUB;
    er_alu_result = -`WORD'd5;
    er_zero = 1'b0;    
 
    #5;
    verify(ts++, alu_result_string, er_alu_result, $bits(er_alu_result), alu_result, $bits(alu_result), `S_DEC);    
    verify(ts++, zero_string, er_zero, $bits(er_zero), zero, $bits(zero), `BINARY);
     
    
    $display("\nTest Case %0d: | (10 & 15)", tc++);
    ts = 1;
    a = `WORD'd10;
    b = `WORD'd15;
    alu_control = `ALU_AND;
    er_alu_result = `WORD'd10;
    er_zero = 1'b0;

    #5;
    verify(ts++, alu_result_string, er_alu_result, $bits(er_alu_result), alu_result, $bits(alu_result), `S_DEC);    
    verify(ts++, zero_string, er_zero, $bits(er_zero), zero, $bits(zero), `BINARY);    
        
    $display("\nTest Case %0d: | (10 | 15)", tc++);
    ts = 1;
    a = `WORD'd10;
    b = `WORD'd15;
    alu_control = `ALU_ORR;
    er_alu_result = `WORD'd15;
    er_zero = 1'b0;

    #5;
    verify(ts++, alu_result_string, er_alu_result, $bits(er_alu_result), alu_result, $bits(alu_result), `S_DEC);    
    verify(ts++, zero_string, er_zero, $bits(er_zero), zero, $bits(zero), `BINARY);
    
    $display("\nTest Case %0d: | PASS b=15", tc++);
    ts = 1;
    a = `WORD'd10;
    b = `WORD'd15;
    alu_control = `ALU_PASS;
    er_alu_result = `WORD'd15;
    er_zero = 1'b0;

    #5;
    verify(ts++, alu_result_string, er_alu_result, $bits(er_alu_result), alu_result, $bits(alu_result), `S_DEC);    
    verify(ts++, zero_string, er_zero, $bits(er_zero), zero, $bits(zero), `BINARY);    
            
    $display("\nTest Case %0d: | PASS b=0", tc++);
    ts = 1;
    a = `WORD'd256;
    b = `WORD'd0;
    alu_control = `ALU_PASS;
    er_alu_result = `WORD'd0;
    er_zero = 1'b1;

    #5;
    verify(ts++, alu_result_string, er_alu_result, $bits(er_alu_result), alu_result, $bits(alu_result), `S_DEC);    
    verify(ts++, zero_string, er_zero, $bits(er_zero), zero, $bits(zero), `BINARY);  
                
    $display("\nTest Case %0d: | (65536 + 65536)", tc++);
    ts = 1;
    a = `WORD'd65536;
    b = `WORD'd65536;
    alu_control = `ALU_ADD;
    er_alu_result = `WORD'd131072;
    er_zero = 1'b0;

    #5;
    verify(ts++, alu_result_string, er_alu_result, $bits(er_alu_result), alu_result, $bits(alu_result), `S_DEC);    
    verify(ts++, zero_string, er_zero, $bits(er_zero), zero, $bits(zero), `BINARY);
    
    #5;
    $display("\nTest Case %0d: | (65536 - 65536)", tc++);
    ts = 1;
    a = `WORD'd65536;
    b = `WORD'd65536;
    alu_control = `ALU_SUB;
    er_alu_result = `WORD'd0;
    er_zero = 1'b1;    
 
    #5;
    verify(ts++, alu_result_string, er_alu_result, $bits(er_alu_result), alu_result, $bits(alu_result), `S_DEC);    
    verify(ts++, zero_string, er_zero, $bits(er_zero), zero, $bits(zero), `BINARY);
                             
    final_result();    
end        

endmodule
