/*
This module controls the ALU for the CPU.
First three bits signify operand to execute.
Fourth bit signifies if signed or unsigned.
Fifth bit signifies if should be subtract operation.
*/
module ALU #(parameter WIDTH=16) (
	input [WIDTH-1:0] reg1, reg2,
	input [3:0] inst,
	output reg [WIDTH-1:0] result, flagreg
);

wire [WIDTH-1:0] ressum, resand, resor, resxor;
assign ressum = reg1 + (inst[3] ? ~reg2:reg2) + inst[3];
assign resand = reg1 & reg2;
assign resor  = reg1 | reg2;
assign resxor = reg1 ^ reg2;

always@(*) begin
	// Carry 	Flag: Bit 0 = C0
	// Low 		Flag: Bit 1 = L1
	// Overflow Flag: Bit 2 = O2
	// Equal 	Flag: Bit 3 = E3
	// Negative Flag: Bit 4 = N4
	flagreg[WIDTH-1:0] = {WIDTH{1'b0}};
	case(inst[2:0])
		// Case for addition and subtraction.
		3'b000: begin
			result <= ressum;
			flagreg[0] <= ressum < reg1 || ressum < reg2;
			flagreg[1] <= reg2 < reg1;
			flagreg[2] <= inst[3] ? ((reg2[WIDTH-1] == reg1[WIDTH-1]) && (ressum[WIDTH-1] != reg1[WIDTH-1]))
							  : ((reg2[WIDTH-1] != reg1[WIDTH-1]) && (ressum[WIDTH-1] != reg2[WIDTH-1]));
			flagreg[3] <= ressum == {WIDTH{1'b0}};
			flagreg[4] <= ressum[WIDTH-1];
		// Case for AND.
		end 3'b001: begin
			result <= resand;
			flagreg[3] <= resand == {WIDTH{1'b0}};
		// Case for OR.
		end 3'b010: begin
			result <= resor;
			flagreg[3] <= resor == {WIDTH{1'b0}};
		// Case for XOR.
		end 3'b011: begin
			result <= resxor;
			flagreg[3] <= resxor == {WIDTH{1'b0}};
		// Default Case
		end default: begin
			result <= {WIDTH{1'b0}};
		end
	endcase
end
	
endmodule
