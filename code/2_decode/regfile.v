`include "definitions.vh"

module regfile#(
    parameter SIZE=32)(
    input read_clk,
    input write_clk,
    input reg_write,
    input [4:0] read_register1,
    input [4:0] read_register2,
    input [4:0] write_register,
    input [`WORD - 1:0] write_data,
    output reg [`WORD - 1:0] read_data1,
    output reg [`WORD - 1:0] read_data2
    );
    reg[`WORD - 1:0] rf [SIZE-1:0];
    
    // handle input

    always @(posedge(write_clk))begin
        // insert code to write to rf when appropriate
    end
    
    //handle output
    always @(posedge(read_clk))begin
        // insert code to read from rf when appropriate
    end
    
    //initialize memory from file
    initial
        $readmemb(`RMEMFILE, rf);

endmodule
