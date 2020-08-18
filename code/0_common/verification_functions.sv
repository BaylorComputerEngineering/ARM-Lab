`include "definitions.vh"

package verification;

int pass_count = 0;
int fail_count = 0;

function void verify(int step, string title, input bit[`WORD-1:0] er, int er_bits, input bit[`WORD-1:0] ar, int ar_bits, int format);
    $timeformat(-9, 0, " ns", 20);
    assert ((er == ar) && (er_bits == ar_bits))
    begin
        if(format == `HEX)
            $display ("+++ Step %0d: Pass: %s time = %0t | er = %0h | ar = %0h | er_bits = %0d | ar_bits = %0d +++", step, title, $time, er, ar, er_bits, ar_bits);
        else if(format == `BINARY)
            $display ("+++ Step %0d: Pass: %s time = %0t | er = %0u | ar = %0u | er_bits = %0d | ar_bits = %0d +++", step, title, $time, er, ar, er_bits, ar_bits);
        else if(format == `US_DEC)
            $display ("+++ Step %0d: Pass: %s time = %0t | er = %0d | ar = %0d | er_bits = %0d | ar_bits = %0d +++", step, title, $time, er, ar, er_bits, ar_bits);
        else
            $display ("+++ Step %0d: Pass: %s time = %0t | er = %0d | ar = %0d | er_bits = %0d | ar_bits = %0d +++", step, title, $time, $signed(er), $signed(ar), er_bits, ar_bits);
        pass_count++;
    end
    else 
    begin
        if(format == `HEX)
            $display ("--- Step %0d: Fail: %s time = %0t | er = %0h | ar = %0h | er_bits = %0d | ar_bits = %0d ---", step, title, $time, er, ar, er_bits, ar_bits);
        else if(format == `BINARY)
            $display ("--- Step %0d: Fail: %s time = %0t | er = %0u | ar = %0u | er_bits = %0d | ar_bits = %0d ---", step, title, $time, er, ar, er_bits, ar_bits);
        else if(format == `US_DEC)
            $display ("--- Step %0d: Fail: %s time = %0t | er = %0d | ar = %0d | er_bits = %0d | ar_bits = %0d ---", step, title, $time, er, ar, er_bits, ar_bits);
        else
            $display ("--- Step %0d: Fail: %s time = %0t | er = %0d | ar = %0d | er_bits = %0d | ar_bits = %0d ---", step, title, $time, $signed(er), $signed(ar), er_bits, ar_bits);
        fail_count++;
    end
endfunction

function void final_result;
    automatic int total = pass_count + fail_count;
    automatic int grade = 0;
//    grade = int'((100.0*pass_count) / total);
    $display ("\nPass Count = %0d", pass_count);
    $display ("Fail Count = %0d", fail_count);
//    $display("\nPROJECTED GRADE = %0d", grade);
    $display ("\n******* END TEST RESULTS *******\n");     
endfunction

function void begin_test;
    $display ("\n******* BEGIN TEST RESULTS *******\n");
endfunction

endpackage