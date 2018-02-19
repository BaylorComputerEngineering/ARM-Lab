`include "definitions.vh"

module iDecode_test;
    
    wire clk, read_clk, write_clk;
    
    reg [`INSTR_LEN-1:0] instruction;
    reg [`WORD-1:0] write_data;
    
    wire reg2_loc, branch, mem_read, mem_to_reg, mem_write, alu_src, reg_write, uncondbranch;
    wire [1:0] alu_op; 
    wire [4:0] read_register1, read_register2, write_register;
    wire [`WORD-1:0] read_data1, read_data2, sign_extended_output;
    
    oscillator clk_gen(clk);

    iDecode uut( 
        .clk(clk_plus_2),        // this clk will be used in instr_parse
        .read_clk(clk_plus_3),   // read_clk will be used in the read portion of regfile
        .write_clk(clk_plus_7),  // write_clk will be used in the write portion of regfile
        .instruction_in(instruction),
        .write_data(write_data),
        .sign_extended_output(sign_extended_output),
        .reg2_loc(reg2_loc),
        .branch(branch),
        .mem_read(mem_read),
        .mem_to_reg(mem_to_reg),
        .mem_write(mem_write),
        .alu_src(alu_src),
        .reg_write(reg_write),
        .uncondbranch(uncondbranch),
        .alu_op(alu_op),
        .read_register1(read_register1),
        .read_register2(read_register2),
        .write_register(write_register),        
        .read_data1(read_data1),
        .read_data2(read_data2)
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
    
        delay clk_delay_4(
        .a(clk_plus_3),
        .a_delayed(clk_plus_4)
    );   
    
    delay clk_delay_5(
        .a(clk_plus_4),
        .a_delayed(clk_plus_5)
    );
    
    delay clk_delay_6(
        .a(clk_plus_5),
        .a_delayed(clk_plus_6)
    );
    
        delay clk_delay_7(
        .a(clk_plus_6),
        .a_delayed(clk_plus_7)
    );   
    
    delay clk_delay_8(
        .a(clk_plus_7),
        .a_delayed(clk_plus_8)
    );
    
    delay clk_delay_9(
        .a(clk_plus_8),
        .a_delayed(clk_plus_9)
    );
    
    delay clk_delay_10(
        .a(clk_plus_9),
        .a_delayed(clk_plus_10)
    );

           
initial

    begin
        // wait for the rising clock edge
        #(`CYCLE/2);    
        // LDUR X9, [X22, #64]
        instruction <= `INSTR_LEN'hF84402C9;
        // wait until half way through the cycle to set write_data
        // write_data is provided by the ALU or Data Memory, which 
        // populate write_data in the second half of the cycle
        #(`CYCLE/2);    
        write_data <= `WORD'd20; 
        #(`CYCLE/2);
        // ADD X10, X19, X9
        instruction <= `INSTR_LEN'h8B09026A;
        #(`CYCLE/2);
        write_data <= `WORD'd30; // Addition result 
        #(`CYCLE/2);
        // SUB X11, X20, X10 
        instruction <= `INSTR_LEN'hCB0A028B;
        #(`CYCLE/2);
        write_data <= `WORD'd0; // Subtraction Result 
        #(`CYCLE/2);
        //STUR X11, [X22, #96]
        instruction <= `INSTR_LEN'hF80602CB;
        #(`CYCLE/2);
        write_data <= `WORD'd0; // N/A 
        #(`CYCLE/2);
        //CBZ X11, -5
        instruction <= `INSTR_LEN'hB4FFFF6B;
        #(`CYCLE/2);
        write_data <= `WORD'd0; // N/A 
        #(`CYCLE/2);
        //CBZ X9, 8
        instruction <= `INSTR_LEN'hB4000109;
        #(`CYCLE/2);
        write_data <= `WORD'd0; // N/A 
        #(`CYCLE/2);
        //B 64
        instruction <= `INSTR_LEN'h14000040;
        #(`CYCLE/2);
        write_data <= `WORD'd0; // N/A 
        #(`CYCLE/2);
        //B -55
        instruction <= `INSTR_LEN'h17FFFFC9;
        #(`CYCLE/2);
        write_data <= `WORD'd0; // N/A 
        #(`CYCLE/2);
        //ORR X9, X10, X21
        instruction <= `INSTR_LEN'hAA150149;
        #(`CYCLE/2);
        write_data <= `WORD'd30; // ORR result 
        #(`CYCLE/2);
        //AND X9, X22, X10
        instruction <= `INSTR_LEN'h8A0A02C9;
        #(`CYCLE/2);
        write_data <= `WORD'd14; // Writing 
        #(`CYCLE/2);

    $finish;
    end
    
endmodule