`include "verification_functions.sv"

module control_test;

import verification::*;
int tc = 1;
int ts = 1;

reg [10:0] opcode;
wire reg2_loc;
wire uncondbranch;
wire branch;
wire mem_read;
wire mem_to_reg;
wire [1:0] alu_op;
wire mem_write;
wire alu_src;
wire reg_write;

reg er_reg2_loc;
reg er_uncondbranch;
reg er_branch;
reg er_mem_read;
reg er_mem_to_reg;
reg [1:0] er_alu_op;
reg er_mem_write;
reg er_alu_src;
reg er_reg_write;

string reg2_loc_string = "|reg2_loc|";
string uncondbranch_string = "|uncondbranch|";
string branch_string = "|branch|";
string mem_read_string = "|mem_read|";
string mem_to_reg_string = "|mem_to_reg|";
string alu_op_string = "|alu_op|";
string mem_write_string = "|mem_write|";
string alu_src_string = "|alu_src|";
string reg_write_string = "|reg_write|";

control  control_instance(
.opcode(opcode),
.reg2_loc(reg2_loc),
.uncondbranch(uncondbranch),
.branch(branch),
.mem_read(mem_read),
.mem_to_reg(mem_to_reg),
.alu_op(alu_op),
.mem_write(mem_write),
.alu_src(alu_src),
.reg_write(reg_write)
);

function void verify_control_signals();
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

initial
begin
    begin_test();
    
    // ADD instruction
    ts = 1;
    opcode = 11'h458;
    $display("Test Case %0d: | ADD | opcode = %0h", tc++, opcode);     
    #(`CYCLE);
    er_reg2_loc = 0;
    er_uncondbranch = 0;
    er_branch = 0;
    er_mem_read = 0;
    er_mem_to_reg = 0;
    er_alu_op = 0;
    er_mem_write = 0;
    er_alu_src = 0;
    er_reg_write = 0;
    verify_control_signals();

    // SUB instruction
    ts = 1;
    opcode = 11'h658;
    $display("Test Case %0d: | SUB | opcode = %0h", tc++, opcode);     
    #(`CYCLE);
    er_reg2_loc = 0;
    er_uncondbranch = 0;
    er_branch = 0;
    er_mem_read = 0;
    er_mem_to_reg = 0;
    er_alu_op = 0;
    er_mem_write = 0;
    er_alu_src = 0;
    er_reg_write = 0;
    verify_control_signals();

    // AND instruction
    ts = 1;
    opcode = 11'h450;
    $display("Test Case %0d: | AND | opcode = %0h", tc++, opcode);     
    #(`CYCLE);
    er_reg2_loc = 0;
    er_uncondbranch = 0;
    er_branch = 0;
    er_mem_read = 0;
    er_mem_to_reg = 0;
    er_alu_op = 0;
    er_mem_write = 0;
    er_alu_src = 0;
    er_reg_write = 0;
    verify_control_signals();

    // ORR instruction
    ts = 1;
    opcode = 11'h550;
    $display("Test Case %0d: | ORR | opcode = %0h", tc++, opcode);     
    #(`CYCLE);
    er_reg2_loc = 0;
    er_uncondbranch = 0;
    er_branch = 0;
    er_mem_read = 0;
    er_mem_to_reg = 0;
    er_alu_op = 0;
    er_mem_write = 0;
    er_alu_src = 0;
    er_reg_write = 0;
    verify_control_signals();

    // LDUR instruction
    ts = 1;
    opcode = 11'h7C2;
    $display("Test Case %0d: | LDUR | opcode = %0h", tc++, opcode);     
    er_reg2_loc = 0;
    er_uncondbranch = 0;
    er_branch = 0;
    er_mem_read = 0;
    er_mem_to_reg = 0;
    er_alu_op = 0;
    er_mem_write = 0;
    er_alu_src = 0;
    er_reg_write = 0;
    #(`CYCLE);    
    verify_control_signals();

    // STUR instruction
    ts = 1;
    opcode = 11'h7C0;
    $display("Test Case %0d: | STUR | opcode = %0h", tc++, opcode);     
    #(`CYCLE);
    er_reg2_loc = 0;
    er_uncondbranch = 0;
    er_branch = 0;
    er_mem_read = 0;
    er_mem_to_reg = 0;
    er_alu_op = 0;
    er_mem_write = 0;
    er_alu_src = 0;
    er_reg_write = 0;
    verify_control_signals();

    // CBZ instruction
    ts = 1;
    opcode = 11'h5A0;
    $display("Test Case %0d: | CBZ | opcode = %0h", tc++, opcode);     
    #(`CYCLE);
    er_reg2_loc = 0;
    er_uncondbranch = 0;
    er_branch = 0;
    er_mem_read = 0;
    er_mem_to_reg = 0;
    er_alu_op = 0;
    er_mem_write = 0;
    er_alu_src = 0;
    er_reg_write = 0;
    verify_control_signals();

    // CBZ instruction
    ts = 1;
    opcode = 11'h5A7;
    $display("Test Case %0d: | CBZ | opcode = %0h", tc++, opcode);     
    #(`CYCLE);
    er_reg2_loc = 0;
    er_uncondbranch = 0;
    er_branch = 0;
    er_mem_read = 0;
    er_mem_to_reg = 0;
    er_alu_op = 0;
    er_mem_write = 0;
    er_alu_src = 0;
    er_reg_write = 0;
    verify_control_signals();

    // B instruction
    ts = 1;
    opcode = 11'h0A0;
    $display("Test Case %0d: | B | opcode = %0h", tc++, opcode);     
    #(`CYCLE);
    er_reg2_loc = 0;
    er_uncondbranch = 0;
    er_branch = 0;
    er_mem_read = 0;
    er_mem_to_reg = 0;
    er_alu_op = 0;
    er_mem_write = 0;
    er_alu_src = 0;
    er_reg_write = 0;
    verify_control_signals();

    // B instruction
    ts = 1;
    opcode = 11'h0AF;
    $display("Test Case %0d: | B | opcode = %0h", tc++, opcode);     
    #(`CYCLE);
    er_reg2_loc = 0;
    er_uncondbranch = 0;
    er_branch = 0;
    er_mem_read = 0;
    er_mem_to_reg = 0;
    er_alu_op = 0;
    er_mem_write = 0;
    er_alu_src = 0;
    er_reg_write = 0;
    verify_control_signals();
    #(`CYCLE);
        
    // Invalid Opcode
    ts = 1;
    opcode = 11'h765;
    $display("Test Case %0d: | Invalid | opcode = %0h", tc++, opcode);     
    #(`CYCLE);
    er_reg2_loc = 0;
    er_uncondbranch = 0;
    er_branch = 0;
    er_mem_read = 0;
    er_mem_to_reg = 0;
    er_alu_op = 0;
    er_mem_write = 0;
    er_alu_src = 0;
    er_reg_write = 0;
    verify_control_signals();        
        
    final_result();
    $finish;
end

endmodule