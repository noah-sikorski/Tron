/*
This module controls the ALU for the CPU.
First three bits signify operand to execute.
Fourth bit signifies if signed or unsigned.
Fifth bit signifies if should be subtract operation.
*/
module ALU #(parameter WIDTH=16) (
	input clk,

	input [WIDTH-1:0] reg1, reg2,
	input [3:0] inst,
	input flagWrite,
	
	output reg [WIDTH-1:0] result, 
	output reg [4:0] flagreg = 5'b0
);

wire [WIDTH:0] ressum, resand, resor, resxor;
assign ressum = reg1 + (inst[3] ? ~reg2:reg2) + inst[3];
assign resand = reg1 & reg2;
assign resor  = reg1 | reg2;
assign resxor = reg1 ^ reg2;

always @(negedge clk) begin
	if (flagWrite) begin
		flagreg[0] <= ressum[16];
		flagreg[1] <= reg2 < reg1;
		flagreg[2] <= (reg2[WIDTH-1] != reg1[WIDTH-1]) && (ressum[WIDTH-1] != reg2[WIDTH-1]);
		flagreg[3] <= ressum == {WIDTH{1'b0}};
		flagreg[4] <= ressum[WIDTH-1];
	end
end

always@(*) begin
	// Carry 	Flag: Bit 0 = C0 : C
	// Low 		Flag: Bit 1 = L1 : L
	// Overflow Flag: Bit 2 = O2 : F
	// Equal 	Flag: Bit 3 = E3 : Z
	// Negative Flag: Bit 4 = N4 : N
	case(inst[2:0])
		// Case for addition and subtraction.
		3'b000: begin
			result <= ressum[15:0];
		// Case for AND.
		end 3'b001: begin
			result <= resand[15:0];
		// Case for OR.
		end 3'b010: begin
			result <= resor[15:0];
		// Case for XOR.
		end 3'b011: begin
			result <= resxor[15:0];
		// Default Case
		end default: begin
			result <= {WIDTH{1'b0}};
		end
	endcase
end
	
endmodule
