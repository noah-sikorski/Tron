/*
Decode the instruction op code from the instruction and input it into the controller and datapath.
*/
module InstructionDecoder (
	input [15:0] instruction,
	output reg [7:0] instructionOp = 8'b0
);

always @(*) begin
	// Case is an immediate or branch.
	if (instruction[13] || instruction[12] || instruction[15:12] == 4'b1100)
		instructionOp <= {instruction[15:12], 4'b0000};
	else
		instructionOp <= {instruction[15:12], instruction[7:4]};
end

endmodule
