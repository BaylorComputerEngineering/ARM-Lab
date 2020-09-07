`include "definitions.vh"



module instr_mem#(
    parameter SIZE=1024)(
	// TODO: Add ports for this module
    );
    
	// TODO: create imem array here
    
	// TODO: insert code here to fetch the correct
	// instruction from imem
    
	
    //initialize memory from file
    initial
        $readmemh(`IMEMFILE, imem);

endmodule
