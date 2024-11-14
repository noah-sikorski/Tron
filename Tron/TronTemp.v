/*
This is the top level entety to combine all elements.
The elements combined are the Controller, Datapath, and
exmem. It allows the use of swicthes and IO to show the
video game Tron.
*/
module TronTemp (
	input clk,
	input reset,
	
	input [7:0] switches, 
	output wire [7:0] LED
);

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

//temp wires for VGA
wire [15:0]dataIn2;
wire [15:0]dataOut2;
wire [15:0]addr2;
wire we2;

// The instruction to execute
wire [15:0] instruction;

// Decode the inputted instruction.
InstructionDecoder ic(
	.instruction(instruction),
	
	.instructionOp(instructionOp),
	.regAddA(regAddA),
	.regAddB(regAddB),
	.immediate(immediate),
	.flagOp(flagOp)
);

// Output each of the control signals.
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
// Create final outputs according to control signals.
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

// Decide if a program counter or data should be sent into data.
Multiplexer muxTop(
.d0(regA),
.d1(addressOut),
.s(fetchPhase),
.y(muxTopOutput)
);

// Decode the information from the memory.
FetchDecoder dec(
.fetchPhase(fetchPhase),
.dataIn(decoderInput),
.memData(memData),
.instruction(instruction)
);

// Retrieve and send infromation in RAM.
exmem mem(
.switches(switches),
.dataIn1(busOutput),
.addr1(muxTopOutput),
.dataIn2(dataIn2),
.addr2(addr2),
.we1(memWrite),
.we2(we2),
.clk(~clk),
.dataOut1(decoderInput),
.dataOut2(dataOut2),
.LED(LED)
);

endmodule
