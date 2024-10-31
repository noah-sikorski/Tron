module datapath #(parameter WIDTH = 16, REGBITS = 4)
(
   input  [7:0] instructionOp,
	input  [WIDTH-1:0] immediate,
	input  [3:0] addressOfRegSoruce,
	input  [3:0] addressOfRegDst,
	input  [3:0] shiftAmount,
	input  [4:0] ALUOp,
	input  [1:0] shiftOp,
	input  [1:0] busOp,
	input  immMUX,
	input  regWrite,
	input  memWrite,
	input  [WIDTH-1:0] Data,
	input  clk,
   output [Width - 1:0] RegisterAddress
);

wire [1:0] shiftOp;
wire [3:0] shamt;
wire [7:0] instructionOP;

wire [7:0] extendedImmediate;
wire [15:0] writeData; //Flipflop from PC, Shifter, or memory
wire [3:0] regSource;
wire [3:0] regDest;
wire [15:0] ALUMuxRes; //Needs to be signextended
wire [15:0] ShiftMuxRes;
wire [15:0] ALUresult;
wire [15:0] flagreg;
wire [15:0] data_out;
wire [15:0] busOutput;
wire [15:0] dataFFResult;

SignedExtenstion ImmediateExtension (.instruction(immediate), .result(extendedImmediate));

// Setup with always statement with instruction as input.

Registers regFile(.clk(clk), .regwrite(regWrite), .ra1(addressOfRegSoruce), .ra2(addressOfRegDst), .wd(writeData), 
.rd1(regSource), .rd2(regDest));

Multiplexer ALUmux(.do1(extendedImmediate), .d02(regSource), .s(immMux), .y(ALUMuxRes)); //Result needs to be 

Multiplexer ShiftMux(.doi1(extendedImmediate),.do2(regDest),.s(ShifterMultiplexer),.y(ShiftMuxres)); // results needs to be signed 

ALU ALu(.reg1(AluMuxres), .reg2(regDest),.inst(ALUOp),.result(ALUresult),.flagreg(flagreg));

Shifter shifter(.data_in(ShiftMuxres),.shamt(shiftAmount),.shift_op(shift_op),.data_out(data_out));

mux4 multiplexor(.register(regSource),.dataMem(Data),.ALUResult(ALUresult),.shifterResult(data_out),.selector(busOp),.dataOut(busOutput));

FlipFlop DatasFF(.clk(clk), .reset(reset), .enable(memwrite), .d(BusOutput), .q(dataFFResult));  

endmodule