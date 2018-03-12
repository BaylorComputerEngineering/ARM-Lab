`include "definitions.vh"

module iExecute_test;

reg[`WORD-1:0] pc_in;
reg[`WORD-1:0] read_data1;
reg[`WORD-1:0] read_data2;
reg[`WORD-1:0] sign_extended_output;
wire[`WORD-1:0] branch_target;
wire [`WORD-1:0] alu_result;
wire zero;
reg [1:0] alu_op;
reg [10:0] opcode;
reg alu_src;

oscillator myOsc(clk);

iExecute myExecute(
    .pc_in(pc_in),
    .sign_extended_output_in(sign_extended_output),
    .alu_op_in(alu_op),
    .alu_src_in(alu_src),
    .opcode_in(opcode), 
    .read_data1_in(read_data1), 
    .read_data2_in(read_data2),     
    .branch_target(branch_target),
    .alu_result(alu_result),
    .zero(zero)
    );

initial 
begin
    pc_in<=`WORD'd0;
    alu_src<=1'b0;
    sign_extended_output<=`WORD'd520;
    read_data1<=`WORD'd15;
    read_data2<=`WORD'd10;
    opcode<=`ADD;
    alu_op<=2'b10;
    
    #`CYCLE;
    pc_in<=pc_in + 4;
    opcode<=`SUB;
    
    #`CYCLE;
    pc_in<=pc_in + 4;
    opcode<=`AND;
    
    #`CYCLE;
    pc_in<=pc_in + 4;
    opcode<=`ORR;
    
    #`CYCLE;
    pc_in<=pc_in + 4;
    alu_op<=`ALUOp_DTYPE;
    opcode<=`LDUR;
    
    #`CYCLE;
    pc_in<=pc_in + 4;
    alu_op<=`ALUOp_DTYPE;
    opcode<=`STUR;
    
    #`CYCLE;
    pc_in<=pc_in + 4;
    alu_op<=`ALUOp_BRANCH;
    opcode<=`CBZ;
    
    #`CYCLE;
    pc_in<=pc_in + 4;
    opcode<=`B;
    
    #`CYCLE;
    pc_in<=pc_in + 4;
    read_data1<=`WORD'd15;
    read_data2<=`WORD'd15;
    opcode<=`ADD;
    alu_op<=`ALUOp_RTYPE;
    
    #`CYCLE;
    pc_in<=pc_in + 4;
    opcode<=`SUB;
       
    #`CYCLE;
    pc_in<=pc_in + 4;
    opcode<=`ADD;    
    
    #`CYCLE;
    pc_in<=pc_in + 4;
    read_data1<=`WORD'd15;
    read_data2<=`WORD'd0;
    opcode<=`CBZ;
    alu_op<=`ALUOp_BRANCH;
    
    #`CYCLE;
    pc_in<=pc_in + 4;
    read_data1<=`WORD'd15;
    read_data2<=`WORD'd15;
    opcode<=`ADD;
    alu_op<=`ALUOp_RTYPE;    
    
    #`CYCLE;
    pc_in<=pc_in + 4;
    alu_src<=1'b1;
    alu_op<=`ALUOp_DTYPE;
    opcode<=`LDUR;
    
end            
endmodule

