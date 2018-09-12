`include "definitions.vh"

module instr_parse_test;

reg [`INSTR_LEN-1:0] instruction;
wire [4:0]rm_num;
wire [4:0]rn_num;
wire [4:0]rd_num;
wire [8:0]address;
wire [10:0]opcode;

instruction_parse parser(
.instruction(instruction),
.rm_num(rm_num),
.rn_num(rn_num),
.rd_num(rd_num),
.address(address),
.opcode(opcode)
    );
    
initial
begin
// LDUR X9, [X10, #240]
instruction = `INSTR_LEN'b11111000010011110000000101001001;
#(`CYCLE);

// ADD X10, X21, X9
instruction = `INSTR_LEN'b10001011000010010000001010101010;
#(`CYCLE);

// STUR X9, [X10, #240]
instruction = `INSTR_LEN'b11111000000011110000000101001001;
#(`CYCLE);

$finish;
end
endmodule
