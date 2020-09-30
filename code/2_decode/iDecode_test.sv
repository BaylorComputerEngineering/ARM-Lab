`include "verification_functions.sv"

module iDecode_test;

import verification::*;

int tc = 1;
int ts = 1;

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

reg er_uncondbranch;
reg er_reg2_loc;
reg er_branch;
reg er_mem_read;
reg er_mem_to_reg;
reg [1:0] er_alu_op;
reg er_mem_write;
reg er_alu_src;
reg er_reg_write;
reg [`WORD-1:0] er_sign_extended_output;
reg [`WORD -1:0] er_read_data1;
reg [`WORD -1:0] er_read_data2;
reg [10:0] er_opcode;



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
    verify(ts++, reg2_loc_string, er_reg2_loc, $bits(er_reg2_loc), reg2_loc, $bits(reg2_loc), `BINARY);
    verify(ts++, uncondbranch_string, er_uncondbranch, $bits(er_uncondbranch), uncondbranch, $bits(uncondbranch), `BINARY);
    verify(ts++, branch_string, er_branch, $bits(er_branch), branch, $bits(branch), `BINARY);
    verify(ts++, mem_read_string, er_mem_read, $bits(er_mem_read), mem_read, $bits(mem_read), `BINARY);
    verify(ts++, mem_to_reg_string, er_mem_to_reg, $bits(er_mem_to_reg), mem_to_reg, $bits(mem_to_reg), `BINARY);
    verify(ts++, alu_op_string, er_alu_op, $bits(er_alu_op), alu_op, $bits(alu_op), `BINARY);
    verify(ts++, mem_write_string, er_mem_write, $bits(er_mem_write), mem_write, $bits(mem_write), `BINARY);
    verify(ts++, alu_src_string, er_alu_src, $bits(er_alu_src), alu_src, $bits(alu_src), `BINARY);   
    verify(ts++, reg_write_string, er_reg_write, $bits(er_reg_write), reg_write, $bits(reg_write), `BINARY);     
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
	ts = 1;
    instruction = 0;
    er_opcode = 0;    
    er_sign_extended_output = 0;
    er_reg2_loc = 0;        
    er_uncondbranch = 0;
    er_branch = 0;
    er_mem_read = 0;
    er_mem_to_reg = 0;
    er_alu_op = 0;
    er_mem_write = 0;
    er_alu_src = 0;
    er_reg_write = 0;
    er_read_data1 = 0;
    er_read_data2 = 0;    
        
    #2;
    verify(ts++, opcode_string, er_opcode, $bits(er_opcode), opcode, $bits(opcode), `BINARY);    
    verify(ts++, sign_extended_output_string, er_sign_extended_output, $bits(er_sign_extended_output), sign_extended_output, $bits(sign_extended_output), `HEX);
    verify_control_signals();
    verify(ts++, read_data1_string, er_read_data1, $bits(er_read_data1), read_data1, $bits(read_data1), `S_DEC);
    verify(ts++, read_data2_string, er_read_data2, $bits(er_read_data2), read_data2, $bits(read_data2), `S_DEC);

    #4
    // Since we don't have data memory, provide the Write_data value
    write_data = 0;
    #4;
    
    // ADD X10, X19, X9 
    $display("Test Case %0d: | ADD X10, X19, X9", tc++);    
	ts = 1;
    instruction = 0;
    er_opcode = 0;    
//    er_sign_extended_output = 0;
    er_reg2_loc = 0;        
    er_uncondbranch = 0;
    er_branch = 0;
    er_mem_read = 0;
    er_mem_to_reg = 0;
    er_alu_op = 0;
    er_mem_write = 0;
    er_alu_src = 0;
    er_reg_write = 0;
    er_read_data1 = 0;
    er_read_data2 = 0;    
    #2;
    verify(ts++, opcode_string, er_opcode, $bits(er_opcode), opcode, $bits(opcode), `BINARY);        
//    verify(ts++, sign_extended_output_string, er_sign_extended_output, $bits(er_sign_extended_output), sign_extended_output, $bits(sign_extended_output), `HEX);
    verify_control_signals();
    verify(ts++, read_data1_string, er_read_data1, $bits(er_read_data1), read_data1, $bits(read_data1), `S_DEC);
    verify(ts++, read_data2_string, er_read_data2, $bits(er_read_data2), read_data2, $bits(read_data2), `S_DEC);
    #4
    write_data = 0;
    #4;
    
    // SUB X11, X20, X10
    $display("Test Case %0d: | SUB X11, X20, X10", tc++);        
	ts = 1;
    instruction = 0;
    er_opcode = 0;    
    er_sign_extended_output = 0;
    er_reg2_loc = 0;        
    er_uncondbranch = 0;
    er_branch = 0;
    er_mem_read = 0;
    er_mem_to_reg = 0;
    er_alu_op = 0;
    er_mem_write = 0;
    er_alu_src = 0;
    er_reg_write = 0;
    er_read_data1 = 0;
    er_read_data2 = 0;      
    #2;
    verify(ts++, opcode_string, er_opcode, $bits(er_opcode), opcode, $bits(opcode), `BINARY);        
    verify(ts++, sign_extended_output_string, er_sign_extended_output, $bits(er_sign_extended_output), sign_extended_output, $bits(sign_extended_output), `HEX);
    verify_control_signals();
    verify(ts++, read_data1_string, er_read_data1, $bits(er_read_data1), read_data1, $bits(read_data1), `S_DEC);
    verify(ts++, read_data2_string, er_read_data2, $bits(er_read_data2), read_data2, $bits(read_data2), `S_DEC);
    #4
    write_data = 0;
    #4;
    
    // STUR X11, [X22, #96]
    $display("Test Case %0d: | STUR X11, [X22, #96]", tc++);        
	ts = 1;
    instruction = 0;
    er_opcode = 0;    
    er_sign_extended_output = 0;
    er_reg2_loc = 0;        
    er_uncondbranch = 0;
    er_branch = 0;
    er_mem_read = 0;
    er_mem_to_reg = 0;
    er_alu_op = 0;
    er_mem_write = 0;
    er_alu_src = 0;
    er_reg_write = 0;
    er_read_data1 = 0;
    er_read_data2 = 0;    
    #2;
    verify(ts++, opcode_string, er_opcode, $bits(er_opcode), opcode, $bits(opcode), `BINARY);        
    verify(ts++, sign_extended_output_string, er_sign_extended_output, $bits(er_sign_extended_output), sign_extended_output, $bits(sign_extended_output), `HEX);
    verify_control_signals();
    verify(ts++, read_data1_string, er_read_data1, $bits(er_read_data1), read_data1, $bits(read_data1), `S_DEC);
    verify(ts++, read_data2_string, er_read_data2, $bits(er_read_data2), read_data2, $bits(read_data2), `S_DEC);
    #4
    write_data = 0;
    #4;    
    
    // CBZ X11, -5
    $display("Test Case %0d: | CBZ X11, -5", tc++);        
	ts = 1;
    instruction = 0;
    er_opcode = 0;    
    er_sign_extended_output = 0;
    er_reg2_loc = 0;        
    er_uncondbranch = 0;
    er_branch = 0;
    er_mem_read = 0;
    er_mem_to_reg = 0;
    er_alu_op = 0;
    er_mem_write = 0;
    er_alu_src = 0;
    er_reg_write = 0;
    er_read_data1 = 0;
    er_read_data2 = 0;    
    #2;
    verify(ts++, opcode_string, er_opcode, $bits(er_opcode), opcode, $bits(opcode), `BINARY);        
    verify(ts++, sign_extended_output_string, er_sign_extended_output, $bits(er_sign_extended_output), sign_extended_output, $bits(sign_extended_output), `HEX);
    verify_control_signals();
    verify(ts++, read_data1_string, er_read_data1, $bits(er_read_data1), read_data1, $bits(read_data1), `S_DEC);
    verify(ts++, read_data2_string, er_read_data2, $bits(er_read_data2), read_data2, $bits(read_data2), `S_DEC);
    #4
    write_data = 0;
    #4;    
    
    // CBZ X9, 8
    $display("Test Case %0d: | CBZ X9, 8", tc++);        
	ts = 1;
    instruction = 0;
    er_opcode = 0;    
    er_sign_extended_output = 0;
    er_reg2_loc = 0;        
    er_uncondbranch = 0;
    er_branch = 0;
    er_mem_read = 0;
    er_mem_to_reg = 0;
    er_alu_op = 0;
    er_mem_write = 0;
    er_alu_src = 0;
    er_reg_write = 0;
    er_read_data1 = 0;
    er_read_data2 = 0;    
    #2;
    verify(ts++, opcode_string, er_opcode, $bits(er_opcode), opcode, $bits(opcode), `BINARY);        
    verify(ts++, sign_extended_output_string, er_sign_extended_output, $bits(er_sign_extended_output), sign_extended_output, $bits(sign_extended_output), `HEX);
    verify_control_signals();
    verify(ts++, read_data1_string, er_read_data1, $bits(er_read_data1), read_data1, $bits(read_data1), `S_DEC);
    verify(ts++, read_data2_string, er_read_data2, $bits(er_read_data2), read_data2, $bits(read_data2), `S_DEC);
    #4
    write_data = 0;
    #4;    
    
    // B 64
    $display("Test Case %0d: | B 64", tc++);        
	ts = 1;
    instruction = 0;
    er_opcode = 0;    
    er_sign_extended_output = 0;
    er_reg2_loc = 0;        
    er_uncondbranch = 0;
    er_branch = 0;
    er_mem_read = 0;
    er_mem_to_reg = 0;
    er_alu_op = 0;
    er_mem_write = 0;
    er_alu_src = 0;
    er_reg_write = 0;
    er_read_data1 = 0;
    er_read_data2 = 0;    
    #2;
    verify(ts++, opcode_string, er_opcode, $bits(er_opcode), opcode, $bits(opcode), `BINARY);        
    verify(ts++, sign_extended_output_string, er_sign_extended_output, $bits(er_sign_extended_output), sign_extended_output, $bits(sign_extended_output), `HEX);
    verify_control_signals();
    verify(ts++, read_data1_string, er_read_data1, $bits(er_read_data1), read_data1, $bits(read_data1), `S_DEC);
    verify(ts++, read_data2_string, er_read_data2, $bits(er_read_data2), read_data2, $bits(read_data2), `S_DEC);
    #4
    write_data = 0;
    #4;        
    
    // B -55
    $display("Test Case %0d: | B -55", tc++);        
	ts = 1;
    instruction = 0;
    er_opcode = 0;    
    er_sign_extended_output = 0;
    er_reg2_loc = 0;        
    er_uncondbranch = 0;
    er_branch = 0;
    er_mem_read = 0;
    er_mem_to_reg = 0;
    er_alu_op = 0;
    er_mem_write = 0;
    er_alu_src = 0;
    er_reg_write = 0;
    er_read_data1 = 0;
    er_read_data2 = 0;    
    #2;
    verify(ts++, opcode_string, er_opcode, $bits(er_opcode), opcode, $bits(opcode), `BINARY);        
    verify(ts++, sign_extended_output_string, er_sign_extended_output, $bits(er_sign_extended_output), sign_extended_output, $bits(sign_extended_output), `HEX);
    verify_control_signals();
    verify(ts++, read_data1_string, er_read_data1, $bits(er_read_data1), read_data1, $bits(read_data1), `S_DEC);
    verify(ts++, read_data2_string, er_read_data2, $bits(er_read_data2), read_data2, $bits(read_data2), `S_DEC);
    #4
    write_data = 0;
    #4;         
       
    // ORR X9, X10, X21
    $display("Test Case %0d: | ORR X9, X10, X21", tc++);        
	ts = 1;
    instruction = 0;
    er_opcode = 0;    
    er_sign_extended_output = 0;
    er_reg2_loc = 0;        
    er_uncondbranch = 0;
    er_branch = 0;
    er_mem_read = 0;
    er_mem_to_reg = 0;
    er_alu_op = 0;
    er_mem_write = 0;
    er_alu_src = 0;
    er_reg_write = 0;
    er_read_data1 = 0;
    er_read_data2 = 0;    
    #2;
    verify(ts++, opcode_string, er_opcode, $bits(er_opcode), opcode, $bits(opcode), `BINARY);        
    verify(ts++, sign_extended_output_string, er_sign_extended_output, $bits(er_sign_extended_output), sign_extended_output, $bits(sign_extended_output), `HEX);
    verify_control_signals();
    verify(ts++, read_data1_string, er_read_data1, $bits(er_read_data1), read_data1, $bits(read_data1), `S_DEC);
    verify(ts++, read_data2_string, er_read_data2, $bits(er_read_data2), read_data2, $bits(read_data2), `S_DEC);
    #4
    write_data = 0;
    #4;
    
    // AND X9, X22, X10
    $display("Test Case %0d: | AND X9, X22, X10", tc++);        
	ts = 1;
    instruction = 0;
    er_opcode = 0;    
    er_sign_extended_output = 0;
    er_reg2_loc = 0;        
    er_uncondbranch = 0;
    er_branch = 0;
    er_mem_read = 0;
    er_mem_to_reg = 0;
    er_alu_op = 0;
    er_mem_write = 0;
    er_alu_src = 0;
    er_reg_write = 0;
    er_read_data1 = 0;
    er_read_data2 = 0;    
    #2;
    verify(ts++, opcode_string, er_opcode, $bits(er_opcode), opcode, $bits(opcode), `BINARY);        
    verify(ts++, sign_extended_output_string, er_sign_extended_output, $bits(er_sign_extended_output), sign_extended_output, $bits(sign_extended_output), `HEX);
    verify_control_signals();
    verify(ts++, read_data1_string, er_read_data1, $bits(er_read_data1), read_data1, $bits(read_data1), `S_DEC);
    verify(ts++, read_data2_string, er_read_data2, $bits(er_read_data2), read_data2, $bits(read_data2), `S_DEC);
    #4
    write_data = 0;
    #4;
    final_result();

$finish;

end
endmodule
