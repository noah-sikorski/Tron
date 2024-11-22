/*
Decode the next instruction to either be memory or an instruciton.
*/
module FetchDecoder(
input clk,
input fetchPhase,
input [15:0] dataIn,

output reg [15:0] memData,
output reg [15:0] instruction
);

reg [15:0] tempInstruction;
reg [15:0] tempMemData;

always @(*) begin
	instruction <= 16'b0;
	memData <= 16'b0;
	
	if(fetchPhase) begin
		instruction <= dataIn;
		memData <= tempMemData;
	end else begin
		memData <= dataIn;
		instruction <= tempInstruction;
	end
end

always @(posedge clk) begin
	tempInstruction <= instruction;
	tempMemData <= memData;
end

endmodule
