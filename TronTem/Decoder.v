module Decoder(
input         fetchPhase,
input  [15:0] dataIn,
output reg [15:0] memData,
output reg [15:0] instruction
);

always @(*)begin
if(fetchPhase)
	instruction <= dataIn;
else
	memData <= dataIn;
	
end

endmodule
