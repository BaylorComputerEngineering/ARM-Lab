`include "verification_functions.sv"

module fd_integration;

import verification::*;

int tc = 1;
int ts = 1;

string pc_string = "|cur_pc|";
string instr_string = "|instruction|";
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
	// we will keep pc_src set to 0 for the entire test...we are not ready to branch yet
	pc_src = 0;
	
	// set reset to 1 to make sure that the PC doesn't increment on the first positive clock edge, 
	// then set it back to 0 after that first positive clock edge
	reset = 1;
	#`CYCLE;
	reset = 0;
	
    // LDUR X9, [X22, #64]
    $display("Test Case %0d: | LDUR X9, [X22, #64]", tc++);
	ts = 1;
	
	// set er values for the fetch and decode stages 
    // verify that the signals match the er values   

    #2
 	// since we don't have an ALU or data memory yet, provide the write_data value (if applicable)

    #3;
    
    // ADD X10, X19, X9 
    $display("Test Case %0d: | ADD X10, X19, X9", tc++);    
	ts = 1;

	// set er values for the fetch and decode stages 
    #5;
    // verify that the signals match the er values 
    #2
 	// since we don't have an ALU or data memory yet, provide the write_data value (if applicable)
    #3;
    
    // SUB X11, X20, X10
    $display("Test Case %0d: | SUB X11, X20, X10", tc++);        
	ts = 1;

	// set er values for the fetch and decode stages 
    #5;
    // verify that the signals match the er values 
    #2
 	// since we don't have an ALU or data memory yet, provide the write_data value (if applicable)
    #3;
    
    // STUR X11, [X22, #96]
    $display("Test Case %0d: | STUR X11, [X22, #96]", tc++);        
	ts = 1;

	// set er values for the fetch and decode stages 
    #5;
    // verify that the signals match the er values 
    #2
 	// since we don't have an ALU or data memory yet, provide the write_data value (if applicable)
    #3;
    
    // CBZ X11, -5
    $display("Test Case %0d: | CBZ X11, -5", tc++);        
	ts = 1;

	// set er values for the fetch and decode stages 
    #5;
    // verify that the signals match the er values 
    #2
 	// since we don't have an ALU or data memory yet, provide the write_data value (if applicable)
    #3;
    
    // CBZ X9, 8
    $display("Test Case %0d: | CBZ X11, 8", tc++);        
	ts = 1;

	// set er values for the fetch and decode stages 
    #5;
    // verify that the signals match the er values 
    #2
 	// since we don't have an ALU or data memory yet, provide the write_data value (if applicable)
    #3;
    
    // B 64
    $display("Test Case %0d: | B 64", tc++);        
	ts = 1;

	// set er values for the fetch and decode stages 
    #5;
    // verify that the signals match the er values 
    #2
 	// since we don't have an ALU or data memory yet, provide the write_data value (if applicable)
    #3;
    
    // B -55
    $display("Test Case %0d: | B -55", tc++);        
	ts = 1;

	// set er values for the fetch and decode stages 
    #5;
    // verify that the signals match the er values 
    #2
 	// since we don't have an ALU or data memory yet, provide the write_data value (if applicable)
    #3;
	
    // ORR X9, X10, X21
    $display("Test Case %0d: | ORR X9, X10, X21", tc++);        
	ts = 1;

	// set er values for the fetch and decode stages 
    #5;
    // verify that the signals match the er values 
    #2
 	// since we don't have an ALU or data memory yet, provide the write_data value (if applicable)
    #3;
    
    // AND X9, X22, X10
    $display("Test Case %0d: | AND X9, X22, X10", tc++);        
	ts = 1;

	// set er values for the fetch and decode stages 
    #5;
    // verify that the signals match the er values 
    #2
 	// since we don't have an ALU or data memory yet, provide the write_data value (if applicable)
    #3;
    final_result();

$finish;

end
endmodule