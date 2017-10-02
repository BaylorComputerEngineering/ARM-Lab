`include "definitions.vh"

module iExecute_test;

reg[`WORD-1:0] n_PCin;
wire[`WORD-1:0] nPCout;
reg[`WORD-1:0] Read_data1;
reg[`WORD-1:0] Read_data2;
reg[`WORD-1:0] SignExtendedOutput;
wire[`WORD-1:0] Branch_target;
wire [`WORD-1:0] ALUresult;
wire zero;
reg [1:0] ALUOp;
reg [10:0] Opcode;
reg ALUSrc;

oscillator myOsc(clk);

iExecute myExecute(
    .n_PCin(n_PCin),
    .SignExtendedOutput(SignExtendedOutput),
    .ALUOp(ALUOp),
    .ALUSrc(ALUSrc),
    .Opcode(Opcode), 
    .Read_data1(Read_data1), 
    .Read_data2(Read_data2),     
    .nPCout(nPCout),
    .Branch_target(Branch_target),
    .ALUresult(ALUresult),
    .zero(zero)
    );

initial 
begin
    n_PCin<=`WORD'd0;
    ALUSrc<=1'b0;
    SignExtendedOutput<=`WORD'd520;
    Read_data1<=`WORD'd15;
    Read_data2<=`WORD'd10;
    Opcode<=`ADD;
    ALUOp<=2'b10;
    
    #`CYCLE;
    n_PCin<=n_PCin + 4;
    Opcode<=`SUB;
    
    #`CYCLE;
    n_PCin<=n_PCin + 4;
    Opcode<=`AND;
    
    #`CYCLE;
    n_PCin<=n_PCin + 4;
    Opcode<=`ORR;
    
    #`CYCLE;
    n_PCin<=n_PCin + 4;
    ALUOp<=`ALUOp_DTYPE;
    Opcode<=`LDUR;
    
    #`CYCLE;
    n_PCin<=n_PCin + 4;
    ALUOp<=`ALUOp_DTYPE;
    Opcode<=`STUR;
    
    #`CYCLE;
    n_PCin<=n_PCin + 4;
    ALUOp<=`ALUOp_BRANCH;
    Opcode<=`CBZ;
    
    #`CYCLE;
    n_PCin<=n_PCin + 4;
    Opcode<=`B;
    
    #`CYCLE;
    n_PCin<=n_PCin + 4;
    Read_data1<=`WORD'd15;
    Read_data2<=`WORD'd15;
    Opcode<=`ADD;
    ALUOp<=`ALUOp_RTYPE;
    
    #`CYCLE;
    n_PCin<=n_PCin + 4;
    Opcode<=`SUB;
       
    #`CYCLE;
    n_PCin<=n_PCin + 4;
    Opcode<=`ADD;    
    
    #`CYCLE;
    n_PCin<=n_PCin + 4;
    Read_data1<=`WORD'd15;
    Read_data2<=`WORD'd0;
    Opcode<=`CBZ;
    ALUOp<=`ALUOp_BRANCH;
    
    #`CYCLE;
    n_PCin<=n_PCin + 4;
    Read_data1<=`WORD'd15;
    Read_data2<=`WORD'd15;
    Opcode<=`ADD;
    ALUOp<=`ALUOp_RTYPE;    
    
    #`CYCLE;
    n_PCin<=n_PCin + 4;
    ALUSrc<=1'b1;
    ALUOp<=`ALUOp_DTYPE;
    Opcode<=`LDUR;
    
end            
endmodule

