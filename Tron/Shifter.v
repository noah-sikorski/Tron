/*
Shift a registers value by a shamt as specified.
This value can be shifted to the left or right as needed.

By: Tron-Tastic Engineers
*/
module Shifter #(parameter WIDTH = 16) (
	input  [WIDTH-1:0] data_in,  	  // Data input to be shifted
	input  [15:0]      shamt,    	  // Shift amount 
	input  [1:0]       shift_op, 	  // Shift operation selector
											  // 00 = Logical Shift Left (LSL)
											  // 01 = Logical Shift Right (LSR)
											  // 10 = Arithmetic Shift Right (ASR)
											  // 11 = Rotate Right (ROR)
	output reg [WIDTH-1:0] data_out // Output after shifting
);

always @(*) begin
	case (shift_op)
		// Logical Shift Left (LSL)
		2'b00: data_out = data_in << shamt;
		// Logical Shift Right (LSR)
		2'b01: data_out = data_in >> shamt;
		// Arithmetic Shift Right (ASR)
		2'b10: data_out = $signed(data_in) >>> shamt;
		// Rotate Right (ROR)
		2'b11: data_out = (data_in >> shamt) | (data_in << (WIDTH - shamt));
		// Default case: All other instructions are covered by BUS.
		default: data_out = data_in;  
	endcase
end

endmodule
