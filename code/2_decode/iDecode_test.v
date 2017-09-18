`include "definitions.vh"

module iDecode_test;

wire clk;
reg reset;
reg [`WORD-1:0] nPC;
reg [`INSTR_LEN-1:0] IR;
reg [`WORD-1:0] Write_data;
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
wire [`WORD-1:0] SignExtendedOutput;
wire [`WORD-1:0] nPCout;
wire Reg2Loc;
wire Branch;
wire MemRead;
wire MemtoReg;
wire [1:0] ALUOp;
wire MemWrite;
wire ALUSrc;
wire RegWrite;
    
    
iDecode Decoder(
        .clk(clk),
        .reset(reset),
        .nPC(nPC),
        .Instruction(IR),
        .Write_data(Write_data),
        .nPCout(nPCout),
        .SignExtendedOutput(SignExtendedOutput),
        .Reg2Loc(Reg2Loc),
        .Branch(Branch),
        .MemRead(MemRead),
        .MemtoReg(MemtoReg),
        .ALUOp(ALUOp),
        .MemWrite(MemWrite),
        .ALUSrc(ALUSrc),
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
nPC=4;
#(`CYCLE/2);
// X21 should be set to 16 in fibR.data
// X9 should be set to 33 in fibR.data
// X10 should be set to 12 in fibR.data
IR = `INSTR_LEN'b11111000010001000000001011001001;
nPC=nPC+4;
Write_data=33;
#(`CYCLE);

IR = `INSTR_LEN'b11111000010000100000001011001010;
nPC=nPC+4;
Write_data=12;
#(`CYCLE);

// Add X21 + X9 and put in X9
IR = `INSTR_LEN'b10001011000101010000000100101001;
nPC=nPC+4;
#(`CYCLE);

Write_data=49;
nPC=nPC+4;
// Subtract X9-X10 and put in X9
IR = `INSTR_LEN'b11001011000010010000000101001001;
#(`CYCLE);

IR = `INSTR_LEN'b11111000000001100000001011001001;
nPC=nPC+4;
#(`CYCLE);

IR = `INSTR_LEN'b10110100111111100000001011001001;
nPC=nPC+4;
#(`CYCLE);

end
endmodule
