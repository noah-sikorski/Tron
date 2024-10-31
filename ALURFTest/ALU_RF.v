/*
Top level code to combine the ALU and Registers to allow registers to be inputted into the ALU.
*/
module ALU_RF(
	input clk,
	input regwrite,
	input [3:0] ra1,
	input [3:0] ra2,
	input [3:0] inst,
	output [15:0] result,
	output [15:0] flagreg
);

wire [15:0] rd1;
wire [15:0] rd2;

// Call to RegFile Module.
Registers regfile (
	.clk(clk),
	.regwrite(regwrite),
	.ra1(ra1),
	.ra2(ra2),
	.wd(result),
	.rd1(rd1),
	.rd2(rd2)
);

// Call to ALU Module.
ALU Alu (
	.reg1(rd1),
	.reg2(rd2),
	.inst(inst),
	.result(result),
	.flagreg(flagreg)
);
	
endmodule
