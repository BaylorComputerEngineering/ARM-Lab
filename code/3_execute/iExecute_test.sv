`include "verification_functions.sv"

module iExecute_test;

import verification::*;

int tc = 1;
int ts = 1;

reg[`WORD-1:0] cur_pc;
reg[`WORD-1:0] read_data1;
reg[`WORD-1:0] read_data2;
reg[`WORD-1:0] sign_extended_output;
wire[`WORD-1:0] branch_target;
wire [`WORD-1:0] alu_result;
wire zero;
reg [1:0] alu_op;
reg [10:0] opcode;
reg alu_src;

reg [`WORD-1:0] er_branch_target;
reg [`WORD-1:0] er_alu_result;
reg er_zero;

string branch_target_string = "|branch_target|";
string alu_result_string = "|alu_result|";
string zero_string = "|zero|";


iExecute myExecute(
    .cur_pc(cur_pc),
    .sign_extended_output(sign_extended_output),
    .alu_op(alu_op),
    .alu_src(alu_src),
    .opcode(opcode), 
    .read_data1(read_data1), 
    .read_data2(read_data2),     
    .branch_target(branch_target),
    .alu_result(alu_result),
    .zero(zero)
    );

initial 
begin

    begin_test();

    // LDUR X9, [X22, #64]
    $display("Test Case %0d: | LDUR X9, [X22, #64]", tc++);    
	ts = 1;
    cur_pc<=`WORD'd0;
    alu_op<=`ALUOp_DTYPE;
    alu_src<=1'b1;
    sign_extended_output<=`WORD'd64;
    read_data1<=`WORD'd16;
    read_data2<=`WORD'd10;
    opcode<=`LDUR;

    er_branch_target = `WORD'dX;
    er_alu_result = `WORD'dX;
    er_zero = 1'bX;
    #5;
    verify(ts++, branch_target_string, er_branch_target, $bits(er_branch_target), branch_target, $bits(branch_target), `S_DEC);        
    verify(ts++, alu_result_string, er_alu_result, $bits(er_alu_result), alu_result, $bits(alu_result), `S_DEC);    
    verify(ts++, zero_string, er_zero, $bits(er_zero), zero, $bits(zero), `BINARY);    
    
    #5;
    
    // ADD X10, X19, X9
    $display("Test Case %0d: | ADD X10, X19, X9", tc++);    
	ts = 1;
    cur_pc<=cur_pc + 4;
    alu_op<=`ALUOp_RTYPE;
    alu_src<=1'b0;
    sign_extended_output<=`WORD'd88;
    read_data1<=`WORD'd10;
    read_data2<=`WORD'd20;
    opcode<=`ADD;
    
    er_branch_target = `WORD'dX;
    er_alu_result = `WORD'dX;
    er_zero = 1'bX;
    #5;
    verify(ts++, branch_target_string, er_branch_target, $bits(er_branch_target), branch_target, $bits(branch_target), `S_DEC);        
    verify(ts++, alu_result_string, er_alu_result, $bits(er_alu_result), alu_result, $bits(alu_result), `S_DEC);    
    verify(ts++, zero_string, er_zero, $bits(er_zero), zero, $bits(zero), `BINARY);    
    
    #5;
        
    // SUB X11, X20, X10
    $display("Test Case %0d: | SUB X11, X20, X10", tc++);        
	ts = 1;
    cur_pc<=cur_pc + 4;
    alu_op<=`ALUOp_RTYPE;
    alu_src<=1'b0;
    sign_extended_output<=`WORD'd88;
    read_data1<=`WORD'd30;
    read_data2<=`WORD'd30;
    opcode<=`SUB;
    
    er_branch_target = `WORD'dX;
    er_alu_result = `WORD'dX;
    er_zero = 1'bX;
    #5;
    verify(ts++, branch_target_string, er_branch_target, $bits(er_branch_target), branch_target, $bits(branch_target), `S_DEC);        
    verify(ts++, alu_result_string, er_alu_result, $bits(er_alu_result), alu_result, $bits(alu_result), `S_DEC);    
    verify(ts++, zero_string, er_zero, $bits(er_zero), zero, $bits(zero), `BINARY);    
    
    #5;
        
    // STUR X11, [X22, #96]
    $display("Test Case %0d: | STUR X11, [X22, #96]", tc++);        
	ts = 1;
    cur_pc<=cur_pc + 4;
    alu_op<=`ALUOp_DTYPE;
    alu_src<=1'b1;
    sign_extended_output<=`WORD'd96;
    read_data1<=`WORD'd16;
    read_data2<=`WORD'd0;
    opcode<=`STUR;
    
    er_branch_target = `WORD'dX;
    er_alu_result = `WORD'dX;
    er_zero = 1'bX;
    #5;
    verify(ts++, branch_target_string, er_branch_target, $bits(er_branch_target), branch_target, $bits(branch_target), `S_DEC);        
    verify(ts++, alu_result_string, er_alu_result, $bits(er_alu_result), alu_result, $bits(alu_result), `S_DEC);    
    verify(ts++, zero_string, er_zero, $bits(er_zero), zero, $bits(zero), `BINARY);    
    
    #5;
    
    // CBZ X11, -5
    $display("Test Case %0d: | CBZ X11, -5", tc++);        
	ts = 1;
    cur_pc<=cur_pc + 4;
    alu_op<=`ALUOp_CBZ;
    alu_src<=1'b0;
    sign_extended_output<=`WORD'hFFFFFFFFFFFFFFFB;
    read_data1<=`WORD'd88;
    read_data2<=`WORD'd0;
    opcode<=`CBZ;
    
    er_branch_target = -`WORD'dX;
    er_alu_result = `WORD'dX;
    er_zero = 1'bX;
    #5;
    verify(ts++, branch_target_string, er_branch_target, $bits(er_branch_target), branch_target, $bits(branch_target), `S_DEC);        
    verify(ts++, alu_result_string, er_alu_result, $bits(er_alu_result), alu_result, $bits(alu_result), `S_DEC);    
    verify(ts++, zero_string, er_zero, $bits(er_zero), zero, $bits(zero), `BINARY);    
    
    #5;
        
    // CBZ X9, 8
    $display("Test Case %0d: | CBZ X9, 8", tc++);        
	ts = 1;
    cur_pc<=cur_pc + 4;
    alu_op<=`ALUOp_CBZ;
    alu_src<=1'b0;
    sign_extended_output<=`WORD'd8;
    read_data1<=`WORD'd99;
    read_data2<=`WORD'd20;
    opcode<=`CBZ;
    
    er_branch_target = `WORD'dX;
    er_alu_result = `WORD'dX;
    er_zero = 1'bX;
    #5;
    verify(ts++, branch_target_string, er_branch_target, $bits(er_branch_target), branch_target, $bits(branch_target), `S_DEC);            
    verify(ts++, alu_result_string, er_alu_result, $bits(er_alu_result), alu_result, $bits(alu_result), `S_DEC);    
    verify(ts++, zero_string, er_zero, $bits(er_zero), zero, $bits(zero), `BINARY);    
    
    #5;
        
    // B 64
    $display("Test Case %0d: | B 64", tc++);        
	ts = 1;
    cur_pc<=cur_pc + 4;
    alu_op<=`ALUOp_B;
    alu_src<=1'b0;
    sign_extended_output<=`WORD'd64;
    read_data1<=`WORD'd88;
    read_data2<=`WORD'd99;
    opcode<=`B;    
    
    er_branch_target = `WORD'dX;
    er_alu_result = `WORD'dX;
    er_zero = 1'bX;
    #5;
    verify(ts++, branch_target_string, er_branch_target, $bits(er_branch_target), branch_target, $bits(branch_target), `S_DEC);            
    verify(ts++, alu_result_string, er_alu_result, $bits(er_alu_result), alu_result, $bits(alu_result), `S_DEC);    
    verify(ts++, zero_string, er_zero, $bits(er_zero), zero, $bits(zero), `BINARY);    
   
    #5;
        
    // B -55
    $display("Test Case %0d: | B -55", tc++);        
	ts = 1;
    cur_pc<=cur_pc + 4;
    alu_op<=`ALUOp_B;
    alu_src<=1'b0;
    sign_extended_output<=`WORD'hFFFFFFFFFFFFFFC9;
    read_data1<=`WORD'd88;
    read_data2<=`WORD'd99;
    opcode<=`B;    
    
    er_branch_target = -`WORD'dX;
    er_alu_result = `WORD'dX;
    er_zero = 1'bX;
    #5;
    verify(ts++, branch_target_string, er_branch_target, $bits(er_branch_target), branch_target, $bits(branch_target), `S_DEC);                
    verify(ts++, alu_result_string, er_alu_result, $bits(er_alu_result), alu_result, $bits(alu_result), `S_DEC);    
    verify(ts++, zero_string, er_zero, $bits(er_zero), zero, $bits(zero), `BINARY);    
    
    #5;
    
    // ORR X9, X10, X21
    $display("Test Case %0d: | ORR X9, X10, X21", tc++);        
	ts = 1;
    cur_pc<=cur_pc + 4;
    alu_op<=`ALUOp_RTYPE;
    alu_src<=1'b0;
    sign_extended_output<=`WORD'd88;
    read_data1<=`WORD'd30;
    read_data2<=`WORD'd0;
    opcode<=`ORR;
    
    er_branch_target = `WORD'dX;
    er_alu_result = `WORD'dX;
    er_zero = 1'bX;
    #5;
    verify(ts++, branch_target_string, er_branch_target, $bits(er_branch_target), branch_target, $bits(branch_target), `S_DEC);        
    verify(ts++, alu_result_string, er_alu_result, $bits(er_alu_result), alu_result, $bits(alu_result), `S_DEC);    
    verify(ts++, zero_string, er_zero, $bits(er_zero), zero, $bits(zero), `BINARY);    
    
    #5;
     
    // AND X9, X22, X10
    $display("Test Case %0d: | AND X9, X22, X10", tc++);        
	ts = 1;
    cur_pc<=cur_pc + 4;
    alu_op<=`ALUOp_RTYPE;
    alu_src<=1'b0;
    sign_extended_output<=`WORD'd88;
    read_data1<=`WORD'd16;
    read_data2<=`WORD'd30;
    opcode<=`AND;
       
    er_branch_target = `WORD'dX;
    er_alu_result = `WORD'dX;
    er_zero = 1'bX;
    #5;
    verify(ts++, branch_target_string, er_branch_target, $bits(er_branch_target), branch_target, $bits(branch_target), `S_DEC);        
    verify(ts++, alu_result_string, er_alu_result, $bits(er_alu_result), alu_result, $bits(alu_result), `S_DEC);    
    verify(ts++, zero_string, er_zero, $bits(er_zero), zero, $bits(zero), `BINARY);    
    
    #5;
    
    final_result();     
$finish;
    
end            
endmodule