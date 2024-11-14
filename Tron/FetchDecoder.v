/*
Decode the next instruction to either be memory or an instruciton.
*/
module FetchDecoder(
input         fetchPhase,
input  [15:0] dataIn,

output reg [15:0] memData,
output reg [15:0] instruction
);
wire [15:0] tempInstruction;
wire [15:0] tempMemData;

always @(*)begin
	if(fetchPhase)begin
		instruction <= dataIn;
		memData <= tempMemData;
		end
	else begin
		memData <= dataIn;
		instruction <= tempInstruction;
		end
end

assign tempInstruction = instruction;
assign tempMemData = memData;


endmodule
