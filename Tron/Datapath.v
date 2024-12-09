/*
Combine all elements together to have all modules linked together.
Uses the control bits from the Controller to output the desired 
program counter and calculation output.

By: Tron-Tastic Engineers
*/
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
	input [3:0] flagOp,
	
	input immMUX,
	input regWrite,
	input reset,
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
wire [4:0]  flagreg;
wire [15:0] shifterOutput;
wire [15:0] extendedImmediate;

// Extend the immediate.
SignExtend SignExtender(.immediate(immediate), .instructionOp(instructionOp), .extendedImmediate(extendedImmediate));

// Use the program counter to go retrieve next instruction.
ProgramCounter ProgramCounter(.reset(reset), .flagOp(flagOp), .flagRegister(flagreg), .immediate(extendedImmediate),
						.pcAdd(pcAdd), .pcJump(pcJump), .pcBranch(pcBranch), .addressOut(addressOut),
						.rTarget(regA), .clk(clk));

// Use registers to compute values desired.
Registers RegisterFile(.clk(clk), .regwrite(regWrite), .ra1(regAddA), .ra2(regAddB),
						.wd(busOutput), .rd1(regA), .rd2(regB));

// Decide which value to use between two values.
Multiplexer Multiplexer(.d0(regA), .d1(extendedImmediate), .s(immMUX), .LUIOp(LUIOp), .y(IMMMuxRes));  

// Compute arithmetic if the value is needed.
ALU ArithmeticLogicUnit(.clk(clk), .instructionOp(instructionOp), .reg1(regB), .reg2(IMMMuxRes), .inst(ALUOp), 
		  .flagWrite(flagWrite), .result(ALUresult), .flagreg(flagreg));

// Shift the value according to a shamt.
Shifter Shifter(.data_in(regB), .shamt(IMMMuxRes), .shift_op(shiftOp), .data_out(shifterOutput));

// Decide which value to be sent to write.
Bus Bus(.immediate(IMMMuxRes), .memout(memData), .ALUout(ALUresult), .shiftout(shifterOutput),
						.pcout(addressOut + 16'b1), .selector(busOp), .dataOut(busOutput), .regBout(regB));

endmodule
