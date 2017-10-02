`include "definitions.vh"

module iDecode_test;

wire clk;
reg reset;
reg [`WORD-1:0] nPC;
reg [`INSTR_LEN-1:0] IR;
reg [`WORD-1:0] Write_data;
reg Reg2Loc;
reg RegWrite;
wire [4:0] Rm_num;
wire [4:0] Rn_num;
wire [4:0] Rd_num;
wire [4:0]Read_register1;
wire [4:0]Read_register2;
wire [4:0]Write_register;
wire [`WORD-1:0] Read_data1;
wire [`WORD-1:0] Read_data2;
wire [10:0] Opcode;
wire [8:0] Address;
    
iDecode Decoder(
        .clk(clk),
        .reset(reset),
        .nPC(nPC),
        .Instruction(IR),
        .Write_data(Write_data),
        .Reg2Loc(Reg2Loc),
        .RegWrite(RegWrite),
        .Rm_num(Rm_num),
        .Rn_num(Rn_num),
        .Rd_num(Rd_num),
        .Read_register1(Read_register1),
        .Read_register2(Read_register2),
        .Write_register(Write_register),
        .Read_data1(Read_data1),
        .Read_data2(Read_data2),
        .Address(Address),
        .Opcode(Opcode)
        );    

oscillator myOsc(clk);

initial 
begin
reset=0;
Reg2Loc=0;
RegWrite=1;
nPC=4;

// X21 should be set to 16 in fibR.data
// X9 should be set to 33 in fibR.data
// X10 should be set to 12 in fibR.data

// Add X21 + X9 and put in X9
IR = `INSTR_LEN'b10001011000101010000000100101001;

#(`CYCLE);
Write_data=49;
nPC=4;
// Subtract X9-X10 and put in X9
IR = `INSTR_LEN'b11001011000010010000000101001001;

end
endmodule
