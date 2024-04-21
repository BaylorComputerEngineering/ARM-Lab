`include "verification_functions.sv"
module pipeline;

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
string write_register_id_string = "|write_register_id|";
string opcode_id_string = "|opcode_id|";
// Execute
string pc_ie_string = "|cur_pc_ie|";
string uncondbranch_ie_string = "|uncondbranch_ie|";
string branch_ie_string = "|branch_ie|";
string mem_read_ie_string = "|mem_read_ie|";
string mem_to_reg_ie_string = "|mem_to_reg_ie|";
string mem_write_ie_string = "|mem_write_ie|";
string reg_write_ie_string = "|reg_write_ie|";
string read_data2_ie_string = "|read_data2_ie|";
string write_register_ie_string = "|write_register_ie|";
string branch_target_ie_string = "|branch_target_ie|";
string alu_result_ie_string = "|alu_result_ie|";
string zero_ie_string = "|zero_ie|";
// Memory
string pc_im_string = "|cur_pc_im|";
string mem_read_data_im_string = "|mem_read_data_im|";
string pc_src_im_string = "|pc_src_im|";
string mem_to_reg_im_string = "|mem_to_reg_im|";
string reg_write_im_string = "|reg_write_im|";
string alu_result_im_string = "|alu_result_im|";
string write_register_im_string = "|write_register_im|";
// Writeback
string pc_iw_string = "|cur_pc_iw|";
string reg_write_iw_string = "|reg_write_iw|";
string write_register_iw_string = "|write_register_iw|";
string write_data_iw_string = "|write_data_iw|";


// Fetch signals
reg reset;
reg pc_src;
wire[`WORD-1:0] cur_pc_if;
wire[`INSTR_LEN-1:0] instruction_if;
// Fetch er values
reg[`WORD-1:0] er_cur_pc_if;
reg[`INSTR_LEN-1:0] er_instruction_if;

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

// Execute
wire[`WORD-1:0] cur_pc_ie;
wire[10:0] opcode_ie;
wire[`WORD-1:0] branch_target_ie, alu_result_ie;
wire[4:0] write_register_id;
wire[`WORD-1:0]  read_data2_ie;
wire[4:0] write_register_ie;
wire zero_ie, reg_write_ie, uncondbranch_ie, branch_ie, mem_read_ie, mem_to_reg_ie, mem_write_ie;
reg[`WORD-1:0] er_cur_pc_ie;
reg[`WORD-1:0] er_branch_target_ie, er_alu_result_ie;
reg er_zero_ie;
reg[4:0] er_write_register_ie;
reg[`WORD-1:0]  er_read_data2_ie;
reg[4:0] er_write_register_ie;
reg er_reg_write_ie, er_uncondbranch_ie, er_branch_ie, er_mem_read_ie, er_mem_to_reg_ie, er_mem_write_ie;

// Memory
wire[`WORD-1:0] cur_pc_im;
wire[10:0] opcode_im;
wire[`WORD-1:0]  alu_result_im;
wire[`WORD-1:0]  mem_read_data_im;
wire[4:0] write_register_im;
wire reg_write_im, mem_to_reg_im, pc_src_im;
reg[`WORD-1:0] er_cur_pc_im;
reg[`WORD-1:0] er_mem_read_data_im;
reg[4:0] er_write_register_im;
reg er_pc_src_im, er_reg_write_im, er_mem_to_reg_im, er_mem_write_im;

// Writeback
wire[`WORD-1:0] cur_pc_iw;
wire[10:0] opcode_iw;
wire[4:0] write_register_iw;
wire[`WORD-1:0]  write_data_iw;
wire reg_write_iw;
reg[`WORD-1:0] er_cur_pc_iw;
reg[4:0] er_write_register_iw;
reg[`WORD-1:0]  er_write_data_iw;
reg er_reg_write_iw;
reg er_mem_to_reg_iw;

reg pc_src_tmp; 

// TODO: Add stage module instances here  
// You can start with your module instances from pipeline_fetch_decode.sv

initial begin
    begin_test();
    pc_src_tmp=0;
    reset=1;
    #3;
    reset=0;
    #2;
    
    // LDUR X9, [X22, #64] in Fetch
    // nothing in Decode
    $display("*** Clock Cycle %0d ***", tc++);
    
    // verify Fetch signals
    $display("\nFetch - LDUR X9, [X22, #64]");
    ts = 1;
    er_cur_pc_if=`WORD'd0;
    er_instruction_if = `INSTR_LEN'hF84402C9;
    verify(ts++, pc_if_string, er_cur_pc_if, $bits(er_cur_pc_if), cur_pc_if, $bits(cur_pc_if), `S_DEC);
    verify(ts++, instr_if_string, er_instruction_if, $bits(er_instruction_if), instruction_if, $bits(instruction_if), `HEX);    

    #4;
    
    // NOP in fetch
    // LDUR X9, [X22, #64] in Decode
    $display("\n*** Clock Cycle %0d ***", tc++);

    // verify Fetch signals
    $display("\nFetch - NOP");
    ts = 1;
    er_cur_pc_if=`WORD'd4;
    er_instruction_if = `INSTR_LEN'h00000000;
    verify(ts++, pc_if_string, er_cur_pc_if, $bits(er_cur_pc_if), cur_pc_if, $bits(cur_pc_if), `S_DEC);
    verify(ts++, instr_if_string, er_instruction_if, $bits(er_instruction_if), instruction_if, $bits(instruction_if), `HEX);    

    // verify Decode signals
    $display("\nDecode - LDUR X9, [X22, #64]");
    ts = 1;
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
    verify(ts++, pc_id_string, er_cur_pc_id, $bits(er_cur_pc_id), cur_pc_id, $bits(cur_pc_id), `S_DEC);
    verify(ts++, opcode_id_string, er_opcode_id, $bits(er_opcode_id), opcode_id, $bits(opcode_id), `BINARY);    
    verify(ts++, sign_extended_output_id_string, er_sign_extended_output_id, $bits(er_sign_extended_output_id), sign_extended_output_id, $bits(sign_extended_output_id), `HEX);
    verify(ts++, reg2_loc_id_string, er_reg2_loc_id, $bits(er_reg2_loc_id), reg2_loc_id, $bits(reg2_loc_id), `BINARY);
    verify(ts++, uncondbranch_id_string, er_uncondbranch_id, $bits(er_uncondbranch_id), uncondbranch_id, $bits(uncondbranch_id), `BINARY);
    verify(ts++, branch_id_string, er_branch_id, $bits(er_branch_id), branch_id, $bits(branch_id), `BINARY);
    verify(ts++, mem_read_id_string, er_mem_read_id, $bits(er_mem_read_id), mem_read_id, $bits(mem_read_id), `BINARY);
    verify(ts++, mem_to_reg_id_string, er_mem_to_reg_id, $bits(er_mem_to_reg_id), mem_to_reg_id, $bits(mem_to_reg_id), `BINARY);
    verify(ts++, alu_op_id_string, er_alu_op_id, $bits(er_alu_op_id), alu_op_id, $bits(alu_op_id), `BINARY);
    verify(ts++, mem_write_id_string, er_mem_write_id, $bits(er_mem_write_id), mem_write_id, $bits(mem_write_id), `BINARY);
    verify(ts++, alu_src_id_string, er_alu_src_id, $bits(er_alu_src_id), alu_src_id, $bits(alu_src_id), `BINARY);   
    verify(ts++, reg_write_id_string, er_reg_write_id, $bits(er_reg_write_id), reg_write_id, $bits(reg_write_id), `BINARY);     
    verify(ts++, read_data1_id_string, er_read_data1_id, $bits(er_read_data1_id), read_data1_id, $bits(read_data1_id), `S_DEC);

    #4;
        
    // NOP in Fetch
    // NOP in Decode
    // LDUR X9, [X22, #64] in Execute
    $display("\n*** Clock Cycle %0d ***", tc++);    

    // verify Fetch signals
    $display("\nFetch - NOP");
    ts = 1;
    er_cur_pc_if=`WORD'd8;
    er_instruction_if = `INSTR_LEN'h00000000;
    verify(ts++, pc_if_string, er_cur_pc_if, $bits(er_cur_pc_if), cur_pc_if, $bits(cur_pc_if), `S_DEC);
    verify(ts++, instr_if_string, er_instruction_if, $bits(er_instruction_if), instruction_if, $bits(instruction_if), `HEX);    

    // verify Decode signals
    $display("\nDecode - NOP");
    ts = 1;
    er_cur_pc_id = `WORD'd4;
    verify(ts++, pc_id_string, er_cur_pc_id, $bits(er_cur_pc_id), cur_pc_id, $bits(cur_pc_id), `S_DEC);

    // verify Execute signals
    $display("\nExecute - LDUR X9, [X22, #64]");
    ts = 1;
    er_cur_pc_ie = `WORD'd0;
    er_uncondbranch_ie =0;
    er_branch_ie = 0;
    er_mem_read_ie = 1;
    er_mem_to_reg_ie = 1;
    er_mem_write_ie = 0;    
    er_read_data2_ie = 0;
    er_reg_write_ie = 1;
    er_write_register_ie = 9;
           
    er_alu_result_ie = `WORD'd80;
    er_zero_ie = 0;
    verify(ts++, pc_ie_string, er_cur_pc_ie, $bits(er_cur_pc_ie), cur_pc_ie, $bits(cur_pc_ie), `S_DEC);    
    verify(ts++, alu_result_ie_string, er_alu_result_ie, $bits(er_alu_result_ie), alu_result_ie, $bits(alu_result_ie), `S_DEC);    
    verify(ts++, zero_ie_string, er_zero_ie, $bits(er_zero_ie), zero_ie, $bits(zero_ie), `BINARY);             
//    verify(ts++, branch_target_string, er_branch_target, $bits(er_branch_target), branch_target, $bits(branch_target), `S_DEC);    
    verify(ts++, uncondbranch_ie_string, er_uncondbranch_ie, $bits(er_uncondbranch_ie), uncondbranch_ie, $bits(uncondbranch_ie), `BINARY);
    verify(ts++, branch_ie_string, er_branch_ie, $bits(er_branch_ie), branch_ie, $bits(branch_ie), `BINARY);
    verify(ts++, mem_read_ie_string, er_mem_read_ie, $bits(er_mem_read_ie), mem_read_ie, $bits(mem_read_ie), `BINARY);
    verify(ts++, mem_to_reg_ie_string, er_mem_to_reg_ie, $bits(er_mem_to_reg_ie), mem_to_reg_ie, $bits(mem_to_reg_ie), `BINARY);
    verify(ts++, mem_write_ie_string, er_mem_write_ie, $bits(er_mem_write_ie), mem_write_ie, $bits(mem_write_ie), `BINARY);
    verify(ts++, reg_write_ie_string, er_reg_write_ie, $bits(er_reg_write_ie), reg_write_ie, $bits(reg_write_ie), `BINARY);     
    verify(ts++, write_register_ie_string, er_write_register_ie, $bits(er_write_register_ie), write_register_ie, $bits(write_register_ie), `BINARY);  
    #4;
    
    
    
    // ADD X10, X19, X9 in Fetch
    // NOP in Decode
    // NOP in Execute
    // LDUR X9, [X22, #64] in Memory
    $display("\n*** Clock Cycle %0d ***", tc++);    
    
    // verify Fetch signals
    $display("\nFetch - ADD X10, X19, X9");    
    ts = 1;
    er_cur_pc_if=`WORD'd12;
    er_instruction_if = `INSTR_LEN'h8B09026A;
    verify(ts++, pc_if_string, er_cur_pc_if, $bits(er_cur_pc_if), cur_pc_if, $bits(cur_pc_if), `S_DEC);
    verify(ts++, instr_if_string, er_instruction_if, $bits(er_instruction_if), instruction_if, $bits(instruction_if), `HEX);    

    // verify Decode signals
    $display("\nDecode - NOP");
    ts = 1;
    er_cur_pc_id = 8;
    verify(ts++, pc_id_string, er_cur_pc_id, $bits(er_cur_pc_id), cur_pc_id, $bits(cur_pc_id), `S_DEC);
 
    // verify Execute signals
    $display("\nExecute - NOP");
    ts = 1;
    er_cur_pc_ie = 4;
    verify(ts++, pc_ie_string, er_cur_pc_ie, $bits(er_cur_pc_ie), cur_pc_ie, $bits(cur_pc_ie), `S_DEC);    
   
    // verify Memory signals
    $display("\nMemory - LDUR X9, [X22, #64]");
    ts = 1;
    er_cur_pc_im = `WORD'd0;
    er_mem_to_reg_im = 1;
    er_reg_write_im = 1;
    er_write_register_im = 9;
           
    er_mem_read_data_im = `WORD'd20;
    er_pc_src_im = 0;
    verify(ts++, pc_im_string, er_cur_pc_im, $bits(er_cur_pc_im), cur_pc_im, $bits(cur_pc_im), `S_DEC);
    verify(ts++, mem_read_data_im_string, er_mem_read_data_im, $bits(er_mem_read_data_im), mem_read_data_im, $bits(mem_read_data_im), `S_DEC);    
    verify(ts++, pc_src_im_string, er_pc_src_im, $bits(er_pc_src_im), pc_src_im, $bits(pc_src_im), `BINARY);             
    verify(ts++, mem_to_reg_im_string, er_mem_to_reg_im, $bits(er_mem_to_reg_im), mem_to_reg_im, $bits(mem_to_reg_im), `BINARY);
    verify(ts++, reg_write_im_string, er_reg_write_im, $bits(er_reg_write_im), reg_write_im, $bits(reg_write_im), `BINARY);     
    verify(ts++, write_register_im_string, er_write_register_im, $bits(er_write_register_im), write_register_im, $bits(write_register_im), `BINARY);  

    #4;
 
    // NOP in Fetch
    // ADD X10, X19, X9 in Decode
    // NOP in Execute
    // NOP in Memory
    // LDUR X9, [X22, #64] in Writeback
    $display("\n*** Clock Cycle %0d ***", tc++);    
    
    // verify Fetch signals
    $display("\nFetch - NOP");    
    ts = 1;
    er_cur_pc_if=`WORD'd16;
    er_instruction_if = `INSTR_LEN'h00000000;
    verify(ts++, pc_if_string, er_cur_pc_if, $bits(er_cur_pc_if), cur_pc_if, $bits(cur_pc_if), `S_DEC);
    verify(ts++, instr_if_string, er_instruction_if, $bits(er_instruction_if), instruction_if, $bits(instruction_if), `HEX);    

    // verify Decode signals
    $display("\nDecode - ADD X10, X19, X9");
    ts = 1;
    er_cur_pc_id = 12;
    verify(ts++, pc_id_string, er_cur_pc_id, $bits(er_cur_pc_id), cur_pc_id, $bits(cur_pc_id), `S_DEC);
    
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
    verify(ts++, opcode_id_string, er_opcode_id, $bits(er_opcode_id), opcode_id, $bits(opcode_id), `BINARY);    
    // verify control signals
    verify(ts++, reg2_loc_id_string, er_reg2_loc_id, $bits(er_reg2_loc_id), reg2_loc_id, $bits(reg2_loc_id), `BINARY);
    verify(ts++, uncondbranch_id_string, er_uncondbranch_id, $bits(er_uncondbranch_id), uncondbranch_id, $bits(uncondbranch_id), `BINARY);
    verify(ts++, branch_id_string, er_branch_id, $bits(er_branch_id), branch_id, $bits(branch_id), `BINARY);
    verify(ts++, mem_read_id_string, er_mem_read_id, $bits(er_mem_read_id), mem_read_id, $bits(mem_read_id), `BINARY);
    verify(ts++, mem_to_reg_id_string, er_mem_to_reg_id, $bits(er_mem_to_reg_id), mem_to_reg_id, $bits(mem_to_reg_id), `BINARY);
    verify(ts++, alu_op_id_string, er_alu_op_id, $bits(er_alu_op_id), alu_op_id, $bits(alu_op_id), `BINARY);
    verify(ts++, mem_write_id_string, er_mem_write_id, $bits(er_mem_write_id), mem_write_id, $bits(mem_write_id), `BINARY);
    verify(ts++, alu_src_id_string, er_alu_src_id, $bits(er_alu_src_id), alu_src_id, $bits(alu_src_id), `BINARY);   
    verify(ts++, reg_write_id_string, er_reg_write_id, $bits(er_reg_write_id), reg_write_id, $bits(reg_write_id), `BINARY);     
    verify(ts++, read_data1_id_string, er_read_data1_id, $bits(er_read_data1_id), read_data1_id, $bits(read_data1_id), `S_DEC);
    verify(ts++, read_data2_id_string, er_read_data2_id, $bits(er_read_data2_id), read_data2_id, $bits(read_data2_id), `S_DEC);

    // verify Execute signals
    $display("\nExecute - NOP");
    ts = 1;
    er_cur_pc_ie = 8;
    verify(ts++, pc_ie_string, er_cur_pc_ie, $bits(er_cur_pc_ie), cur_pc_ie, $bits(cur_pc_ie), `S_DEC); 

    // verify Memory signals
    $display("\nMemory - NOP");
    ts = 1;
    er_cur_pc_im = 4;
    verify(ts++, pc_im_string, er_cur_pc_im, $bits(er_cur_pc_im), cur_pc_im, $bits(cur_pc_im), `S_DEC);

    // verify WriteBack signals
    $display("\nWriteback - LDUR X9, [X22, #64]");    
    ts = 1;
    er_cur_pc_iw = `WORD'd0;
    er_mem_to_reg_iw = 1;
    er_reg_write_iw = 1;
    er_write_register_iw = 9;
    er_write_data_iw = `WORD'd20;
    verify(ts++, pc_iw_string, er_cur_pc_iw, $bits(er_cur_pc_iw), cur_pc_iw, $bits(cur_pc_iw), `S_DEC);
    verify(ts++, write_data_iw_string, er_write_data_iw, $bits(er_write_data_iw), write_data_iw, $bits(write_data_iw), `S_DEC);    
    verify(ts++, reg_write_iw_string, er_reg_write_iw, $bits(er_reg_write_iw), reg_write_iw, $bits(reg_write_iw), `BINARY);     
    verify(ts++, write_register_iw_string, er_write_register_iw, $bits(er_write_register_iw), write_register_iw, $bits(write_register_iw), `BINARY);  

	// TODO: Add the rest of the testbench so that that the first 4 instructions can execute to completion
	// Please use the provided testbench above as a guide
    
    #100;
    final_result();

$finish;
end
endmodule

	