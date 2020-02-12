`include "verification_functions.sv"

module control_test;

import verification::*;
int tc = 1;

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

reg cr_reg2_loc;
reg cr_uncondbranch;
reg cr_branch;
reg cr_mem_read;
reg cr_mem_to_reg;
reg [1:0] cr_alu_op;
reg cr_mem_write;
reg cr_alu_src;
reg cr_reg_write;

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

initial
begin
    begin_test();
    
    // ADD instruction
    opcode = 11'h458;
    $display("Test Case %0d: | opcode = %0h", tc++, opcode);     
    #(`CYCLE);
    cr_reg2_loc = 0;
    cr_uncondbranch = 0;
    cr_branch = 0;
    cr_mem_read = 0;
    cr_mem_to_reg = 0;
    cr_alu_op = `ALUOp_RTYPE;
    cr_mem_write = 0;
    cr_alu_src = 0;
    cr_reg_write = 0;
    verify_control_signals();

    // SUB instruction
    opcode = 11'h658;
    $display("Test Case %0d: | opcode = %0h", tc++, opcode);     
    #(`CYCLE);
    cr_reg2_loc = 0;
    cr_uncondbranch = 0;
    cr_branch = 0;
    cr_mem_read = 0;
    cr_mem_to_reg = 0;
    cr_alu_op = `ALUOp_RTYPE;
    cr_mem_write = 0;
    cr_alu_src = 0;
    cr_reg_write = 0;
    verify_control_signals();

    // AND instruction
    opcode = 11'h450;
    $display("Test Case %0d: | opcode = %0h", tc++, opcode);     
    #(`CYCLE);
    cr_reg2_loc = 0;
    cr_uncondbranch = 0;
    cr_branch = 0;
    cr_mem_read = 0;
    cr_mem_to_reg = 0;
    cr_alu_op = `ALUOp_RTYPE;
    cr_mem_write = 0;
    cr_alu_src = 0;
    cr_reg_write = 0;
    verify_control_signals();

    // ORR instruction
    opcode = 11'h550;
    $display("Test Case %0d: | opcode = %0h", tc++, opcode);     
    #(`CYCLE);
    cr_reg2_loc = 0;
    cr_uncondbranch = 0;
    cr_branch = 0;
    cr_mem_read = 0;
    cr_mem_to_reg = 0;
    cr_alu_op = `ALUOp_RTYPE;
    cr_mem_write = 0;
    cr_alu_src = 0;
    cr_reg_write = 0;
    verify_control_signals();

    // LDUR instruction
    opcode = 11'h7C2;
    $display("Test Case %0d: | opcode = %0h", tc++, opcode);     
    cr_reg2_loc = 0;
    cr_uncondbranch = 0;
    cr_branch = 0;
    cr_mem_read = 0;
    cr_mem_to_reg = 0;
    cr_alu_op = `ALUOp_RTYPE;
    cr_mem_write = 0;
    cr_alu_src = 0;
    cr_reg_write = 0;
    #(`CYCLE);    
    verify_control_signals();

    // STUR instruction
    opcode = 11'h7C0;
    $display("Test Case %0d: | opcode = %0h", tc++, opcode);     
    #(`CYCLE);
    cr_reg2_loc = 0;
    cr_uncondbranch = 0;
    cr_branch = 0;
    cr_mem_read = 0;
    cr_mem_to_reg = 0;
    cr_alu_op = `ALUOp_RTYPE;
    cr_mem_write = 0;
    cr_alu_src = 0;
    cr_reg_write = 0;
    verify_control_signals();

    // CBZ instruction
    opcode = 11'h5A0;
    $display("Test Case %0d: | opcode = %0h", tc++, opcode);     
    #(`CYCLE);
    cr_reg2_loc = 0;
    cr_uncondbranch = 0;
    cr_branch = 0;
    cr_mem_read = 0;
    cr_mem_to_reg = 0;
    cr_alu_op = `ALUOp_RTYPE;
    cr_mem_write = 0;
    cr_alu_src = 0;
    cr_reg_write = 0;
    verify_control_signals();

    // CBZ instruction
    opcode = 11'h5A7;
    $display("Test Case %0d: | opcode = %0h", tc++, opcode);     
    #(`CYCLE);
    cr_reg2_loc = 0;
    cr_uncondbranch = 0;
    cr_branch = 0;
    cr_mem_read = 0;
    cr_mem_to_reg = 0;
    cr_alu_op = `ALUOp_RTYPE;
    cr_mem_write = 0;
    cr_alu_src = 0;
    cr_reg_write = 0;
    verify_control_signals();

    // B instruction
    opcode = 11'h0A0;
    $display("Test Case %0d: | opcode = %0h", tc++, opcode);     
    #(`CYCLE);
    cr_reg2_loc = 0;
    cr_uncondbranch = 0;
    cr_branch = 0;
    cr_mem_read = 0;
    cr_mem_to_reg = 0;
    cr_alu_op = `ALUOp_RTYPE;
    cr_mem_write = 0;
    cr_alu_src = 0;
    cr_reg_write = 0;
    verify_control_signals();

    // B instruction
    opcode = 11'h0AF;
    $display("Test Case %0d: | opcode = %0h", tc++, opcode);     
    #(`CYCLE);
    cr_reg2_loc = 0;
    cr_uncondbranch = 0;
    cr_branch = 0;
    cr_mem_read = 0;
    cr_mem_to_reg = 0;
    cr_alu_op = `ALUOp_RTYPE;
    cr_mem_write = 0;
    cr_alu_src = 0;
    cr_reg_write = 0;
    verify_control_signals();
    #(`CYCLE);
        
    // Invalid Opcode
    opcode = 11'h765;
    $display("Test Case %0d: | opcode = %0h", tc++, opcode);     
    #(`CYCLE);
    cr_reg2_loc = 0;
    cr_uncondbranch = 0;
    cr_branch = 0;
    cr_mem_read = 0;
    cr_mem_to_reg = 0;
    cr_alu_op = `ALUOp_RTYPE;
    cr_mem_write = 0;
    cr_alu_src = 0;
    cr_reg_write = 0;
    verify_control_signals();        
        
    final_result();
    $finish;
end

endmodule