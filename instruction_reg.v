/*

*/
module InstructionRegister (
	input [15:0] instruction,

	output reg [3:0] Rdest,
	output reg [3:0] Rsrc,
	
	output reg [7:0] immediate,
	output reg [7:0] instructionOP
);

always @(instruction) begin
	Rdest = 4'b0;
	Rsrc = 4'b0;
	immediate = 8'b0;
	instructionOP = 8'b0;
	
	if (instruction[13] || instruction[12]) begin
		instructionOp[7:4] = instruction[15:12];
		Rdest = instruction[11:8];
		immediate = instruction[7:0];
	end else if (instruction[15:12] == 4'b0) begin
		Rdest = instruction[11:8];
		instructionOP = {instruction[15:12], instruction[7:4]};
		Rsrc = instruction[3:0];
	end else if (instruction[15:12] == 4'b0100) begin
		case (instruction[7:6])
			// load 
			2'b00: begin
				Rdest = instruction[11:8];
				Rsrc = instruction[3:0];
				instructionOP = {instruction[15:12], instruction[7:4]};
			end
			//stor
			2'b01: begin
				Rdest = instruction[3:0]; //Raddr
				Rsrc = instruction[11:8]; //Rsrc 
				instructionOP = {instruction[15:12], instruction[7:4]};
			end 
			// JAL
			2'b10: begin
				Rdest = instruction[3:0]; //Rtarget 
				Rsrc = instruction[11:8]; //RLink
				instructionOP = {instruction[15:12], instruction[7:4]};
			end
			//Jcond
			2'b11: begin
				Rdest = instruction[3:0]; // Rtarget
				Rsrc = instruction[11:8]; // cond
				instructionOP = {instruction[15:12], instruction[7:4]};
			end
			default: begin
				Rdest = 4'b0;
				Rsrc = 4'b0;
				instructionOP = 8'b0;
			end
	end else if (instruction[15:12] == 4'b1100) begin
			Rdest = instrcution[11:8]; //cond
			immediate = $signed(instruction[7:0]);//imm
	end
end

endmodule
