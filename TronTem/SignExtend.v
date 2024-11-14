module SignExtend (
	input [7:0] immediate,
	input [7:0] instructionOp,
	output reg [15:0] extendedImmediate
);

localparam ADDI   = 8'b01010000;
localparam SUBI   = 8'b10010000;
localparam CMPI   = 8'b10110000;
localparam ANDI   = 8'b00010000;
localparam LSHI0 	= 8'b10000000;
localparam LSHI1 	= 8'b10000001;
localparam BCOND 	= 8'b11000000;

always @(*) begin
	// Sign Extend the Immediate Value.
	if (instructionOp == ADDI || instructionOp == SUBI || instructionOp == CMPI || instructionOp == BCOND) begin
		extendedImmediate <= {{8{immediate[7]}}, immediate[7:0]};
	end else if (instructionOp == LSHI0 || instructionOp == LSHI1) begin
		extendedImmediate <= {{12{immediate[3]}}, immediate[3:0]};
	end else begin
		extendedImmediate <= {8'b0, immediate[7:0]};
	end
end

endmodule