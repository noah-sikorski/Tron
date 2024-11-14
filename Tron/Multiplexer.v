/*
Decide which of the two inputs to output.
*/
module Multiplexer #(parameter WIDTH = 16) (
	input [WIDTH-1:0] d0, d1, 
	input s, LUIOp,
	output reg [WIDTH-1:0] y
);

always @(*) begin
	if (LUIOp)
		y = 16'd8;
	else
		y = s ? d1 : d0;
end

endmodule
