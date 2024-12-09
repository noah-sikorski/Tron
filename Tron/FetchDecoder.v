/*
Decode the next instruction to either be memory or an instruciton.

By: Tron-Tastic Engineers
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
	
	// If the code is in the fetch phase, retrieve the next instruction.
	if(fetchPhase) begin
		instruction <= dataIn;
		memData <= tempMemData;
	// Retrieve data from RAM such 
	end else begin
		memData <= dataIn;
		instruction <= tempInstruction;
	end
end

// Update the temp datas to be put into values later.
always @(posedge clk) begin
	tempInstruction <= instruction;
	tempMemData <= memData;
end

endmodule
