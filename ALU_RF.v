module ALU_RF(
	input clk,
	input regwrite,
	input [4:0] ra1,
	input [4:0] ra2,
	input [3:0] inst,
	output [15:0] result,
	output [15:0] flagreg
);

wire [15:0] rd1;
wire [15:0] rd2;

	Registers regfile(
		.clk(clk),
		.regwrite(regwrite),
		.ra1(ra1),
		.ra2(ra2),
		.wd(result),
		.rd1(rd1),
		.rd2(rd2)
	);
		

	ALU Alu(
		.reg1(rd1),
		.reg2(rd2),
		.inst(inst),
		.result(result),
		.flagreg(flagreg)
	);
endmodule