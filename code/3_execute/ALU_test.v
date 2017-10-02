`include "definitions.vh"

module ALU_test;

reg[`WORD-1:0] A;
reg[`WORD-1:0] B;
wire [3:0] ALU_control;
wire [`WORD-1:0] ALUresult;
wire zero;
reg [1:0] ALUOp;
reg [10:0] Opcode;

oscillator myOsc(clk);

ALU myALU(
    A,
    B,
    ALU_control,
    ALUresult,
    zero
    );
    
ALU_control myALU_control(
    ALUOp,
    Opcode,
    ALU_control
    );

initial 
begin
    A<=`WORD'd15;
    B<=`WORD'd10;
    Opcode<=`ADD;
    ALUOp<=2'b10;
    
    #`CYCLE;
    Opcode<=`SUB;
    
    #`CYCLE;
    Opcode<=`AND;
    
    #`CYCLE;
    Opcode<=`ORR;
    
    #`CYCLE;
    ALUOp<=`ALUOp_DTYPE;
    Opcode<=`LDUR;
    
    #`CYCLE;
    ALUOp<=`ALUOp_DTYPE;
    Opcode<=`STUR;
    
    #`CYCLE;
    ALUOp<=`ALUOp_BRANCH;
    Opcode<=`CBZ;
    
    #`CYCLE;
    Opcode<=`B;
    
    #`CYCLE;
     A<=`WORD'd15;
    B<=`WORD'd15;
    Opcode<=`ADD;
    ALUOp<=`ALUOp_RTYPE;
    
    #`CYCLE;
    Opcode<=`SUB;
       
    #`CYCLE;
    Opcode<=`ADD;    
    
    #`CYCLE;
    A<=`WORD'd15;
    B<=`WORD'd0;
    Opcode<=`CBZ;
    ALUOp<=`ALUOp_BRANCH;
    
    #`CYCLE;
     A<=`WORD'd15;
    B<=`WORD'd15;
    Opcode<=`ADD;
    ALUOp<=`ALUOp_RTYPE;    
end            
endmodule
