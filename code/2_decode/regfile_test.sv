`include "verification_functions.sv"

module regfile_test;

import verification::*;

wire read_clk;
wire write_clk;
reg [4:0] read_register1;
reg [4:0] read_register2;
reg [4:0] write_register;
reg [`WORD-1:0] write_data;
reg reg_write;

wire [`WORD -1:0] read_data1;
wire [`WORD -1:0] read_data2;

reg [`WORD -1:0] er_read_data1;
reg [`WORD -1:0] er_read_data2;

string read_data1_string = "|read_data1|";
string read_data2_string = "|read_data2|";

int tc = 1;
int ts = 1;


oscillator clk_gen(read_clk);
delay #(4) del(.a(read_clk), .a_delayed(write_clk));

regfile regfile1(
    .read_clk(read_clk), .write_clk(write_clk),
    .read_register1(read_register1),
    .read_register2(read_register2),
    .write_register(write_register),
    .write_data(write_data),
    .reg_write(reg_write),
    .read_data1(read_data1),
    .read_data2(read_data2)
    );

initial
begin
    begin_test();
    
    // read default values from registers 0 and 5
    read_register1 = 5'd0;
    read_register2 = 5'd5;
    write_register = 5'd0;
    write_data = 0;
    reg_write = 0;

    #(`CYCLE);
    $display("Test Case 1: | rr_1 = %0d | rr_2 = %0d | | wr = %0d | | wd = %0d | rw = %0d |", read_register1, read_register2, write_register, $signed(write_data), reg_write); 
    ts=1;
    
    er_read_data1 = `WORD'dX;
    verify(ts++, read_data1_string, er_read_data1, $bits(er_read_data1), read_data1, $bits(read_data1), `S_DEC);
    er_read_data2 = `WORD'dX;
    verify(ts++, read_data2_string, er_read_data2, $bits(er_read_data2), read_data2, $bits(read_data2), `S_DEC);

    // read default values from registers 3 and 19
    read_register1 = 5'd3;
    read_register2 = 5'd19;
    #`CYCLE;

    $display("\nTest Case 2: | rr_1 = %0d | rr_2 = %0d | | wr = %0d | | wd = %0d | rw = %0d |", read_register1, read_register2, write_register, $signed(write_data), reg_write);    
    ts=1;
    er_read_data1 = `WORD'dX;
    verify(ts++, read_data1_string, er_read_data1, $bits(er_read_data1), read_data1, $bits(read_data1), `S_DEC);
    er_read_data2 = `WORD'dX;
    verify(ts++, read_data2_string, er_read_data2, $bits(er_read_data2), read_data2, $bits(read_data2), `S_DEC);

    // read default values from registers 15 and 12
    read_register1 = 5'd15;
    read_register2 = 5'd12;   
    #`CYCLE;

    $display("\nTest Case 3: | rr_1 = %0d | rr_2 = %0d | | wr = %0d | | wd = %0d | rw = %0d |", read_register1, read_register2, write_register, $signed(write_data), reg_write);    
    ts=1;
    er_read_data1 = `WORD'dX;
    verify(ts++, read_data1_string, er_read_data1, $bits(er_read_data1), read_data1, $bits(read_data1), `S_DEC);
    er_read_data2 = `WORD'dX;
    verify(ts++, read_data2_string, er_read_data2, $bits(er_read_data2), read_data2, $bits(read_data2), `S_DEC);

    // write to register 0, then read the value of register 0 and 12
    reg_write = 1'd1;
    write_data = `WORD'd55;
    write_register = 5'd0;
    read_register1 = 5'd0;
    #`CYCLE;

    $display("\nTest Case 4: | rr_1 = %0d | rr_2 = %0d | | wr = %0d | | wd = %0d | rw = %0d |", read_register1, read_register2, write_register, $signed(write_data), reg_write);        
    ts=1;
    er_read_data1 = `WORD'dX;
    verify(ts++, read_data1_string, er_read_data1, $bits(er_read_data1), read_data1, $bits(read_data1), `S_DEC);
    er_read_data2 = `WORD'dX;
    verify(ts++, read_data2_string, er_read_data2, $bits(er_read_data2), read_data2, $bits(read_data2), `S_DEC);
    
    // update read_register2 to 15 and re-check the value of register 0 and 15
    read_register2 = 5'd15;
    #`CYCLE;

    $display("\nTest Case 5: | rr_1 = %0d | rr_2 = %0d | | wr = %0d | | wd = %0d | rw = %0d |", read_register1, read_register2, write_register, $signed(write_data), reg_write);    
    ts=1;
    er_read_data1 = `WORD'dX;
    verify(ts++, read_data1_string, er_read_data1, $bits(er_read_data1), read_data1, $bits(read_data1), `S_DEC);
    er_read_data2 = `WORD'dX;
    verify(ts++, read_data2_string, er_read_data2, $bits(er_read_data2), read_data2, $bits(read_data2), `S_DEC);

    // write to register 15 and check the value of registers 0 and 15
    write_register = 5'd15;    
    write_data = -`WORD'd354;
    #16;    

    $display("\nTest Case 6: | rr_1 = %0d | rr_2 = %0d | | wr = %0d | | wd = %0d | rw = %0d |", read_register1, read_register2, write_register, $signed(write_data), reg_write);        
    ts=1;
    er_read_data1 = `WORD'dX;
    verify(ts++, read_data1_string, er_read_data1, $bits(er_read_data1), read_data1, $bits(read_data1), `S_DEC);
    er_read_data2 = -`WORD'dX;
    verify(ts++, read_data2_string, er_read_data2, $bits(er_read_data2), read_data2, $bits(read_data2), `S_DEC);
    
    // set reg_write back to 0, change write_data, and verify that the registers do not update   
    reg_write = 1'd0;
    write_data =  `WORD'd23456;
    #(`CYCLE*2);

    $display("\nTest Case 7: | rr_1 = %0d | rr_2 = %0d | | wr = %0d | | wd = %0d | rw = %0d |", read_register1, read_register2, write_register, $signed(write_data), reg_write);        
    ts=1;
    er_read_data1 = `WORD'dX;
    verify(ts++, read_data1_string, er_read_data1, $bits(er_read_data1), read_data1, $bits(read_data1), `S_DEC);
    er_read_data2 = -`WORD'dX;
    verify(ts++, read_data2_string, er_read_data2, $bits(er_read_data2), read_data2, $bits(read_data2), `S_DEC);
    
    // set read_register1 to 15 and check the value of registers 15 and 15
    read_register1 = 5'd15;
    #8;

    $display("\nTest Case 8: | rr_1 = %0d | rr_2 = %0d | | wr = %0d | | wd = %0d | rw = %0d |", read_register1, read_register2, write_register, $signed(write_data), reg_write);        
    ts=1;
    er_read_data1 = `WORD'dX;
    verify(ts++, read_data1_string, er_read_data1, $bits(er_read_data1), read_data1, $bits(read_data1), `S_DEC);
    er_read_data2 = -`WORD'dX;
    verify(ts++, read_data2_string, er_read_data2, $bits(er_read_data2), read_data2, $bits(read_data2), `S_DEC);
    // check the value of registers 15 and 15
    
    #2;

    $display("\nTest Case 9: | rr_1 = %0d | rr_2 = %0d | | wr = %0d | | wd = %0d | rw = %0d |", read_register1, read_register2, write_register, $signed(write_data), reg_write);    
    ts=1;
    er_read_data1 = -`WORD'dX;
    verify(ts++, read_data1_string, er_read_data1, $bits(er_read_data1), read_data1, $bits(read_data1), `S_DEC);
    er_read_data2 = -`WORD'dX;
    verify(ts++, read_data2_string, er_read_data2, $bits(er_read_data2), read_data2, $bits(read_data2), `S_DEC);
    
    final_result();
    $finish;
end

endmodule