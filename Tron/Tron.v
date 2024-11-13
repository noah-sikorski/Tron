/*

*/
module Tron (
	input clk,
	input reset,
	output wire [15:0] LED,
	
	input [15:0] instruction,
	output wire [15:0] busOutput,
	output wire [15:0] addressOut
);

wire [15:0] regA;
wire [7:0] instructionOp;
wire [7:0] immediate;
wire [3:0] regAddA;
wire [3:0] regAddB;
wire [3:0] flagOp;
wire [3:0] ALUOp;
wire [1:0] shiftOp;
wire [2:0] busOp;
wire immMux;
wire regWrite;
wire memWrite;
wire pcAdd;
wire pcJump;
wire pcBranch;
wire flagWrite;
wire fetchPhase;
wire LUIOp;
//wire [15:0] addressOut;
//wire [15:0] busOutput;
wire [15:0] memData;
wire [15:0] muxTopOutput;
wire [15:0] decoderInput;

//temp wires for VGA
wire [15:0]dataIn2;
wire [15:0]dataOut2;
wire [15:0]addr2;
wire we2;

//wire [15:0] instruction;

InstructionDecoder ic(
	.instruction(instruction),
	
	.instructionOp(instructionOp),
	.regAddA(regAddA),
	.regAddB(regAddB),
	.immediate(immediate),
	.flagOp(flagOp)
);

Controller fsmController (
	.clk(clk),
   .reset(reset),
   .instruction(instruction),
	.instructionOp(instructionOp),
	
   .ALUOp(ALUOp),
   .shiftOp(shiftOp),
   .busOp(busOp),
	.immMUX(immMux),
   .regWrite(regWrite),
   .memWrite(memWrite),
   .pcAdd(pcAdd),
   .pcJump(pcJump),
   .pcBranch(pcBranch),
	.flagWrite(flagWrite),
	.fetchPhase(fetchPhase),
	.LUIOp(LUIOp)
);

Datapath UUTdatapath(
	.memData(memData),
	.instructionOp(instructionOp),
	.immediate(immediate),
	.regAddA(regAddA),
	.regAddB(regAddB),
	.ALUOp(ALUOp),
	.shiftOp(shiftOp),
	.busOp(busOp),
	.LUIOp(LUIOp),
	.immMUX(immMux),
	.regWrite(regWrite),
	.memWrite(memWrite),
	.reset(reset),
	.flagOp(flagOp),
	.pcAdd(pcAdd),
	.pcJump(pcJump),
	.pcBranch(pcBranch),
	.flagWrite(flagWrite),
   .clk(clk),
   .addressOut(addressOut),
	.busOutput(busOutput),
	.regA(regA)
);

/*
Multiplexer muxTop(
.d0(regA),
.d1(addressOut),
.s(fetchPhase),
.y(muxTopOutput)
 );
 
FetchDecoder dec(
.fetchPhase(fetchPhase),
.dataIn(decoderInput),
.memData(memData),
.instruction(instruction)
);

exmem mem(
.dataIn1(busOutput),
.addr1(muxTopOutput),
.dataIn2(dataIn2),
.addr2(addr2),
.we1(memWrite),
.we2(we2),
.clk(clk),
.dataOut1(decoderInput),
.dataOut2(dataOut2),
.LED(LED)
);
*/


endmodule
