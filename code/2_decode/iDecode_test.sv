`include "verification_functions.sv"

module iDecode_test;

import verification::*;

int tc = 1;

wire clk;
wire read_clk;
wire write_clk;
reg [`INSTR_LEN-1:0] instruction;
reg [`WORD-1:0] write_data;
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
    
iDecode iD(
        .clk(clk),
        .read_clk(read_clk),
        .write_clk(write_clk),
        .instruction(instruction),
        .write_data(write_data), 
        .opcode(opcode),
        .sign_extended_output(sign_extended_output),
        .reg2_loc(reg2_loc),        
        .uncondbranch(uncondbranch),
        .branch(branch),
        .mem_read(mem_read),
        .mem_to_reg(mem_to_reg),
        .alu_op(alu_op),
        .mem_write(mem_write),
        .alu_src(alu_src),
        .reg_write(reg_write),
        .read_data1(read_data1),
        .read_data2(read_data2)
        );    


oscillator myOsc(clk);

delay #(1) clk_delay_read(
    .a(clk),
    .a_delayed(read_clk)
    );   

delay #(7) clk_delay_write(
    .a(clk),
    .a_delayed(write_clk)
    );   


initial 
begin

begin_test();


#5;

    // LDUR X9, [X22, #64]
    $display("Test Case %0d: | LDUR X9, [X22, #64]", tc++);
    instruction = X;
    cr_opcode = X;    
    cr_sign_extended_output = X;
    cr_reg2_loc = X;        
    cr_uncondbranch = X;
    cr_branch = X;
    cr_mem_read = X;
    cr_mem_to_reg = X;
    cr_alu_op = X;
    cr_mem_write = X;
    cr_alu_src = X;
    cr_reg_write = X;
    cr_read_data1 = X;
    cr_read_data2 = X;    
        
    #2;
    verify(opcode_string, cr_opcode, $bits(cr_opcode), opcode, $bits(opcode), `BINARY);    
    verify(sign_extended_output_string, cr_sign_extended_output, $bits(cr_sign_extended_output), sign_extended_output, $bits(sign_extended_output), `HEX);
    verify_control_signals();
    verify(read_data1_string, cr_read_data1, $bits(cr_read_data1), read_data1, $bits(read_data1), `S_DEC);
    verify(read_data2_string, cr_read_data2, $bits(cr_read_data2), read_data2, $bits(read_data2), `S_DEC);

    #4
    // Since we don't have data memory, provide the Write_data value
    write_data = X;
    #4;
    
    // ADD X10, X19, X9 
    $display("Test Case %0d: | ADD X10, X19, X9", tc++);    
    instruction = X;
    cr_opcode = X;    
//    cr_sign_extended_output = X;
    cr_reg2_loc = X;        
    cr_uncondbranch = X;
    cr_branch = X;
    cr_mem_read = X;
    cr_mem_to_reg = X;
    cr_alu_op = X;
    cr_mem_write = X;
    cr_alu_src = X;
    cr_reg_write = X;
    cr_read_data1 = X;
    cr_read_data2 = X;    
    #2;
    verify(opcode_string, cr_opcode, $bits(cr_opcode), opcode, $bits(opcode), `BINARY);        
//    verify(sign_extended_output_string, cr_sign_extended_output, $bits(cr_sign_extended_output), sign_extended_output, $bits(sign_extended_output), `HEX);
    verify_control_signals();
    verify(read_data1_string, cr_read_data1, $bits(cr_read_data1), read_data1, $bits(read_data1), `S_DEC);
    verify(read_data2_string, cr_read_data2, $bits(cr_read_data2), read_data2, $bits(read_data2), `S_DEC);
    #4
    write_data = X;
    #4;
    
    // SUB X11, X20, X10
    $display("Test Case %0d: | SUB X11, X20, X10", tc++);        
    instruction = X;
    cr_opcode = X;    
    cr_sign_extended_output = X;
    cr_reg2_loc = X;        
    cr_uncondbranch = X;
    cr_branch = X;
    cr_mem_read = X;
    cr_mem_to_reg = X;
    cr_alu_op = X;
    cr_mem_write = X;
    cr_alu_src = X;
    cr_reg_write = X;
    cr_read_data1 = X;
    cr_read_data2 = X;      
    #2;
    verify(opcode_string, cr_opcode, $bits(cr_opcode), opcode, $bits(opcode), `BINARY);        
    verify(sign_extended_output_string, cr_sign_extended_output, $bits(cr_sign_extended_output), sign_extended_output, $bits(sign_extended_output), `HEX);
    verify_control_signals();
    verify(read_data1_string, cr_read_data1, $bits(cr_read_data1), read_data1, $bits(read_data1), `S_DEC);
    verify(read_data2_string, cr_read_data2, $bits(cr_read_data2), read_data2, $bits(read_data2), `S_DEC);
    #4
    write_data = X;
    #4;
    
    // STUR X11, [X22, #96]
    $display("Test Case %0d: | STUR X11, [X22, #96]", tc++);        
    instruction = X;
    cr_opcode = X;    
    cr_sign_extended_output = X;
    cr_reg2_loc = X;        
    cr_uncondbranch = X;
    cr_branch = X;
    cr_mem_read = X;
    cr_mem_to_reg = X;
    cr_alu_op = X;
    cr_mem_write = X;
    cr_alu_src = X;
    cr_reg_write = X;
    cr_read_data1 = X;
    cr_read_data2 = X;    
    #2;
    verify(opcode_string, cr_opcode, $bits(cr_opcode), opcode, $bits(opcode), `BINARY);        
    verify(sign_extended_output_string, cr_sign_extended_output, $bits(cr_sign_extended_output), sign_extended_output, $bits(sign_extended_output), `HEX);
    verify_control_signals();
    verify(read_data1_string, cr_read_data1, $bits(cr_read_data1), read_data1, $bits(read_data1), `S_DEC);
    verify(read_data2_string, cr_read_data2, $bits(cr_read_data2), read_data2, $bits(read_data2), `S_DEC);
    #4
    write_data = X;
    #4;    
    
    // CBZ X11, -5
    $display("Test Case %0d: | CBZ X11, -5", tc++);        
    instruction = X;
    cr_opcode = X;    
    cr_sign_extended_output = X;
    cr_reg2_loc = X;        
    cr_uncondbranch = X;
    cr_branch = X;
    cr_mem_read = X;
    cr_mem_to_reg = X;
    cr_alu_op = X;
    cr_mem_write = X;
    cr_alu_src = X;
    cr_reg_write = X;
    cr_read_data1 = X;
    cr_read_data2 = X;    
    #2;
    verify(opcode_string, cr_opcode, $bits(cr_opcode), opcode, $bits(opcode), `BINARY);        
    verify(sign_extended_output_string, cr_sign_extended_output, $bits(cr_sign_extended_output), sign_extended_output, $bits(sign_extended_output), `HEX);
    verify_control_signals();
    verify(read_data1_string, cr_read_data1, $bits(cr_read_data1), read_data1, $bits(read_data1), `S_DEC);
    verify(read_data2_string, cr_read_data2, $bits(cr_read_data2), read_data2, $bits(read_data2), `S_DEC);
    #4
    write_data = X;
    #4;    
    
    // CBZ X9, 8
    $display("Test Case %0d: | CBZ X9, 8", tc++);        
    instruction = X;
    cr_opcode = X;    
    cr_sign_extended_output = X;
    cr_reg2_loc = X;        
    cr_uncondbranch = X;
    cr_branch = X;
    cr_mem_read = X;
    cr_mem_to_reg = X;
    cr_alu_op = X;
    cr_mem_write = X;
    cr_alu_src = X;
    cr_reg_write = X;
    cr_read_data1 = X;
    cr_read_data2 = X;    
    #2;
    verify(opcode_string, cr_opcode, $bits(cr_opcode), opcode, $bits(opcode), `BINARY);        
    verify(sign_extended_output_string, cr_sign_extended_output, $bits(cr_sign_extended_output), sign_extended_output, $bits(sign_extended_output), `HEX);
    verify_control_signals();
    verify(read_data1_string, cr_read_data1, $bits(cr_read_data1), read_data1, $bits(read_data1), `S_DEC);
    verify(read_data2_string, cr_read_data2, $bits(cr_read_data2), read_data2, $bits(read_data2), `S_DEC);
    #4
    write_data = X;
    #4;    
    
    // B 64
    $display("Test Case %0d: | B 64", tc++);        
    instruction = X;
    cr_opcode = X;    
    cr_sign_extended_output = X;
    cr_reg2_loc = X;        
    cr_uncondbranch = X;
    cr_branch = X;
    cr_mem_read = X;
    cr_mem_to_reg = X;
    cr_alu_op = X;
    cr_mem_write = X;
    cr_alu_src = X;
    cr_reg_write = X;
    cr_read_data1 = X;
    cr_read_data2 = X;    
    #2;
    verify(opcode_string, cr_opcode, $bits(cr_opcode), opcode, $bits(opcode), `BINARY);        
    verify(sign_extended_output_string, cr_sign_extended_output, $bits(cr_sign_extended_output), sign_extended_output, $bits(sign_extended_output), `HEX);
    verify_control_signals();
    verify(read_data1_string, cr_read_data1, $bits(cr_read_data1), read_data1, $bits(read_data1), `S_DEC);
    verify(read_data2_string, cr_read_data2, $bits(cr_read_data2), read_data2, $bits(read_data2), `S_DEC);
    #4
    write_data = X;
    #4;        
    
    // B -55
    $display("Test Case %0d: | B -55", tc++);        
    instruction = X;
    cr_opcode = X;    
    cr_sign_extended_output = X;
    cr_reg2_loc = X;        
    cr_uncondbranch = X;
    cr_branch = X;
    cr_mem_read = X;
    cr_mem_to_reg = X;
    cr_alu_op = X;
    cr_mem_write = X;
    cr_alu_src = X;
    cr_reg_write = X;
    cr_read_data1 = X;
    cr_read_data2 = X;    
    #2;
    verify(opcode_string, cr_opcode, $bits(cr_opcode), opcode, $bits(opcode), `BINARY);        
    verify(sign_extended_output_string, cr_sign_extended_output, $bits(cr_sign_extended_output), sign_extended_output, $bits(sign_extended_output), `HEX);
    verify_control_signals();
    verify(read_data1_string, cr_read_data1, $bits(cr_read_data1), read_data1, $bits(read_data1), `S_DEC);
    verify(read_data2_string, cr_read_data2, $bits(cr_read_data2), read_data2, $bits(read_data2), `S_DEC);
    #4
    write_data = X;
    #4;         
       
    // ORR X9, X10, X21
    $display("Test Case %0d: | ORR X9, X10, X21", tc++);        
    instruction = X;
    cr_opcode = X;    
    cr_sign_extended_output = X;
    cr_reg2_loc = X;        
    cr_uncondbranch = X;
    cr_branch = X;
    cr_mem_read = X;
    cr_mem_to_reg = X;
    cr_alu_op = X;
    cr_mem_write = X;
    cr_alu_src = X;
    cr_reg_write = X;
    cr_read_data1 = X;
    cr_read_data2 = X;    
    #2;
    verify(opcode_string, cr_opcode, $bits(cr_opcode), opcode, $bits(opcode), `BINARY);        
    verify(sign_extended_output_string, cr_sign_extended_output, $bits(cr_sign_extended_output), sign_extended_output, $bits(sign_extended_output), `HEX);
    verify_control_signals();
    verify(read_data1_string, cr_read_data1, $bits(cr_read_data1), read_data1, $bits(read_data1), `S_DEC);
    verify(read_data2_string, cr_read_data2, $bits(cr_read_data2), read_data2, $bits(read_data2), `S_DEC);
    #4
    write_data = X;
    #4;
    
    // AND X9, X22, X10
    $display("Test Case %0d: | AND X9, X22, X10", tc++);        
    instruction = X;
    cr_opcode = X;    
    cr_sign_extended_output = X;
    cr_reg2_loc = X;        
    cr_uncondbranch = X;
    cr_branch = X;
    cr_mem_read = X;
    cr_mem_to_reg = X;
    cr_alu_op = X;
    cr_mem_write = X;
    cr_alu_src = X;
    cr_reg_write = X;
    cr_read_data1 = X;
    cr_read_data2 = X;    
    #2;
    verify(opcode_string, cr_opcode, $bits(cr_opcode), opcode, $bits(opcode), `BINARY);        
    verify(sign_extended_output_string, cr_sign_extended_output, $bits(cr_sign_extended_output), sign_extended_output, $bits(sign_extended_output), `HEX);
    verify_control_signals();
    verify(read_data1_string, cr_read_data1, $bits(cr_read_data1), read_data1, $bits(read_data1), `S_DEC);
    verify(read_data2_string, cr_read_data2, $bits(cr_read_data2), read_data2, $bits(read_data2), `S_DEC);
    #4
    write_data = X;
    #4;
    final_result();

$finish;

end
endmodule
