`include "verification_functions.sv"

module datapath;

import verification::*;

int tc = 1;

wire clk;
reg reset;
// POTTER NOTE: use pc_src_tmp only with the execution of the 10 instructions from
// the Expected Results Table.  You will not use this with the division instructions
reg pc_src_tmp;
wire pc_src;
wire [`WORD-1:0] cur_pc;
wire [`INSTR_LEN-1:0] instruction;
wire read_clk;
wire write_clk;
//reg [`INSTR_LEN-1:0] instruction;
wire [`WORD-1:0] write_data;
wire [`WORD-1:0] sign_extended_output;
wire reg2_loc;
wire uncondbranch;
wire branch;
wire mem_read;
wire mem_to_reg;
wire [1:0] alu_op;
wire mem_write;
wire alu_src;
wire reg_write;
wire [`WORD-1:0]read_data1;
wire [`WORD-1:0]read_data2;
wire [10:0] opcode;
wire[`WORD-1:0] branch_target;
wire [`WORD-1:0] alu_result;
wire zero;
wire [`WORD-1:0]mem_read_data;


reg cr_uncondbranch;
reg cr_reg2_loc;
reg cr_branch;
reg cr_mem_read;
reg cr_mem_to_reg;
reg [1:0] cr_alu_op;
reg cr_mem_write;
reg cr_alu_src;
reg cr_reg_write;
reg [`WORD-1:0] cr_sign_extended_output;
reg [`WORD -1:0] cr_read_data1;
reg [`WORD -1:0] cr_read_data2;
reg [10:0] cr_opcode;
reg [`WORD-1:0] cr_branch_target;
reg [`WORD-1:0] cr_alu_result;
reg cr_zero;
reg[`WORD - 1:0] cr_mem_read_data;
reg cr_pc_src;
reg [`INSTR_LEN-1:0] cr_instruction;
reg [`WORD-1:0] cr_cur_pc;
reg [`WORD-1:0] cr_write_data;

string pc_string = "|cur_pc|";
string instr_string = "|instruction|";
string mem_read_data_string = "|mem_read_data|";
string pc_src_string = "|pc_src|";
string branch_target_string = "|branch_target|";
string alu_result_string = "|alu_result|";
string zero_string = "|zero|";
string write_data_string = "|write_data|";


string sign_extended_output_string = "|sign_extended_output|";
string reg2_loc_string = "|reg2_loc|";
string uncondbranch_string = "|uncondbranch|";
string branch_string = "|branch|";
string mem_read_string = "|mem_read|";
string mem_to_reg_string = "|mem_to_reg|";
string alu_op_string = "|alu_op|";
string mem_write_string = "|mem_write|";
string alu_src_string = "|alu_src|";
string reg_write_string = "|reg_write|";
string read_data1_string = "|read_data1|";
string read_data2_string = "|read_data2|";
string opcode_string = "|opcode|";


function verify_control_signals();
    verify(reg2_loc_string, cr_reg2_loc, $bits(cr_reg2_loc), reg2_loc, $bits(reg2_loc), `BINARY);
    verify(uncondbranch_string, cr_uncondbranch, $bits(cr_uncondbranch), uncondbranch, $bits(uncondbranch), `BINARY);
    verify(branch_string, cr_branch, $bits(cr_branch), branch, $bits(branch), `BINARY);
    verify(mem_read_string, cr_mem_read, $bits(cr_mem_read), mem_read, $bits(mem_read), `BINARY);
    verify(mem_to_reg_string, cr_mem_to_reg, $bits(cr_mem_to_reg), mem_to_reg, $bits(mem_to_reg), `BINARY);
    verify(alu_op_string, cr_alu_op, $bits(cr_alu_op), alu_op, $bits(alu_op), `BINARY);
    verify(mem_write_string, cr_mem_write, $bits(cr_mem_write), mem_write, $bits(mem_write), `BINARY);
    verify(alu_src_string, cr_alu_src, $bits(cr_alu_src), alu_src, $bits(alu_src), `BINARY);   
    verify(reg_write_string, cr_reg_write, $bits(cr_reg_write), reg_write, $bits(reg_write), `BINARY);     
endfunction    
    
iFetch#(.SIZE(16))  iF(
    .clk(clk),
    .clk_delayed(clk_plus_1),
    .reset(reset),
// POTTER NOTE: use pc_src_tmp only with the execution of the 10 instructions from
// the Expected Results Table.  You will use pc_src (produced by iMemory) with the 
// division instructions.  The 10 instructions are not meant to be run as a program
// and we do not want them to branch. We just want them to run from beginning to end    
    .pc_src(pc_src_tmp),
    .branch_target(branch_target),
    .instruction(instruction),
    .cur_pc(cur_pc)
    );    
    
// Add your other 4 stage modules here

oscillator myOsc(clk);

delay #(1) clk_delay_1(
    .a(clk),
    .a_delayed(clk_plus_1)
    );   

// create the rest of your clocks here

initial 
begin

begin_test();
pc_src_tmp = 0;
reset = 1;
#`CYCLE;
reset = 0;
    // LDUR X9, [X22, #64]
    $display("Test Case %0d: | LDUR X9, [X22, #64]", tc++);
    cr_cur_pc=`WORD'd0;
    cr_instruction = `INSTR_LEN'hF84402C9;
    cr_opcode = `LDUR;    
    cr_sign_extended_output = `WORD'd64;
    cr_reg2_loc = 0;        
    cr_uncondbranch = 0;
    cr_branch = 0;
    cr_mem_read = 1;
    cr_mem_to_reg = 1;
    cr_alu_op = `ALUOp_DTYPE;
    cr_mem_write = 0;
    cr_alu_src = 1;
    cr_reg_write = 1;
    cr_read_data1 = `WORD'd16;
    cr_branch_target = `WORD'd0;
    cr_alu_result = `WORD'd80;
    cr_zero = 0;
    cr_mem_read_data = `WORD'd20;
    cr_pc_src = 0;
    cr_write_data = `WORD'd20;
          
    #4;
    verify(pc_string, cr_cur_pc, $bits(cr_cur_pc), cur_pc, $bits(cur_pc), `S_DEC);
    verify(instr_string, cr_instruction, $bits(cr_instruction), instruction, $bits(instruction), `HEX);    
    verify(opcode_string, cr_opcode, $bits(cr_opcode), opcode, $bits(opcode), `BINARY);    
    verify(sign_extended_output_string, cr_sign_extended_output, $bits(cr_sign_extended_output), sign_extended_output, $bits(sign_extended_output), `HEX);
    verify_control_signals();
    verify(read_data1_string, cr_read_data1, $bits(cr_read_data1), read_data1, $bits(read_data1), `S_DEC);
    verify(alu_result_string, cr_alu_result, $bits(cr_alu_result), alu_result, $bits(alu_result), `S_DEC);    
    verify(zero_string, cr_zero, $bits(cr_zero), zero, $bits(zero), `BINARY);
    verify(mem_read_data_string, cr_mem_read_data, $bits(cr_mem_read_data), mem_read_data, $bits(mem_read_data), `S_DEC);        
    verify(pc_src_string, cr_pc_src, $bits(cr_pc_src), pc_src, $bits(pc_src), `BINARY);        
    verify(write_data_string, cr_write_data, $bits(cr_write_data), write_data, $bits(write_data), `S_DEC);        
    
    #1;
    
    // ADD X10, X19, X9 
    $display("Test Case %0d: | ADD X10, X19, X9", tc++);    
    cr_cur_pc=`WORD'd4;
    cr_instruction = `INSTR_LEN'h8B09026A;
    cr_opcode = `ADD;        
    cr_sign_extended_output = `WORD'd0;
    cr_reg2_loc = 0;        
    cr_uncondbranch = 0;
    cr_branch = 0;
    cr_mem_read = 0;
    cr_mem_to_reg = 0;
    cr_alu_op = `ALUOp_RTYPE;
    cr_mem_write = 0;
    cr_alu_src = 0;
    cr_reg_write = 1;
    cr_read_data1 = `WORD'd10;
    cr_read_data2 = `WORD'd20;  
    cr_branch_target = `WORD'd0;
    cr_alu_result = `WORD'd30;
    cr_zero = 0;
    cr_pc_src = 0;
    cr_write_data = `WORD'd30;
    
    #9;
    verify(pc_string, cr_cur_pc, $bits(cr_cur_pc), cur_pc, $bits(cur_pc), `S_DEC);
    verify(instr_string, cr_instruction, $bits(cr_instruction), instruction, $bits(instruction), `HEX);      
    verify(opcode_string, cr_opcode, $bits(cr_opcode), opcode, $bits(opcode), `BINARY);        
    verify_control_signals();
    verify(read_data1_string, cr_read_data1, $bits(cr_read_data1), read_data1, $bits(read_data1), `S_DEC);
    verify(read_data2_string, cr_read_data2, $bits(cr_read_data2), read_data2, $bits(read_data2), `S_DEC);
    verify(alu_result_string, cr_alu_result, $bits(cr_alu_result), alu_result, $bits(alu_result), `S_DEC);    
    verify(zero_string, cr_zero, $bits(cr_zero), zero, $bits(zero), `BINARY);             
    verify(pc_src_string, cr_pc_src, $bits(cr_pc_src), pc_src, $bits(pc_src), `BINARY);        
    verify(write_data_string, cr_write_data, $bits(cr_write_data), write_data, $bits(write_data), `S_DEC);        
     
    #1;
    
    // SUB X11, X20, X10
    $display("Test Case %0d: | SUB X11, X20, X10", tc++);        
    cr_cur_pc=`WORD'd8;
    cr_instruction = `INSTR_LEN'hCB0A028B;
    cr_opcode = `SUB;        
    cr_sign_extended_output = `WORD'd0;
    cr_reg2_loc = 0;        
    cr_uncondbranch = 0;
    cr_branch = 0;
    cr_mem_read = 0;
    cr_mem_to_reg = 0;
    cr_alu_op = `ALUOp_RTYPE;
    cr_mem_write = 0;
    cr_alu_src = 0;
    cr_reg_write = 1;
    cr_read_data1 = `WORD'd30;
    cr_read_data2 = `WORD'd30;  
    cr_branch_target = `WORD'd0;
    cr_alu_result = `WORD'd0;
    cr_zero = 1;
    cr_pc_src = 0;
    cr_write_data = `WORD'd0;   
       
    #9;
    verify(pc_string, cr_cur_pc, $bits(cr_cur_pc), cur_pc, $bits(cur_pc), `S_DEC);
    verify(instr_string, cr_instruction, $bits(cr_instruction), instruction, $bits(instruction), `HEX);      
    verify(opcode_string, cr_opcode, $bits(cr_opcode), opcode, $bits(opcode), `BINARY);        
    verify_control_signals();
    verify(read_data1_string, cr_read_data1, $bits(cr_read_data1), read_data1, $bits(read_data1), `S_DEC);
    verify(read_data2_string, cr_read_data2, $bits(cr_read_data2), read_data2, $bits(read_data2), `S_DEC);
    verify(alu_result_string, cr_alu_result, $bits(cr_alu_result), alu_result, $bits(alu_result), `S_DEC);    
    verify(zero_string, cr_zero, $bits(cr_zero), zero, $bits(zero), `BINARY);             
    verify(pc_src_string, cr_pc_src, $bits(cr_pc_src), pc_src, $bits(pc_src), `BINARY);        
    verify(write_data_string, cr_write_data, $bits(cr_write_data), write_data, $bits(write_data), `S_DEC);        
 
    #1;
    
    // STUR X11, [X22, #96]
    $display("Test Case %0d: | STUR X11, [X22, #96]", tc++);        
    cr_cur_pc=`WORD'd12;
    cr_instruction = `INSTR_LEN'hF80602CB;
    cr_opcode = `STUR;        
    cr_sign_extended_output = `WORD'd96;
    cr_reg2_loc = 1;        
    cr_uncondbranch = 0;
    cr_branch = 0;
    cr_mem_read = 0;
    cr_mem_to_reg = 0;
    cr_alu_op = `ALUOp_DTYPE;
    cr_mem_write = 1;
    cr_alu_src = 1;
    cr_reg_write = 0;
    cr_read_data1 = `WORD'd16;
    cr_read_data2 = `WORD'd0; 
    cr_branch_target = `WORD'd0;
    cr_alu_result = `WORD'd112;
    cr_zero = 0;    
    cr_pc_src = 0;
    #9;
    verify(pc_string, cr_cur_pc, $bits(cr_cur_pc), cur_pc, $bits(cur_pc), `S_DEC);
    verify(instr_string, cr_instruction, $bits(cr_instruction), instruction, $bits(instruction), `HEX);      
    verify(opcode_string, cr_opcode, $bits(cr_opcode), opcode, $bits(opcode), `BINARY);        
    verify(sign_extended_output_string, cr_sign_extended_output, $bits(cr_sign_extended_output), sign_extended_output, $bits(sign_extended_output), `HEX);
    verify_control_signals();
    verify(read_data1_string, cr_read_data1, $bits(cr_read_data1), read_data1, $bits(read_data1), `S_DEC);
    verify(read_data2_string, cr_read_data2, $bits(cr_read_data2), read_data2, $bits(read_data2), `S_DEC);
    verify(alu_result_string, cr_alu_result, $bits(cr_alu_result), alu_result, $bits(alu_result), `S_DEC);    
    verify(zero_string, cr_zero, $bits(cr_zero), zero, $bits(zero), `BINARY);             
    verify(pc_src_string, cr_pc_src, $bits(cr_pc_src), pc_src, $bits(pc_src), `BINARY);        
 
    #1;    
    
    // CBZ X11, -5
    $display("Test Case %0d: | CBZ X11, -5", tc++);        
    cr_cur_pc=`WORD'd16;
    cr_instruction = `INSTR_LEN'hB4FFFF6B;
    cr_opcode = 11'b10110100111;        
    cr_sign_extended_output = -`WORD'd5;
    cr_reg2_loc = 1;        
    cr_uncondbranch = 0;
    cr_branch = 1;
    cr_mem_read = 0;
    cr_mem_to_reg = 0;
    cr_alu_op = `ALUOp_CBZ;
    cr_mem_write = 0;
    cr_alu_src = 0;
    cr_reg_write = 0;
    cr_read_data2 = `WORD'd0;    
    cr_alu_result = `WORD'd00;
    cr_zero = 1;
    cr_branch_target = -`WORD'd4;
    cr_pc_src = 1;
    #9;
    verify(pc_string, cr_cur_pc, $bits(cr_cur_pc), cur_pc, $bits(cur_pc), `S_DEC);
    verify(instr_string, cr_instruction, $bits(cr_instruction), instruction, $bits(instruction), `HEX);      
    verify(opcode_string, cr_opcode, $bits(cr_opcode), opcode, $bits(opcode), `BINARY);        
    verify(sign_extended_output_string, cr_sign_extended_output, $bits(cr_sign_extended_output), sign_extended_output, $bits(sign_extended_output), `HEX);
    verify_control_signals();
    verify(read_data2_string, cr_read_data2, $bits(cr_read_data2), read_data2, $bits(read_data2), `S_DEC);
    verify(alu_result_string, cr_alu_result, $bits(cr_alu_result), alu_result, $bits(alu_result), `S_DEC);    
    verify(zero_string, cr_zero, $bits(cr_zero), zero, $bits(zero), `BINARY);             
    verify(branch_target_string, cr_branch_target, $bits(cr_branch_target), branch_target, $bits(branch_target), `S_DEC);    
    verify(pc_src_string, cr_pc_src, $bits(cr_pc_src), pc_src, $bits(pc_src), `BINARY);        
    
    #1;
    
    // CBZ X9, 8
    $display("Test Case %0d: | CBZ X11, 8", tc++);        
    cr_cur_pc=`WORD'd20;
    cr_instruction = `INSTR_LEN'hB4000109;    
    cr_opcode = 11'b10110100000;           
    cr_sign_extended_output = `WORD'd8;
    cr_reg2_loc = 1;        
    cr_uncondbranch = 0;
    cr_branch = 1;
    cr_mem_read = 0;
    cr_mem_to_reg = 0;
    cr_alu_op = `ALUOp_CBZ;
    cr_mem_write = 0;
    cr_alu_src = 0;
    cr_reg_write = 0;
    cr_read_data2 = `WORD'd20;  
    cr_alu_result = `WORD'd20;
    cr_zero = 0;
    cr_branch_target = `WORD'd52;
    cr_pc_src = 0;
    #9;
    verify(pc_string, cr_cur_pc, $bits(cr_cur_pc), cur_pc, $bits(cur_pc), `S_DEC);
    verify(instr_string, cr_instruction, $bits(cr_instruction), instruction, $bits(instruction), `HEX);      
    verify(opcode_string, cr_opcode, $bits(cr_opcode), opcode, $bits(opcode), `BINARY);        
    verify(sign_extended_output_string, cr_sign_extended_output, $bits(cr_sign_extended_output), sign_extended_output, $bits(sign_extended_output), `HEX);
    verify_control_signals();
    verify(read_data2_string, cr_read_data2, $bits(cr_read_data2), read_data2, $bits(read_data2), `S_DEC);
    verify(alu_result_string, cr_alu_result, $bits(cr_alu_result), alu_result, $bits(alu_result), `S_DEC);    
    verify(zero_string, cr_zero, $bits(cr_zero), zero, $bits(zero), `BINARY);             
    verify(branch_target_string, cr_branch_target, $bits(cr_branch_target), branch_target, $bits(branch_target), `S_DEC);
    verify(pc_src_string, cr_pc_src, $bits(cr_pc_src), pc_src, $bits(pc_src), `BINARY);        
         
    #1;    
    
    // B 64
    $display("Test Case %0d: | B 64", tc++);        
    cr_cur_pc=`WORD'd24;
    cr_instruction = `INSTR_LEN'h14000040;
    cr_opcode = 11'b00010100000;        
    cr_sign_extended_output = `WORD'd64;
    cr_reg2_loc = 0;        
    cr_uncondbranch = 1;
    cr_branch = 0;
    cr_mem_read = 0;
    cr_mem_to_reg = 0;
    cr_alu_op = `ALUOp_B;
    cr_mem_write = 0;
    cr_alu_src = 0;
    cr_reg_write = 0;
    cr_branch_target = `WORD'd280;
    cr_pc_src = 1;
    #9;
    verify(pc_string, cr_cur_pc, $bits(cr_cur_pc), cur_pc, $bits(cur_pc), `S_DEC);
    verify(instr_string, cr_instruction, $bits(cr_instruction), instruction, $bits(instruction), `HEX);      
    verify(opcode_string, cr_opcode, $bits(cr_opcode), opcode, $bits(opcode), `BINARY);        
    verify(sign_extended_output_string, cr_sign_extended_output, $bits(cr_sign_extended_output), sign_extended_output, $bits(sign_extended_output), `HEX);
    verify_control_signals();             
    verify(branch_target_string, cr_branch_target, $bits(cr_branch_target), branch_target, $bits(branch_target), `S_DEC);    
    verify(pc_src_string, cr_pc_src, $bits(cr_pc_src), pc_src, $bits(pc_src), `BINARY);        
     
    #1  
    
    // B -55
    $display("Test Case %0d: | B -55", tc++);        
    cr_cur_pc=`WORD'd28;
    cr_instruction = `INSTR_LEN'h17FFFFC9;
    cr_opcode = 11'b00010111111;        
    cr_sign_extended_output = -`WORD'd55;
    cr_reg2_loc = 0;        
    cr_uncondbranch = 1;
    cr_branch = 0;
    cr_mem_read = 0;
    cr_mem_to_reg = 0;
    cr_alu_op = `ALUOp_B;
    cr_mem_write = 0;
    cr_alu_src = 0;
    cr_reg_write = 0;   
    cr_branch_target = -`WORD'd192;
    cr_pc_src = 1;
    #9;
    verify(pc_string, cr_cur_pc, $bits(cr_cur_pc), cur_pc, $bits(cur_pc), `S_DEC);
    verify(instr_string, cr_instruction, $bits(cr_instruction), instruction, $bits(instruction), `HEX);      
    verify(opcode_string, cr_opcode, $bits(cr_opcode), opcode, $bits(opcode), `BINARY);        
    verify(sign_extended_output_string, cr_sign_extended_output, $bits(cr_sign_extended_output), sign_extended_output, $bits(sign_extended_output), `HEX);
    verify_control_signals();             
    verify(branch_target_string, cr_branch_target, $bits(cr_branch_target), branch_target, $bits(branch_target), `S_DEC);  
    verify(pc_src_string, cr_pc_src, $bits(cr_pc_src), pc_src, $bits(pc_src), `BINARY);        
       
    #1;         
       
    // ORR X9, X10, X21
    $display("Test Case %0d: | ORR X9, X10, X21", tc++);        
    cr_cur_pc=`WORD'd32;
    cr_instruction = `INSTR_LEN'hAA150149;
    cr_opcode = `ORR;        
    cr_sign_extended_output = `WORD'd0;
    cr_reg2_loc = 0;    
    cr_uncondbranch = 0;
    cr_branch = 0;
    cr_mem_read = 0;
    cr_mem_to_reg = 0;
    cr_alu_op = `ALUOp_RTYPE;
    cr_mem_write = 0;
    cr_alu_src = 0;
    cr_reg_write = 1;
    cr_read_data1 = `WORD'd30;
    cr_read_data2 = `WORD'd0;   
    cr_alu_result = `WORD'd30;
    cr_zero = 0;
    cr_pc_src = 0;
    cr_write_data = `WORD'd30;        
    #9;
    verify(pc_string, cr_cur_pc, $bits(cr_cur_pc), cur_pc, $bits(cur_pc), `S_DEC);
    verify(instr_string, cr_instruction, $bits(cr_instruction), instruction, $bits(instruction), `HEX);      
    verify(opcode_string, cr_opcode, $bits(cr_opcode), opcode, $bits(opcode), `BINARY);        
    verify_control_signals();
    verify(read_data1_string, cr_read_data1, $bits(cr_read_data1), read_data1, $bits(read_data1), `S_DEC);
    verify(read_data2_string, cr_read_data2, $bits(cr_read_data2), read_data2, $bits(read_data2), `S_DEC);
    verify(alu_result_string, cr_alu_result, $bits(cr_alu_result), alu_result, $bits(alu_result), `S_DEC);    
    verify(zero_string, cr_zero, $bits(cr_zero), zero, $bits(zero), `BINARY);                   
    verify(pc_src_string, cr_pc_src, $bits(cr_pc_src), pc_src, $bits(pc_src), `BINARY);        
    verify(write_data_string, cr_write_data, $bits(cr_write_data), write_data, $bits(write_data), `S_DEC);        
 
    #1
 
    // AND X9, X22, X10
    $display("Test Case %0d: | AND X9, X22, X10", tc++);        
    cr_cur_pc=`WORD'd36;
    cr_instruction = `INSTR_LEN'h8A0A02C9;
    cr_opcode = `AND;        
    cr_sign_extended_output = `WORD'd0;
    cr_reg2_loc = 0;        
    cr_uncondbranch = 0;
    cr_branch = 0;
    cr_mem_read = 0;
    cr_mem_to_reg = 0;
    cr_alu_op = `ALUOp_RTYPE;
    cr_mem_write = 0;
    cr_alu_src = 0;
    cr_reg_write = 1;
    cr_read_data1 = `WORD'd16;
    cr_read_data2 = `WORD'd30;   
    cr_alu_result = `WORD'd16;
    cr_zero = 0;
    cr_pc_src = 0;
    cr_write_data = `WORD'd16;        
    #9;
    verify(pc_string, cr_cur_pc, $bits(cr_cur_pc), cur_pc, $bits(cur_pc), `S_DEC);
    verify(instr_string, cr_instruction, $bits(cr_instruction), instruction, $bits(instruction), `HEX);      
    verify(opcode_string, cr_opcode, $bits(cr_opcode), opcode, $bits(opcode), `BINARY);        
    verify_control_signals();
    verify(read_data1_string, cr_read_data1, $bits(cr_read_data1), read_data1, $bits(read_data1), `S_DEC);
    verify(read_data2_string, cr_read_data2, $bits(cr_read_data2), read_data2, $bits(read_data2), `S_DEC);
    verify(alu_result_string, cr_alu_result, $bits(cr_alu_result), alu_result, $bits(alu_result), `S_DEC);    
    verify(zero_string, cr_zero, $bits(cr_zero), zero, $bits(zero), `BINARY);                 
    verify(pc_src_string, cr_pc_src, $bits(cr_pc_src), pc_src, $bits(pc_src), `BINARY);        
    verify(write_data_string, cr_write_data, $bits(cr_write_data), write_data, $bits(write_data), `S_DEC);        
       
    #1;
    final_result();

$finish;

end
endmodule