`include "verification_functions.sv"

module alu_control_test;

import verification::*;

int tc = 1;

reg[1:0] alu_op;
reg[10:0] opcode;
wire [3:0] alu_control;

reg [3:0] cr_alu_control;

string alu_control_string = "|alu_control|";

alu_control myALUControl(
        .alu_op(alu_op),
        .opcode(opcode),
        .alu_control(alu_control)
        );
        
initial
begin
    begin_test();

    $display("\nTest Case %0d: | LDUR", tc++);
    alu_op = 2'b00;
    opcode = `LDUR;
    cr_alu_control = `ALU_ADD;

    #5;
    verify(alu_control_string, cr_alu_control, $bits(cr_alu_control), alu_control, $bits(alu_control), `BINARY);    

    $display("\nTest Case %0d: | STUR", tc++);
    alu_op = 2'b00;
    opcode = `STUR;
    cr_alu_control = `ALU_ADD;

    #5;
    verify(alu_control_string, cr_alu_control, $bits(cr_alu_control), alu_control, $bits(alu_control), `BINARY);    

    $display("\nTest Case %0d: | ADD", tc++);
    alu_op = 2'b10;
    opcode = `ADD;
    cr_alu_control = `ALU_ADD;

    #5;
    verify(alu_control_string, cr_alu_control, $bits(cr_alu_control), alu_control, $bits(alu_control), `BINARY);    

    $display("\nTest Case %0d: | SUB", tc++);
    alu_op = 2'b10;
    opcode = `SUB;
    cr_alu_control = `ALU_SUB;

    #5;
    verify(alu_control_string, cr_alu_control, $bits(cr_alu_control), alu_control, $bits(alu_control), `BINARY);    

    $display("\nTest Case %0d: | AND", tc++);
    alu_op = 2'b10;
    opcode = `AND;
    cr_alu_control = `ALU_AND;

    #5;
    verify(alu_control_string, cr_alu_control, $bits(cr_alu_control), alu_control, $bits(alu_control), `BINARY);    

    $display("\nTest Case %0d: | ORR", tc++);
    alu_op = 2'b10;
    opcode = `ORR;
    cr_alu_control = `ALU_ORR;

    #5;
    verify(alu_control_string, cr_alu_control, $bits(cr_alu_control), alu_control, $bits(alu_control), `BINARY);    

    $display("\nTest Case %0d: | CBZ Positive", tc++);
    alu_op = 2'b01;
    opcode = 11'h5A7;
    cr_alu_control = `ALU_PASS;

    #5;
    verify(alu_control_string, cr_alu_control, $bits(cr_alu_control), alu_control, $bits(alu_control), `BINARY);    

    $display("\nTest Case %0d: | CBZ Negative", tc++);
    alu_op = 2'b01;
    opcode = 11'h5A0;
    cr_alu_control = `ALU_PASS;

    #5;
    verify(alu_control_string, cr_alu_control, $bits(cr_alu_control), alu_control, $bits(alu_control), `BINARY);    

    $display("\nTest Case %0d: | B Positive", tc++);
    alu_op = 2'b00;
    opcode = 11'h0A7;
    cr_alu_control = `ALU_ADD;

    #5;
    verify(alu_control_string, cr_alu_control, $bits(cr_alu_control), alu_control, $bits(alu_control), `BINARY);    

    $display("\nTest Case %0d: | B Negative", tc++);
    alu_op = 2'b00;
    opcode = 11'h0A0;
    cr_alu_control = `ALU_ADD;

    #5;
    verify(alu_control_string, cr_alu_control, $bits(cr_alu_control), alu_control, $bits(alu_control), `BINARY);   
    
    $display("\nTest Case %0d: | Default", tc++);
    alu_op = 2'b11;
    opcode = 11'b11111111111;
    cr_alu_control = `ALU_AND;

    #5;
    verify(alu_control_string, cr_alu_control, $bits(cr_alu_control), alu_control, $bits(alu_control), `BINARY);      
                             
    final_result();    
end        

endmodule
