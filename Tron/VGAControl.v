/*
Run through the correct regions according to the VGA protocol.
Have the bright on in the desired regions to allow drawing with
VGA at the correct times.

By: Tron-Tastic Engineers
*/
module VGAControl (
input reset,
input clk,

output reg hSync,
output reg vSync,
output wire bright,

output reg [15:0] hCount,
output reg [15:0] vCount
);

reg hBright = 1'b0;
reg vBright = 1'b0;

assign bright = hBright & vBright;

always @(posedge clk) begin
	if (~reset) begin
		hCount <= 16'b0;
		vCount <= 16'b0;
	end

	
	// Vertical Sync Timing
	// Pulse Width
	if (vCount < 2) begin
		vSync <= 1'b0;
		vBright <= 1'b0;
	end
	// Back Porch
	else if (vCount < 31) begin
		vSync <= 1'b1;
		vBright <= 1'b0;
	end
	// Display Time
	else if (vCount < 511) begin
		vSync <= 1'b1;
		vBright <= 1'b1;
	end
	// Front Porch
	else if (vCount < 520) begin
		vSync <= 1'b1;
		vBright <= 1'b0;
	end
	// After Full Pulse
	else if (hCount >= 520) begin
		vSync <= 1'b0;
		vBright <= 1'b0;
		vCount <= 16'b0;
	end
	
	
	// Horizontal Sync Timing
	// Pulse Width
	if (hCount < 96) begin
		hSync <= 1'b0;
		hBright <= 1'b0;
		hCount <= hCount + 16'b1;
	// Back Porch
	end else if (hCount < 144) begin
		hSync <= 1'b1;
		hBright <= 1'b0;
		hCount <= hCount + 16'b1;
	end
	// Display Time
	else if (hCount < 784) begin
		hSync <= 1'b1;
		hBright <= 1'b1;
		hCount <= hCount + 16'b1;
	end
	// Front Porch
	else if (hCount < 799) begin
		hSync <= 1'b1;
		hBright <= 1'b0;
		hCount <= hCount + 16'b1;
	end
	// After Full Pulse
	else if (hCount >= 799) begin
		hSync <= 1'b0;
		hBright <= 1'b0;
		hCount <= 16'b0;
		vCount <= vCount + 16'b1;
	end
end

endmodule
