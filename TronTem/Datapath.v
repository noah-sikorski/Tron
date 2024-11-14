module Datapath #(parameter WIDTH = 16, REGBITS = 4)
(
	input [15:0] memData,
   input [7:0] instructionOp,
	input [7:0] immediate,
	input [3:0] regAddA,
	input [3:0] regAddB,
	input [3:0] ALUOp,
	input [1:0] shiftOp,
	input [2:0] busOp,
	input immMUX,
	input regWrite,
	input memWrite,
	input reset,
	input [3:0] flagOp,
	input pcAdd,
	input pcJump,
	input pcBranch,
	input clk,
	input flagWrite,
	input LUIOp,
	
   output wire [WIDTH - 1: 0] addressOut,
	output wire [WIDTH - 1: 0] busOutput,
	output wire [WIDTH - 1: 0] regA
);


wire [15:0] regB;
wire [15:0] IMMMuxRes; 
wire [15:0] ALUresult;
wire [4:0] flagreg;
wire [15:0] shifterOutput;
wire [15:0] extendedImmediate;

// Setup with always statement with instruction as input.

SignExtend extend(.immediate(immediate), .instructionOp(instructionOp), .extendedImmediate(extendedImmediate));

ProgramCounter pc(.reset(reset), .flagOp(flagOp), .flagRegister(flagreg), .immediate(extendedImmediate),
						.pcAdd(pcAdd), .pcJump(pcJump), .pcBranch(pcBranch), .addressOut(addressOut),
						.rTarget(regA), .clk(clk));

Registers regFile(.clk(clk), .regwrite(regWrite), .ra1(regAddA), .ra2(regAddB),
						.wd(busOutput), .rd1(regA), .rd2(regB));

Multiplexer IMMmux(.d0(regA), .d1(extendedImmediate), .s(immMUX), .LUIOp(LUIOp), .y(IMMMuxRes));  

ALU ALu(.clk(clk), .reg1(regB), .reg2(IMMMuxRes), .inst(ALUOp), .flagWrite(flagWrite), .result(ALUresult), 
		  .flagreg(flagreg));

Shifter shift(.data_in(regB), .shamt(IMMMuxRes), .shift_op(shiftOp), .data_out(shifterOutput));

Bus bus(.immediate(IMMMuxRes), .memout(memData), .ALUout(ALUresult), .shiftout(shifterOutput),
						.pcout(addressOut), .selector(busOp), .dataOut(busOutput), .regBout(regB));

endmodule