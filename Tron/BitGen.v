/*

*/
module BitGen (
input bright,
input [15:0] hCount,
input [15:0] vCount,

output [15:0] memAddress,	// To exmem addr2
input [15:0] memData,      //dataOut 2

output reg[7:0] VGA_R,
output reg[7:0] VGA_G,
output reg[7:0] VGA_B
);

wire [15:0] pixelPosition;

localparam glyph0  = 16'd0;  // Black Square
localparam glyph1  = 16'd1;  // Blue Square
localparam glyph2  = 16'd2;  // Yellow Square

localparam glyph3  = 16'd3;  // Blue Horizontal Path
localparam glyph4  = 16'd4;  // Blue Vertical Path
localparam glyph5  = 16'd5;  // Blue Generic Corner Path
localparam glyph6  = 16'd6;  // Blue Corner Left Down
localparam glyph7  = 16'd7;  // Blue Corner Left Up
localparam glyph8  = 16'd8;  // Blue Corner Right Down
localparam glyph9  = 16'd9;  // Blue Corner Right Up

localparam glyph11 = 16'd11; // Blue Bike Horizontal 1
localparam glyph12 = 16'd12; // Blue Bike Horizontal 2
localparam glyph13 = 16'd13; // Blue Bike Horizontal 3
localparam glyph14 = 16'd14; // Blue Bike Horizontal 4
localparam glyph15 = 16'd15; // Blue Bike Horizontal 5
localparam glyph16 = 16'd16; // Blue Bike Horizontal 6
localparam glyph17 = 16'd17; // Blue Bike Horizontal 7
localparam glyph18 = 16'd18; // Blue Bike Horizontal 8
localparam glyph19 = 16'd19; // Blue Bike Horizontal 9

localparam glyph21 = 16'd21; // Blue Bike Vertical 1
localparam glyph22 = 16'd22; // Blue Bike Vertical 2
localparam glyph23 = 16'd23; // Blue Bike Vertical 3
localparam glyph24 = 16'd24; // Blue Bike Vertical 4
localparam glyph25 = 16'd25; // Blue Bike Vertical 5
localparam glyph26 = 16'd26; // Blue Bike Vertical 6
localparam glyph27 = 16'd27; // Blue Bike Vertical 7
localparam glyph28 = 16'd28; // Blue Bike Vertical 8
localparam glyph29 = 16'd29; // Blue Bike Vertical 9

localparam glyph34 = 16'd34; // Yellow Horizontal Path
localparam glyph35 = 16'd35; // Yellow Vertical Path
localparam glyph36 = 16'd36; // Yellow Generic Corner Path
localparam glyph37 = 16'd37; // Yellow Corner Left Down
localparam glyph38 = 16'd38; // Yellow Corner Left Up
localparam glyph39 = 16'd39; // Yellow Corner Right Down
localparam glyph40 = 16'd40; // Yellow Corner Right Up

localparam glyph41 = 16'd41; // Yellow Bike Horizontal 1
localparam glyph42 = 16'd42; // Yellow Bike Horizontal 2
localparam glyph43 = 16'd43; // Yellow Bike Horizontal 3
localparam glyph44 = 16'd44; // Yellow Bike Horizontal 4
localparam glyph45 = 16'd45; // Yellow Bike Horizontal 5
localparam glyph46 = 16'd46; // Yellow Bike Horizontal 6
localparam glyph47 = 16'd47; // Yellow Bike Horizontal 7
localparam glyph48 = 16'd48; // Yellow Bike Horizontal 8
localparam glyph49 = 16'd49; // Yellow Bike Horizontal 9

localparam glyph51 = 16'd51; // Yellow Bike Vertical 1
localparam glyph52 = 16'd52; // Yellow Bike Vertical 2
localparam glyph53 = 16'd53; // Yellow Bike Vertical 3
localparam glyph54 = 16'd54; // Yellow Bike Vertical 4
localparam glyph55 = 16'd55; // Yellow Bike Vertical 5
localparam glyph56 = 16'd56; // Yellow Bike Vertical 6
localparam glyph57 = 16'd57; // Yellow Bike Vertical 7
localparam glyph58 = 16'd58; // Yellow Bike Vertical 8
localparam glyph59 = 16'd59; // Yellow Bike Vertical 9

always @(*) begin
	if (bright) begin
		case (memData)
			// Black Square
			glyph0: begin
				VGA_R <= 8'd0;
				VGA_G <= 8'd0;
				VGA_B <= 8'd0;
			end
			
			// Blue Square
			glyph1: begin
				VGA_R <= 8'd0;
				VGA_G <= 8'd0;
				VGA_B <= 8'd255;
			end
			
			// Yellow Square
			glyph2: begin
				VGA_R <= 8'd255;
				VGA_G <= 8'd255;
				VGA_B <= 8'd0;
			end
			
			// Blue Horizontal Path
			glyph3: begin
				case (pixelPosition)
					// Outer Edge
					16'd0, 16'd1, 16'd2, 16'd3, 16'd12, 16'd13, 16'd14, 16'd15: begin
						VGA_R <= 8'd0;
						VGA_G <= 8'd162;
						VGA_B <= 8'd230;
					end
					
					// Inner
					16'd4, 16'd5, 16'd6, 16'd7, 16'd8, 16'd9, 16'd10, 16'd11: begin
						VGA_R <= 8'd156;
						VGA_G <= 8'd219;
						VGA_B <= 8'd230;
					end
					
					// Should never happen
					default: begin
						VGA_R <= 8'd0;
						VGA_G <= 8'd0;
						VGA_B <= 8'd0;
					end
				endcase
			end
			
			// Blue Vertical Path
			glyph4: begin
				case (pixelPosition)
					// Outer Edge
					16'd0, 16'd3, 16'd4, 16'd7, 16'd8, 16'd11, 16'd12, 16'd15: begin
						VGA_R <= 8'd0;
						VGA_G <= 8'd162;
						VGA_B <= 8'd230;
					end
					
					// Inner
					16'd1, 16'd2, 16'd5, 16'd6, 16'd9, 16'd10, 16'd13, 16'd14: begin
						VGA_R <= 8'd156;
						VGA_G <= 8'd219;
						VGA_B <= 8'd230;
					end
					
					// Should never happen
					default: begin
						VGA_R <= 8'd0;
						VGA_G <= 8'd0;
						VGA_B <= 8'd0;
					end
				endcase
			end
			
			// Blue Generic Corner Path
			glyph5: begin
				case (pixelPosition)
					// Outer Edge
					16'd0, 16'd1, 16'd2, 16'd3, 16'd4, 16'd7, 16'd8, 16'd11, 16'd12, 16'd13, 16'd14, 16'd15: begin
						VGA_R <= 8'd0;
						VGA_G <= 8'd162;
						VGA_B <= 8'd230;
					end
					
					// Inner
					16'd5, 16'd6, 16'd9, 16'd10: begin
						VGA_R <= 8'd156;
						VGA_G <= 8'd219;
						VGA_B <= 8'd230;
					end
					
					// Should never happen
					default: begin
						VGA_R <= 8'd0;
						VGA_G <= 8'd0;
						VGA_B <= 8'd0;
					end
				endcase
			end
			
			// Blue Corner Left Down
			glyph5: begin
				case (pixelPosition)
					// Outer Edge
					16'd0, 16'd1, 16'd2, 16'd3, 16'd7, 16'd11, 16'd12, 16'd15: begin
						VGA_R <= 8'd0;
						VGA_G <= 8'd162;
						VGA_B <= 8'd230;
					end
					
					// Inner
					16'd4, 16'd5, 16'd6, 16'd8, 16'd9, 16'd10: begin
						VGA_R <= 8'd156;
						VGA_G <= 8'd219;
						VGA_B <= 8'd230;
					end
					
					// Should never happen
					default: begin
						VGA_R <= 8'd0;
						VGA_G <= 8'd0;
						VGA_B <= 8'd0;
					end
				endcase
			end
			
			
			// Should not happen.
			default: begin
				VGA_R <= 8'd0;
				VGA_G <= 8'd0;
				VGA_B <= 8'd0;
			end
		endcase
	end else begin
		VGA_R <= 8'd0;
		VGA_G <= 8'd0;
		VGA_B <= 8'd0;
	end
end

assign pixelPosition = hCount % 16'd4 + (vCount % 16'd4) * 16'd4;
assign memAddress = 16'd40000 + {2'b0, hCount[15:2]} + vCount * 16'd160;

endmodule
