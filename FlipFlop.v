/*
This Module implements a Flip Flop with
an optional enable bit (Set to 1 if not needed)
*/

module FlipFlop #(parameter WIDTH=16)(
input clk, 
input reset, 
input enable,
input [WIDTH-1:0] d,
output reg [WIDTH-1:0] q
);
always @(posedge clk or posedge reset) begin
	if (reset)
		q <= 0;
	else if (enable)
		q <= d;
end

endmodule