`include "definitions.vh"

package verification;

int pass_count = 0;
int fail_count = 0;
int step = 1;

function void verify(input bit[`WORD-1:0] cr, int cr_bits, input bit[`WORD-1:0] ar, int ar_bits);
    $timeformat(-9, 0, " ns", 20);
    assert ((cr == ar) && (cr_bits == ar_bits))
    begin
        $display ("+++ Step %0d: Pass: \ttime = %0t | cr = %0d | ar = %0d | cr_bits = %0d | ar_bits = %0d +++", step, $time, cr, ar, cr_bits, ar_bits);
        pass_count++;
    end
    else 
    begin
        $display ("--- Step %0d: Fail: \ttime = %0t | cr = %0d | ar = %0d | cr_bits = %0d | ar_bits = %0d ---", step, $time, cr, ar, cr_bits, ar_bits);
        fail_count++;
    end
    step++;   
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