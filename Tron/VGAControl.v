/*

*/
module VGAControl (
input reset,
input clk,

output reg hSync,
output reg vSync,
output reg bright,

output reg [15:0] hCount,
output reg [15:0] vCount
);

    always @(posedge clk) begin
	// reset both the horizontal and vertical counter 
        if (~reset) begin
            hCount <= 0;
            vCount <= 0;
        end else begin
            // Increment hcount and handle display logic based on hcount and vcount
	    // in the front porch of the screen 
            if(hCount < 96) begin
		    // if vcount is at the end of current column, reset it to 0 (new column)
		    if(vCount >= 639)
			vCount <= 0;
			hSync <= 0; // indicate a new row 
		        hCount <= hCount + 10'd1; // increment hcount ( x position of the screen)
		        bright <= 0; // set brightness off 
		end
		// in back porch of the screen, increment the hcount and set hsync high to indicate that it's not a new row
		else if(hCount < 144) begin 
			hCount <= hCount + 10'd1;
			hSync <= 1;
			bright <= 0;
		end 
		// in active area of the screen, increment the hcount and display the pixels that are within the active area
		else if(hCount < 784) begin 
			hCount <= hCount + 10'd1;
			hSync <= 1;
			bright <= 1;
		end 
		
		//past the active area, stop display the pixels and continue to increment hcount until 799
		else if (hCount < 800) begin 
			// if hcount = 799, reset the hcount and increment the vcount by 1
			if(hCount == 799) begin 
				hCount <= 0;
				vCount <= vCount + 10'd1;
			end else begin
				hCount <= hCount + 10'd1; 
				hSync <= 1;
			end
			bright <= 0;
		end 
        end
        
        // Generate vsync signal based on vcount
        if (vCount < 1) begin
            vSync <= 0; // indicate a new column
        end else begin
            vSync <= 1; 
        end
    end

endmodule
