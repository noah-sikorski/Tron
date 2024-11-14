/*
Take many inputs from all modules and decide which one will be outputed.
*/
module Bus (
	input  [15:0] ALUout,    // Input from ALU result
	input  [15:0] shiftout,  // Input from shifter result
   input  [15:0] immediate, // Input from immediate
	input  [15:0] memout,    // Input from data memory
   input  [15:0] pcout,	    // Input form program counter
   input  [15:0] regBout,   // Input from register B
   input  [2:0]  selector,  // Selector signal for choosing the input
	 
   output reg [15:0] dataOut // Selected output
);

// Define selector values for different inputs
localparam ALUSelect       = 3'b000;
localparam shiftSelect     = 3'b001;
localparam immediateSelect = 3'b010;
localparam memorySelect    = 3'b011;
localparam pcSelect        = 3'b100;
localparam regBSelect 	   = 3'b101;

// MUX selection logic
always @(*) begin
	case (selector)
		ALUSelect:    	  dataOut <= ALUout;    // Select ALU result
		shiftSelect:  	  dataOut <= shiftout;  // Select shifter result
		immediateSelect: dataOut <= immediate; // Select register file data
		memorySelect:    dataOut <= memout;    // Select data from memory
		pcSelect: 		  dataOut <= pcout;		// Select program counter
		regBSelect:		  dataOut <= regBout;	// Select register B
		
		default:      	  dataOut <= 16'b0;     // Default to 0
	endcase
end

endmodule
