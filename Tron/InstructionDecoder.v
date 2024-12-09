/*
Decode the instruction op code from the instruction and input it into the controller and datapath.

By: Tron-Tastic Engineers
*/
module InstructionDecoder (
	input [15:0] instruction,
	
	output reg [7:0] instructionOp = 8'b0,
	output reg [3:0] regAddA = 4'b0,
	output reg [3:0] regAddB = 4'b0,
	output reg [7:0] immediate = 8'b0,
	output reg [3:0] flagOp = 4'b0
);

always @(*) begin
	// Initialize registers, immediate, and OPCode.
	regAddA       <= 4'b0;
	regAddB       <= 4'b0;
	immediate     <= 8'b0;
	flagOp		  <= 4'b0;
	instructionOp <= 8'b0;
	
	// Register Type Instruction
	if (instruction[15:12] == 4'b0000) begin
		instructionOp <= {instruction[15:12], instruction[7:4]};
		regAddA <= instruction[3:0];
		regAddB <= instruction[11:8];
		
	// Immediate Type Instruction
	end else if (instruction[13] || instruction[12]) begin
		instructionOp[7:4] <= instruction[15:12];
		regAddB <= instruction[11:8];
		immediate <= instruction[7:0];
	
	// Special Type Instruction
	end else if (instruction[15:12] == 4'b0100) begin	
		// LOAD Type Instruction
		if (instruction[7:4] == 4'b0000) begin
			instructionOp <= {instruction[15:12], instruction[7:4]};
			regAddA <= instruction[3:0];
			regAddB <= instruction[11:8];
			
		// STOR Type Instruction
		end else if (instruction[7:4] == 4'b0100) begin
			instructionOp <= {instruction[15:12], instruction[7:4]};
			regAddA <= instruction[3:0];
			regAddB <= instruction[11:8];
			
		// JAL Type Instruction
		end else if (instruction[7:4] == 4'b1000) begin
			instructionOp <= {instruction[15:12], instruction[7:4]};
			flagOp <= 4'b1111;
			regAddA <= instruction[3:0];
			regAddB <= instruction[11:8];
		
		// Jump Cond Type Instruction
		end else begin
			instructionOp <= {instruction[15:12], instruction[7:4]};
			flagOp  <= instruction[11:8];
			regAddA <= instruction[3:0];
		end
	
	// Shift Type Instruction
	end else if (instruction[15:12] == 4'b1000) begin
		// LSH Type Instruction
		if (instruction[7:4] == 4'b0100) begin
			instructionOp <= {instruction[15:12], instruction[7:4]};
			regAddA <= instruction[3:0];
			regAddB <= instruction[11:8];
			
		// LSHI Type Instruction
		end else begin
			instructionOp <= {instruction[15:12], instruction[7:4]};
			regAddB <= instruction[11:8];
			immediate <= instruction[3:0];
		end
	
	// Conditional Type Instruction
	end else begin
		// Branch Cond Type Instruction
		if (instruction[15:12] == 4'b1100) begin
			instructionOp[7:4] <= instruction[15:12];
			flagOp <= instruction[11:8];
			immediate <= instruction[7:0];
		end
	end
end

endmodule
