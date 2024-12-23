/*
Sign extend the immediate to keep the negative attribute of it.
If the immediate was not negative, zero extend the immediate.

By: Tron-Tastic Engineers
*/
module SignExtend (
	input [7:0] immediate,
	input [7:0] instructionOp,

	output reg [15:0] extendedImmediate
);

localparam ADDI  = 8'b01010000;
localparam MULI  = 8'b11100000;
localparam SUBI  = 8'b10010000;
localparam CMPI  = 8'b10110000;
localparam ANDI  = 8'b00010000;
localparam LSHI0 = 8'b10000000;
localparam LSHI1 = 8'b10000001;
localparam BCOND = 8'b11000000;

always @(*) begin
	// Sign Extend the Immediate Value that are 8 bits.
	if (instructionOp == ADDI || instructionOp == MULI || instructionOp == SUBI || instructionOp == CMPI || instructionOp == BCOND) begin
		extendedImmediate <= {{8{immediate[7]}}, immediate[7:0]};
	// Sign Extend the Immediate Value that are 4 bits.
	end else if (instructionOp == LSHI0 || instructionOp == LSHI1) begin
		extendedImmediate <= {{12{immediate[3]}}, immediate[3:0]};
	// Zero extend the Immediate Value.
	end else begin
		extendedImmediate <= {8'b0, immediate[7:0]};
	end
end

endmodule
