module Tron(
	input clk,
	input reset,
	input wire [15:0] instruction,
	output wire [15:0] addressOut,
	output wire [15:0] busOutput
);

wire [15:0] regA;
wire [7:0] instructionOp;
wire [15:0] immediate;
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
wire [15:0] tempAddressOut;
wire [15:0] tempbusOutput;
wire [15:0] memData;

//temp wires for VGA
wire [15:0]dataIn2;
wire [15:0]dataOut2;
wire [15:0]addr2;
wire we2;

//wire [15:0] instruction;

Controller fsmController (
	.clk(clk),
   .reset(reset),
   .instruction(instruction),
	.instructionOp(instructionOp),
   .immediate(immediate),
   .regAddA(regAddA),
   .regAddB(regAddB),
   .flagOp(flagOp),
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
	.fetchPhase(fetchPhase)
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
   .addressOut(tempAddressOut),
	.busOutput(tempbusOutput),
	.regA(regA)
);

exmem mem(
.dataIn1(tempbusOutput),
.addr1(regA),
.dataIn2(dataIn2),
.addr2(addr2),
.ProgramCounter(tempAddressOut),
.we1(memWrite),
.we2(we2),
.clk(clk),
.dataOut1(memData),
.dataOut2(dataOut2),
//.instruction(instruction),
.fetchPhase(fetchPhase)
);


assign addressOut = tempAddressOut;
assign busOutput = tempbusOutput;

endmodule
