`include "definitions.vh"

module ALU_test;

reg[`WORD-1:0] a;
reg[`WORD-1:0] b;
wire [3:0] alu_control;
wire [`WORD-1:0] alu_result;
wire zero;
reg [1:0] alu_op;
reg [10:0] opcode;

oscillator myOsc(clk);

ALU myALU(
    a,
    b,
    alu_control,
    alu_result,
    zero
    );
    
alu_control myALU_control(
    alu_op,
    opcode,
    alu_control
    );

initial 
begin
    a<=`WORD'd15;
    b<=`WORD'd10;
    opcode<=`ADD;
    alu_op<=2'b10;
    
    #`CYCLE;
    opcode<=`SUB;
    
    #`CYCLE;
    opcode<=`AND;
    
    #`CYCLE;
    opcode<=`ORR;
    
    #`CYCLE;
    alu_op<=`ALUOp_DTYPE;
    opcode<=`LDUR;
    
    #`CYCLE;
    alu_op<=`ALUOp_DTYPE;
    opcode<=`STUR;
    
    #`CYCLE;
    alu_op<=`ALUOp_BRANCH;
    opcode<=`CBZ;
    
    #`CYCLE;
    opcode<=`B;
    
    #`CYCLE;
    a<=`WORD'd15;
    b<=`WORD'd15;
    opcode<=`ADD;
    alu_op<=`ALUOp_RTYPE;
    
    #`CYCLE;
    opcode<=`SUB;
       
    #`CYCLE;
    opcode<=`ADD;    
    
    #`CYCLE;
    a<=`WORD'd15;
    b<=`WORD'd0;
    opcode<=`CBZ;
    alu_op<=`ALUOp_BRANCH;
    
    #`CYCLE;
    a<=`WORD'd15;
    b<=`WORD'd15;
    opcode<=`ADD;
    alu_op<=`ALUOp_RTYPE;    
end            
endmodule
