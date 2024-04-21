`include "verification_functions.sv"
module pipeline_fetch_decode;

import verification::*;

int tc = 1;
int ts = 1;

// Clock Signals
wire clk;
wire clk_plus_1;
wire clk_plus_2;
wire clk_plus_3;
oscillator  Crystal(
    .clk(clk)
    );
delay clk_delay_1(
    .a(clk),
    .a_delayed(clk_plus_1)
);     
delay clk_delay_2(
    .a(clk_plus_1),
    .a_delayed(clk_plus_2)
);  
delay clk_delay_3(
    .a(clk_plus_2),
    .a_delayed(clk_plus_3)
);

//Fetch
string pc_if_string = "|cur_pc_if|";
string instr_if_string = "|instruction_if|";
// Decode
string pc_id_string = "|cur_pc_id|";
string sign_extended_output_id_string = "|sign_extended_output_id|";
string reg2_loc_id_string = "|reg2_loc_id|";
string uncondbranch_id_string = "|uncondbranch_id|";
string branch_id_string = "|branch_id|";
string mem_read_id_string = "|mem_read_id|";
string mem_to_reg_id_string = "|mem_to_reg_id|";
string alu_op_id_string = "|alu_op_id|";
string mem_write_id_string = "|mem_write_id|";
string alu_src_id_string = "|alu_src_id|";
string reg_write_id_string = "|reg_write_id|";
string read_data1_id_string = "|read_data1_id|";
string read_data2_id_string = "|read_data2_id|";
string opcode_id_string = "|opcode_id|";


// Fetch signals
reg reset;
reg pc_src;
wire[`WORD-1:0] cur_pc_if;
wire[`INSTR_LEN-1:0] instruction_if;
// Fetch er values
reg[`WORD-1:0] er_cur_pc_if;
reg[`INSTR_LEN-1:0] er_instruction_if;

iFetch#(.SIZE(64))  iF(
        .clk(clk),
        .clk_delayed(clk_plus_1),
        .reset(reset),
        .pc_src(pc_src),
        .branch_target(branch_target_ie),
        .instruction(instruction_if),
        .cur_pc(cur_pc_if)
        );

//Decode signals
wire[`WORD-1:0] cur_pc_id;
wire[10:0] opcode_id;
wire[`WORD-1:0] read_data1_id, read_data2_id, sign_extended_output_id;
wire[1:0] alu_op_id;
wire reg2_loc_id, uncondbranch_id, branch_id, mem_read_id, mem_to_reg_id,  mem_write_id, alu_src_id, reg_write_id;
//Decode er values
reg[`WORD-1:0] er_cur_pc_id;
reg[10:0] er_opcode_id;
reg[`WORD-1:0] er_read_data1_id, er_read_data2_id, er_sign_extended_output_id;
reg[1:0] er_alu_op_id;
reg er_reg2_loc_id, er_uncondbranch_id, er_branch_id, er_mem_read_id, er_mem_to_reg_id,  er_mem_write_id, er_alu_src_id, er_reg_write_id;

                
iDecode iD(
        .clk(clk),    
        .read_clk(clk_plus_2),
        .write_clk(clk_plus_1),
        .cur_pc_in(cur_pc_if),
        .instruction_in(instruction_if),
        .cur_pc(cur_pc_id),
        .write_register(write_register_id),
        .sign_extended_output(sign_extended_output_id),
        .uncondbranch(uncondbranch_id),
        .branch(branch_id),
        .mem_read(mem_read_id),
        .mem_to_reg(mem_to_reg_id),
        .alu_op(alu_op_id),
        .mem_write(mem_write_id),
        .alu_src(alu_src_id),
        .reg_write(reg_write_id),
        .read_data1(read_data1_id),
        .read_data2(read_data2_id),
        .opcode(opcode_id)
        );
 
initial begin
    begin_test();
    pc_src=0;
    reset=1;
    #3;
    reset=0;
    #1;
    
    // LDUR X9, [X22, #64] in Fetch
    // nothing in Decode
    $display("*** Clock Cycle %0d ***", tc++);
    // verify Fetch signals
    er_cur_pc_if=`WORD'd0;
    er_instruction_if = `INSTR_LEN'hF84402C9;
    verify(ts, pc_if_string, er_cur_pc_if, $bits(er_cur_pc_if), cur_pc_if, $bits(cur_pc_if), `S_DEC);
    verify(ts, instr_if_string, er_instruction_if, $bits(er_instruction_if), instruction_if, $bits(instruction_if), `HEX);    

    #4;
    
    // ADD X10, X19, X9 in Fetch
    // LDUR X9, [X22, #64] in Decode
    $display("\n*** Clock Cycle %0d ***", tc++);
    // verify Fetch signals
    er_cur_pc_if=`WORD'd4;
    er_instruction_if = `INSTR_LEN'h8B09026A;
    verify(ts, pc_if_string, er_cur_pc_if, $bits(er_cur_pc_if), cur_pc_if, $bits(cur_pc_if), `S_DEC);
    verify(ts, instr_if_string, er_instruction_if, $bits(er_instruction_if), instruction_if, $bits(instruction_if), `HEX);    

    // verify Decode signals
    er_cur_pc_id = 0;
    er_opcode_id = `LDUR;    
    er_sign_extended_output_id = `WORD'd64;
    er_reg2_loc_id = 0;        
    er_uncondbranch_id = 0;
    er_branch_id = 0;
    er_mem_read_id = 1;
    er_mem_to_reg_id = 1;
    er_alu_op_id = `ALUOp_DTYPE;
    er_mem_write_id = 0;
    er_alu_src_id = 1;
    er_reg_write_id = 1;
    er_read_data1_id = `WORD'd16;    
    verify(ts, pc_id_string, er_cur_pc_id, $bits(er_cur_pc_id), cur_pc_id, $bits(cur_pc_id), `S_DEC);
    verify(ts, opcode_id_string, er_opcode_id, $bits(er_opcode_id), opcode_id, $bits(opcode_id), `BINARY);    
    verify(ts, sign_extended_output_id_string, er_sign_extended_output_id, $bits(er_sign_extended_output_id), sign_extended_output_id, $bits(sign_extended_output_id), `HEX);
    verify(ts, reg2_loc_id_string, er_reg2_loc_id, $bits(er_reg2_loc_id), reg2_loc_id, $bits(reg2_loc_id), `BINARY);
    verify(ts, uncondbranch_id_string, er_uncondbranch_id, $bits(er_uncondbranch_id), uncondbranch_id, $bits(uncondbranch_id), `BINARY);
    verify(ts, branch_id_string, er_branch_id, $bits(er_branch_id), branch_id, $bits(branch_id), `BINARY);
    verify(ts, mem_read_id_string, er_mem_read_id, $bits(er_mem_read_id), mem_read_id, $bits(mem_read_id), `BINARY);
    verify(ts, mem_to_reg_id_string, er_mem_to_reg_id, $bits(er_mem_to_reg_id), mem_to_reg_id, $bits(mem_to_reg_id), `BINARY);
    verify(ts, alu_op_id_string, er_alu_op_id, $bits(er_alu_op_id), alu_op_id, $bits(alu_op_id), `BINARY);
    verify(ts, mem_write_id_string, er_mem_write_id, $bits(er_mem_write_id), mem_write_id, $bits(mem_write_id), `BINARY);
    verify(ts, alu_src_id_string, er_alu_src_id, $bits(er_alu_src_id), alu_src_id, $bits(alu_src_id), `BINARY);   
    verify(ts, reg_write_id_string, er_reg_write_id, $bits(er_reg_write_id), reg_write_id, $bits(reg_write_id), `BINARY);     

    #1;
    verify(ts, read_data1_id_string, er_read_data1_id, $bits(er_read_data1_id), read_data1_id, $bits(read_data1_id), `S_DEC);

    #3;
    
    // SUB X11, X20, X10 in Fetch
    // ADD X10, X19, X9 in Decode
    // LDUR X9, [X22, #64] in Execute    
    $display("\n*** Clock Cycle %0d ***", tc++);
    er_cur_pc_if=`WORD'd8;
    er_instruction_if = `INSTR_LEN'hCB0A028B;

    verify(ts, pc_if_string, er_cur_pc_if, $bits(er_cur_pc_if), cur_pc_if, $bits(cur_pc_if), `S_DEC);
    verify(ts, instr_if_string, er_instruction_if, $bits(er_instruction_if), instruction_if, $bits(instruction_if), `HEX);    

    er_opcode_id = `ADD;    
    //er_sign_extended_output_id = `WORD'd64;
    er_reg2_loc_id = 0;        
    er_uncondbranch_id = 0;
    er_branch_id = 0;
    er_mem_read_id = 0;
    er_mem_to_reg_id = 0;
    er_alu_op_id = `ALUOp_RTYPE;
    er_mem_write_id = 0;
    er_alu_src_id = 0;
    er_reg_write_id = 1;
    er_read_data1_id = `WORD'd10;    
    er_read_data2_id = `WORD'd20;    
    verify(ts, opcode_id_string, er_opcode_id, $bits(er_opcode_id), opcode_id, $bits(opcode_id), `BINARY);    
    // verify control signals
    verify(ts, reg2_loc_id_string, er_reg2_loc_id, $bits(er_reg2_loc_id), reg2_loc_id, $bits(reg2_loc_id), `BINARY);
    verify(ts, uncondbranch_id_string, er_uncondbranch_id, $bits(er_uncondbranch_id), uncondbranch_id, $bits(uncondbranch_id), `BINARY);
    verify(ts, branch_id_string, er_branch_id, $bits(er_branch_id), branch_id, $bits(branch_id), `BINARY);
    verify(ts, mem_read_id_string, er_mem_read_id, $bits(er_mem_read_id), mem_read_id, $bits(mem_read_id), `BINARY);
    verify(ts, mem_to_reg_id_string, er_mem_to_reg_id, $bits(er_mem_to_reg_id), mem_to_reg_id, $bits(mem_to_reg_id), `BINARY);
    verify(ts, alu_op_id_string, er_alu_op_id, $bits(er_alu_op_id), alu_op_id, $bits(alu_op_id), `BINARY);
    verify(ts, mem_write_id_string, er_mem_write_id, $bits(er_mem_write_id), mem_write_id, $bits(mem_write_id), `BINARY);
    verify(ts, alu_src_id_string, er_alu_src_id, $bits(er_alu_src_id), alu_src_id, $bits(alu_src_id), `BINARY);   
    verify(ts, reg_write_id_string, er_reg_write_id, $bits(er_reg_write_id), reg_write_id, $bits(reg_write_id), `BINARY);     

    #1;
    verify(ts, read_data1_id_string, er_read_data1_id, $bits(er_read_data1_id), read_data1_id, $bits(read_data1_id), `S_DEC);
    verify(ts, read_data2_id_string, er_read_data2_id, $bits(er_read_data2_id), read_data2_id, $bits(read_data2_id), `S_DEC);
    
    #1;
    final_result();

$finish;
end
endmodule
