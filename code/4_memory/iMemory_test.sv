`include "verification_functions.sv"

module iMemory_test;

import verification::*;

int tc = 1;
int ts = 1;

reg uncondbranch;
reg branch;
wire clk;
reg zero;
reg mem_read;
reg mem_write;
reg [`WORD-1:0] mem_write_data;
wire pc_src;
wire [`WORD-1:0] mem_read_data;
reg[`WORD - 1:0] address;
reg[`WORD - 1:0] er_mem_read_data;
reg er_pc_src;

string mem_read_data_string = "|mem_read_data|";
string pc_src_string = "|pc_src|";

oscillator clk_gen(clk);
     
iMemory UUT(
    .clk(clk),
    .zero(zero),
    .uncondbranch(uncondbranch),
    .branch(branch),
    .mem_read(mem_read),         
    .mem_write(mem_write),         
    .mem_address(address),         
    .mem_write_data(mem_write_data),         
    .pc_src(pc_src),
    .mem_read_data(mem_read_data)
    );

initial 
    begin
    begin_test();
   
    #(`CYCLE/2);
    $display("\nTest Case %0d", tc++);
    mem_write=0;
    mem_read=0;
    address=`WORD'd0; 
    mem_write_data=`WORD'd0; 
    #(`CYCLE/2);
    er_mem_read_data = `WORD'dX;
    verify(ts, mem_read_data_string, er_mem_read_data, $bits(er_mem_read_data), mem_read_data, $bits(mem_read_data), `S_DEC);        
    #(`CYCLE/2);
 
    $display("\nTest Case %0d", tc++); 
    mem_write=0; 
    mem_read=1;
    address=`WORD'd64; 
    mem_write_data=`WORD'd1; 
    #(`CYCLE/2);
    er_mem_read_data = `WORD'dX;
    verify(ts, mem_read_data_string, er_mem_read_data, $bits(er_mem_read_data), mem_read_data, $bits(mem_read_data), `S_DEC);        
    #(`CYCLE/2);

    $display("\nTest Case %0d", tc++); 
    mem_write=0; 
    mem_read=1;
    address=`WORD'd16; 
    mem_write_data=`WORD'd1; 
    #(`CYCLE/2);
    er_mem_read_data = `WORD'dX;
    verify(ts, mem_read_data_string, er_mem_read_data, $bits(er_mem_read_data), mem_read_data, $bits(mem_read_data), `S_DEC);        
    #(`CYCLE/2);

 
    $display("\nTest Case %0d", tc++);         
    mem_write=1; 
    mem_read=0;
    address=`WORD'd16; 
    mem_write_data= -`WORD'd168; 
    #(`CYCLE/2);
    er_mem_read_data = `WORD'dX;
    verify(ts, mem_read_data_string, er_mem_read_data, $bits(er_mem_read_data), mem_read_data, $bits(mem_read_data), `S_DEC);        
    #(`CYCLE/2);

    $display("\nTest Case %0d", tc++);             
    mem_write=1; 
    mem_read=0;
    address=`WORD'd64; 
    mem_write_data=`WORD'd12345; 
    #(`CYCLE/2);
    er_mem_read_data = `WORD'dX;
    verify(ts, mem_read_data_string, er_mem_read_data, $bits(er_mem_read_data), mem_read_data, $bits(mem_read_data), `S_DEC);        
    #(`CYCLE/2);
     
    $display("\nTest Case %0d", tc++); 
    mem_write=0; 
    mem_read=1;
    address=`WORD'd16; 
    mem_write_data=`WORD'd4; 
    #(`CYCLE/2);
    er_mem_read_data = `WORD'dX;
    verify(ts, mem_read_data_string, er_mem_read_data, $bits(er_mem_read_data), mem_read_data, $bits(mem_read_data), `S_DEC);        
    #(`CYCLE/2);
     
    $display("\nTest Case %0d", tc++); 
    mem_write=0; 
    mem_read=1;
    address=`WORD'd64; 
    mem_write_data=`WORD'd4; 
    #(`CYCLE/2);
    er_mem_read_data = `WORD'dX;
    verify(ts, mem_read_data_string, er_mem_read_data, $bits(er_mem_read_data), mem_read_data, $bits(mem_read_data), `S_DEC);        
    #(`CYCLE/2);
        
    $display("\nTest Case %0d", tc++); 
    mem_write=0; 
    mem_read=1;
    address=`WORD'd32; 
    mem_write_data=`WORD'd2345; 
    #(`CYCLE/2);
    er_mem_read_data = `WORD'dX;
    verify(ts, mem_read_data_string, er_mem_read_data, $bits(er_mem_read_data), mem_read_data, $bits(mem_read_data), `S_DEC);        
    #(`CYCLE/2);
     
    $display("\nTest Case %0d", tc++); 
    mem_write=0; 
    mem_read=1;
    address=`WORD'd32; 
    mem_write_data=`WORD'd2345; 
    #(`CYCLE/2);
    er_mem_read_data = `WORD'dX;
    verify(ts, mem_read_data_string, er_mem_read_data, $bits(er_mem_read_data), mem_read_data, $bits(mem_read_data), `S_DEC);        
    #(`CYCLE/2);
 
    $display("\nTest Case %0d", tc++); 
    uncondbranch = 1;
    branch = 0;
    zero = 0; 
    #(`CYCLE/2);
    er_pc_src = X;
    verify(ts, pc_src_string, er_pc_src, $bits(er_pc_src), pc_src, $bits(pc_src), `BINARY);        
    #(`CYCLE/2);

    $display("\nTest Case %0d", tc++); 
    uncondbranch = 0;
    branch = 0;
    zero = 0; 
    #(`CYCLE/2);
    er_pc_src = X;
    verify(ts, pc_src_string, er_pc_src, $bits(er_pc_src), pc_src, $bits(pc_src), `BINARY);        
    #(`CYCLE/2);
 
    $display("\nTest Case %0d", tc++); 
    uncondbranch = 0;
    branch = 1;
    zero = 0; 
    #(`CYCLE/2);
    er_pc_src = X;
    verify(ts, pc_src_string, er_pc_src, $bits(er_pc_src), pc_src, $bits(pc_src), `BINARY);        
    #(`CYCLE/2); 

    $display("\nTest Case %0d", tc++); 
    uncondbranch = 0;
    branch = 1;
    zero = 1; 
    #(`CYCLE/2);
    er_pc_src = X;
    verify(ts, pc_src_string, er_pc_src, $bits(er_pc_src), pc_src, $bits(pc_src), `BINARY);        
    #(`CYCLE/2); 

    $display("\nTest Case %0d", tc++); 
    uncondbranch = 0;
    branch = 0;
    zero = 1; 
    #(`CYCLE/2);
    er_pc_src = X;
    verify(ts, pc_src_string, er_pc_src, $bits(er_pc_src), pc_src, $bits(pc_src), `BINARY);        
    #(`CYCLE/2); 
         
    final_result();        
    $finish;
    end
    
endmodule