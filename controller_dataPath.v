module controller_dataPath(
	input clk,
	input reset,
	input [15:0] instruction,
	output wire [15:0] addressOut,
	output wire [15:0] busOutput
);

wire [7:0] instructionOp;

wire [15:0] immediate;

wire[3:0] regAddA;

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

wire [15:0] tempAddressOut;

wire [15:0] tempbusOutput;



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

   .pcBranch(pcBranch)

);



Datapath UUTdatapath(

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

   .clk(clk),

   .addressOut(tempAddressOut),

	.busOutput(tempbusOutput)

);



assign addressOut = tempAddressOut;

assign busOutput = tempbusOutput;



endmodule