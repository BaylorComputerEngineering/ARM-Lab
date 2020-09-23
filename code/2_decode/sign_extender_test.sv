`include "verification_functions.sv"

module sign_extender_test;

import verification::*;
int tc = 1;
int ts = 1;

reg [`INSTR_LEN-1:0] instruction;
wire [`WORD-1:0] sign_extended_output;

reg [`WORD-1:0] er_sign_extended_output;

string sign_extended_output_string = "|sign_extended_output|";

sign_extender  sign_extender_instance(
.instruction(instruction),
.sign_extended_output(sign_extended_output)
);

initial
begin
    begin_test();
    
    // LDUR X9, [X22, #64]
    instruction = `INSTR_LEN'b11111000010001000000001011001001;
    er_sign_extended_output = `WORD'd64;
    $display("Test Case %0d: | instruction = %0h", tc++, instruction);     
    #(`CYCLE);
    verify(ts, sign_extended_output_string, er_sign_extended_output, $bits(er_sign_extended_output), sign_extended_output, $bits(sign_extended_output), `S_DEC);

    // ADD X10, X19, X9 
    instruction = `INSTR_LEN'bX;
    er_sign_extended_output = `WORD'd0;
    $display("Test Case %0d: | instruction = %0h", tc++, instruction);     
    #(`CYCLE);
    verify(ts, sign_extended_output_string, er_sign_extended_output, $bits(er_sign_extended_output), sign_extended_output, $bits(sign_extended_output), `S_DEC);

    // SUB X11, X20, X10
    instruction = `INSTR_LEN'b11001011000010100000001010001011;
    er_sign_extended_output = `WORD'd0;
    $display("Test Case %0d: | instruction = %0h", tc++, instruction);     
    #(`CYCLE);
    verify(ts, sign_extended_output_string, er_sign_extended_output, $bits(er_sign_extended_output), sign_extended_output, $bits(sign_extended_output), `S_DEC);

    // STUR X11, [X22, #96]
    instruction = `INSTR_LEN'bX;
    er_sign_extended_output = `WORD'd96;
    $display("Test Case %0d: | instruction = %0h", tc++, instruction);     
    #(`CYCLE);
    verify(ts, sign_extended_output_string, er_sign_extended_output, $bits(er_sign_extended_output), sign_extended_output, $bits(sign_extended_output), `S_DEC);

    // CBZ X11, -5
    instruction = `INSTR_LEN'b10110100111111111111111101101011;
    er_sign_extended_output = -`WORD'd5;

    $display("Test Case %0d: | instruction = %0h", tc++, instruction);     
    #(`CYCLE);
    verify(ts, sign_extended_output_string, er_sign_extended_output, $bits(er_sign_extended_output), sign_extended_output, $bits(sign_extended_output), `S_DEC);

    // CBZ X9, 8
    instruction = `INSTR_LEN'bX;
    er_sign_extended_output = `WORD'd8;

    $display("Test Case %0d: | instruction = %0h", tc++, instruction);     
    #(`CYCLE);
    verify(ts, sign_extended_output_string, er_sign_extended_output, $bits(er_sign_extended_output), sign_extended_output, $bits(sign_extended_output), `S_DEC);

    // B 64
    instruction = `INSTR_LEN'b00010100000000000000000001000000;
    er_sign_extended_output = `WORD'd64;    
    $display("Test Case %0d: | instruction = %0h", tc++, instruction);     
    #(`CYCLE);
    verify(ts, sign_extended_output_string, er_sign_extended_output, $bits(er_sign_extended_output), sign_extended_output, $bits(sign_extended_output), `S_DEC);

    // B -55
    instruction = `INSTR_LEN'bX;
    er_sign_extended_output = -`WORD'd55;
    #(`CYCLE);
    $display("Test Case %0d: | instruction = %0h", tc++, instruction);     
    verify(ts, sign_extended_output_string, er_sign_extended_output, $bits(er_sign_extended_output), sign_extended_output, $bits(sign_extended_output), `S_DEC);

    // ORR X9, X10, X21
    instruction = `INSTR_LEN'b10101010000101010000000101001001;
    er_sign_extended_output = `WORD'd0;    
    $display("Test Case %0d: | instruction = %0h", tc++, instruction);     
    #(`CYCLE);
    verify(ts, sign_extended_output_string, er_sign_extended_output, $bits(er_sign_extended_output), sign_extended_output, $bits(sign_extended_output), `S_DEC);

    // AND X9, X22, X10
    instruction = `INSTR_LEN'bX;
    er_sign_extended_output = `WORD'd0;
    $display("Test Case %0d: | instruction = %0h", tc++, instruction);     
    #(`CYCLE);
    verify(ts, sign_extended_output_string, er_sign_extended_output, $bits(er_sign_extended_output), sign_extended_output, $bits(sign_extended_output), `S_DEC);
        
    final_result();
    $finish;
end

endmodule