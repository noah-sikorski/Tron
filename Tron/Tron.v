/*
This is the top level entety to combine all elements.
The elements combined are the Controller, Datapath, and
exmem. It allows the use of swicthes and IO to show the
video game Tron.
*/
module Tron (
	input clk,
	input reset,
	
	input [7:0] switches,
	
	output reg VGA_HS,
	output reg VGA_VS,
	output reg VGA_CLK,
	output reg VGA_SYNC_N,
	output reg VGA_BLANK_N,

	output reg[7:0] VGA_R,
	output reg[7:0] VGA_G,
	output reg[7:0] VGA_B	
	
	
);

reg enable = 0;

// Run the clock at 25 MHz and save to the enable wire with the inputted 50 MHz clock.
always @(posedge clk) begin
	enable <= ~enable;
end

// Decoded Instrcution numbers.
wire [7:0] instructionOp;
wire [7:0] immediate;
wire [3:0] regAddA;
wire [3:0] regAddB;

// Control Signals
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

// Important information between the controller and datapath
wire [15:0] addressOut;
wire [15:0] busOutput;
wire [15:0] memData;
wire [15:0] muxTopOutput;
wire [15:0] decoderInput;
wire [15:0] regA;

// Temp wires for VGA
wire [15:0]dataIn2;
wire [15:0]dataOut2;
wire [15:0]addr2;
wire we2;

// VGA control
wire [15:0] hCount;
wire [15:0] vCount;

wire bright;
wire hSync;
wire vSync;

wire [7:0]outRed;
wire [7:0]outGreen;
wire [7:0]outBlue;

// The instruction to execute
wire [15:0] instruction;

// Decode the inputted instruction.
InstructionDecoder InstructionDecoder (
	.instruction(instruction),
	
	.instructionOp(instructionOp),
	.regAddA(regAddA),
	.regAddB(regAddB),
	.immediate(immediate),
	.flagOp(flagOp)
);

// Output each of the control signals.
Controller Controller (
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
// Create final outputs according to control signals.
Datapath Datapath(
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

// Decide if a program counter or data should be sent into data.
Multiplexer TopMultiplexer(
.LUIOp(1'b0),
.d0(regA),
.d1(addressOut),
.s(fetchPhase),
.y(muxTopOutput)
);

// Decode the information from the memory.
FetchDecoder FetchDecoder(
.clk(clk),
.fetchPhase(fetchPhase),
.dataIn(decoderInput),
.memData(memData),
.instruction(instruction)
);

// Retrieve and send infromation in RAM.
exmem exmem(
.switches(switches),
.dataIn1(busOutput),
.addr1(muxTopOutput),
.dataIn2(dataIn2),
.addr2(addr2),
.we1(memWrite),
.we2(we2),
.clk(~clk),
.dataOut1(decoderInput),
.dataOut2(dataOut2)
);

// Control the order of counts for VGA.
VGAControl VGAControl(
.reset(reset),
.clk(enable),
.hSync(hSync),
.vSync(vSync),
.bright(bright),
.hCount(hCount),
.vCount(vCount)
);

// According to counts, find the colors of the VGA.
BitGen BitGen(
.bright(bright),
.hCount(hCount - 16'd145),
.vCount(vCount - 16'd31),
.memAddress(addr2),
.memData(dataOut2),
.VGA_R(outRed),
.VGA_G(outGreen),
.VGA_B(outBlue)
);

// Output VGASync when either hSync or vSync is on.
always @(hSync, vSync) begin
	if (!hSync || !vSync)
		VGA_SYNC_N <= 0;
	else
		VGA_SYNC_N <= 1;
end

// Always save the values to the output of the VGA.
always @(*) begin
	VGA_HS <= hSync;
	VGA_VS <= vSync;
	VGA_CLK <= enable;
	
	// Allow output to only be applied when bright is on.
	if (bright) 
		VGA_BLANK_N <= 1;
	else
		VGA_BLANK_N <= 0;
	
	VGA_R <= outRed;
	VGA_G <= outGreen;
	VGA_B <= outBlue;
end

endmodule
