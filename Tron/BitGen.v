/*

*/
module BitGen (
input bright,
input [15:0] hCount,
input [15:0] vCount,

output [15:0] memAddress,	// To exmem addr2
input [15:0] memData,      // dataOut 2

output reg[7:0] VGA_R,
output reg[7:0] VGA_G,
output reg[7:0] VGA_B
);

wire [15:0] pixelPosition;

assign pixelPosition = (hCount & 16'd3) + ((vCount & 16'd3) << 2);
assign memAddress = 16'd40000 + {2'b0, hCount[15:2]} + ({2'b0, vCount[15:2]} * 16'd160);

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

localparam glyph10 = 16'd10; // Blue Bike Horizontal 1
localparam glyph11 = 16'd11; // Blue Bike Horizontal 2
localparam glyph12 = 16'd12; // Blue Bike Horizontal 3
localparam glyph13 = 16'd13; // Blue Bike Horizontal 4
localparam glyph14 = 16'd14; // Blue Bike Horizontal 5
localparam glyph15 = 16'd15; // Blue Bike Horizontal 6
localparam glyph16 = 16'd16; // Blue Bike Horizontal 7
localparam glyph17 = 16'd17; // Blue Bike Horizontal 8
localparam glyph18 = 16'd18; // Blue Bike Horizontal 9

localparam glyph19 = 16'd19; // Blue Bike Vertical 1
localparam glyph20 = 16'd20; // Blue Bike Vertical 2
localparam glyph21 = 16'd21; // Blue Bike Vertical 3
localparam glyph22 = 16'd22; // Blue Bike Vertical 4
localparam glyph23 = 16'd23; // Blue Bike Vertical 5
localparam glyph24 = 16'd24; // Blue Bike Vertical 6
localparam glyph25 = 16'd25; // Blue Bike Vertical 7
localparam glyph26 = 16'd26; // Blue Bike Vertical 8
localparam glyph27 = 16'd27; // Blue Bike Vertical 9

localparam glyph28 = 16'd28; // Yellow Horizontal Path
localparam glyph29 = 16'd29; // Yellow Vertical Path
localparam glyph30 = 16'd30; // Yellow Generic Corner Path

localparam glyph31 = 16'd31; // Yellow Corner Left Down
localparam glyph32 = 16'd32; // Yellow Corner Left Up
localparam glyph33 = 16'd33; // Yellow Corner Right Down
localparam glyph34 = 16'd34; // Yellow Corner Right Up

localparam glyph35 = 16'd35; // Yellow Bike Horizontal 1
localparam glyph36 = 16'd36; // Yellow Bike Horizontal 2
localparam glyph37 = 16'd37; // Yellow Bike Horizontal 3
localparam glyph38 = 16'd38; // Yellow Bike Horizontal 4
localparam glyph39 = 16'd39; // Yellow Bike Horizontal 5
localparam glyph40 = 16'd40; // Yellow Bike Horizontal 6
localparam glyph41 = 16'd41; // Yellow Bike Horizontal 7
localparam glyph42 = 16'd42; // Yellow Bike Horizontal 8
localparam glyph43 = 16'd43; // Yellow Bike Horizontal 9

localparam glyph44 = 16'd44; // Yellow Bike Vertical 1
localparam glyph45 = 16'd45; // Yellow Bike Vertical 2
localparam glyph46 = 16'd46; // Yellow Bike Vertical 3
localparam glyph47 = 16'd47; // Yellow Bike Vertical 4
localparam glyph48 = 16'd48; // Yellow Bike Vertical 5
localparam glyph49 = 16'd49; // Yellow Bike Vertical 6
localparam glyph50 = 16'd50; // Yellow Bike Vertical 7
localparam glyph51 = 16'd51; // Yellow Bike Vertical 8
localparam glyph52 = 16'd52; // Yellow Bike Vertical 9

localparam glyph53 = 16'd53; // White Square

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
			glyph6: begin
				case (pixelPosition)
					// Outer Edge
					16'd0, 16'd1, 16'd2, 16'd3, 16'd7, 16'd11, 16'd12, 16'd15: begin
						VGA_R <= 8'd0;
						VGA_G <= 8'd162;
						VGA_B <= 8'd230;
					end
					
					// Inner
					16'd4, 16'd5, 16'd6, 16'd8, 16'd9, 16'd10, 16'd13, 16'd14: begin
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
			
			// Blue Corner Left Up
			glyph7: begin
				case (pixelPosition)
					// Outer Edge
					16'd0, 16'd3, 16'd7, 16'd11, 16'd12, 16'd13, 16'd14, 16'd15: begin
						VGA_R <= 8'd0;
						VGA_G <= 8'd162;
						VGA_B <= 8'd230;
					end
					
					// Inner
					16'd1, 16'd2, 16'd4, 16'd5, 16'd6, 16'd8, 16'd9, 16'd10: begin
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
			
			// Blue Corner Right Down
			glyph8: begin
				case (pixelPosition)
					// Outer Edge
					16'd0, 16'd1, 16'd2, 16'd3, 16'd4, 16'd8, 16'd12, 16'd15: begin
						VGA_R <= 8'd0;
						VGA_G <= 8'd162;
						VGA_B <= 8'd230;
					end
					
					// Inner
					 16'd5, 16'd6, 16'd7, 16'd9, 16'd10, 16'd11, 16'd13, 16'd14: begin
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
			
			// Blue Corner Right UP
			glyph9: begin
				case (pixelPosition)
					// Outer Edge
					16'd0, 16'd3, 16'd4, 16'd8, 16'd12, 16'd13, 16'd14, 16'd15: begin
						VGA_R <= 8'd0;
						VGA_G <= 8'd162;
						VGA_B <= 8'd230;
					end
					
					// Inner
					 16'd1, 16'd2, 16'd5, 16'd6, 16'd7, 16'd9, 16'd10, 16'd11: begin
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
			
			// Blue Bike Horizontal 1
			glyph10: begin
				case (pixelPosition)
					// Background
					16'd0, 16'd1, 16'd2, 16'd3, 16'd4, 16'd5, 16'd6, 16'd7, 16'd8, 16'd12: begin
						VGA_R <= 8'd0;
						VGA_G <= 8'd0;
						VGA_B <= 8'd0;
					end
					
					// Blue Portion of Bike
					 16'd9, 16'd10, 16'd11, 16'd13, 16'd14, 16'd15: begin
						VGA_R <= 8'd0;
						VGA_G <= 8'd0;
						VGA_B <= 8'd255;
					end
					
					// Should never happen
					default: begin
						VGA_R <= 8'd0;
						VGA_G <= 8'd0;
						VGA_B <= 8'd0;
					end
				endcase
			end
			
			// Blue Bike Horizontal 2
			glyph11: begin
				case (pixelPosition)
					// Background
					16'd0, 16'd1, 16'd2, 16'd3, 16'd4, 16'd5, 16'd6, 16'd7: begin
						VGA_R <= 8'd0;
						VGA_G <= 8'd0;
						VGA_B <= 8'd0;
					end
					
					// Blue Portion of Bike
					 16'd8, 16'd9, 16'd10, 16'd11, 16'd12, 16'd13, 16'd14, 16'd15: begin
						VGA_R <= 8'd0;
						VGA_G <= 8'd0;
						VGA_B <= 8'd255;
					end
					
					// Should never happen
					default: begin
						VGA_R <= 8'd0;
						VGA_G <= 8'd0;
						VGA_B <= 8'd0;
					end
				endcase
			end
			
			// Blue Bike Horizontal 3
			glyph12: begin
				case (pixelPosition)
					// Background
					16'd0, 16'd1, 16'd2, 16'd3, 16'd4, 16'd5, 16'd6, 16'd7, 16'd11, 16'd15: begin
						VGA_R <= 8'd0;
						VGA_G <= 8'd0;
						VGA_B <= 8'd0;
					end
					
					// Blue Portion of Bike
					16'd8, 16'd9, 16'd10, 16'd12, 16'd13, 16'd14: begin
						VGA_R <= 8'd0;
						VGA_G <= 8'd0;
						VGA_B <= 8'd255;
					end
					
					// Should never happen
					default: begin
						VGA_R <= 8'd0;
						VGA_G <= 8'd0;
						VGA_B <= 8'd0;
					end
				endcase
			end
			
			// Blue Bike Horizontal 4
			glyph13: begin
				case (pixelPosition)
					// Tire
					16'd0, 16'd1, 16'd2, 16'd4, 16'd5, 16'd6, 16'd8, 16'd9, 16'd10, 16'd12, 16'd13, 16'd14: begin
						VGA_R <= 8'd127;
						VGA_G <= 8'd127;
						VGA_B <= 8'd127;
					end
					
					// Blue Portion of Bike
					16'd3, 16'd7, 16'd11, 16'd15: begin
						VGA_R <= 8'd0;
						VGA_G <= 8'd0;
						VGA_B <= 8'd255;
					end
					
					// Should never happen
					default: begin
						VGA_R <= 8'd0;
						VGA_G <= 8'd0;
						VGA_B <= 8'd0;
					end
				endcase
			end
			
			// Blue Bike Horizontal 5
			glyph14: begin
				case (pixelPosition)
					// Gray
					16'd4, 16'd5, 16'd6, 16'd7, 16'd8, 16'd9, 16'd10, 16'd11: begin
						VGA_R <= 8'd127;
						VGA_G <= 8'd127;
						VGA_B <= 8'd127;
					end
					
					// Blue Portion of Bike
					16'd0, 16'd1, 16'd2, 16'd3, 16'd12, 16'd13, 16'd14, 16'd15: begin
						VGA_R <= 8'd0;
						VGA_G <= 8'd0;
						VGA_B <= 8'd255;
					end
					
					// Should never happen
					default: begin
						VGA_R <= 8'd0;
						VGA_G <= 8'd0;
						VGA_B <= 8'd0;
					end
				endcase
			end
			
			// Blue Bike Horizontal 6
			glyph15: begin
				case (pixelPosition)
					// Tire
					 16'd1, 16'd2, 16'd3,  16'd5, 16'd6, 16'd7,  16'd9, 16'd10, 16'd11, 16'd13, 16'd14, 16'd15: begin
						VGA_R <= 8'd127;
						VGA_G <= 8'd127;
						VGA_B <= 8'd127;
					end
					
					// Blue Portion of Bike
					   16'd0, 16'd4, 16'd8, 16'd12: begin
						VGA_R <= 8'd0;
						VGA_G <= 8'd0;
						VGA_B <= 8'd255;
					end
					
					// Should never happen
					default: begin
						VGA_R <= 8'd0;
						VGA_G <= 8'd0;
						VGA_B <= 8'd0;
					end
				endcase
			end
			
			// Blue Bike Horizontal 7
			glyph16: begin
				case (pixelPosition)
					// Background
					16'd0, 16'd4, 16'd8, 16'd9, 16'd10, 16'd11, 16'd12, 16'd13, 16'd14, 16'd15: begin
						VGA_R <= 8'd0;
						VGA_G <= 8'd0;
						VGA_B <= 8'd0;
					end
					
					// Blue Portion of Bike
					16'd1, 16'd2, 16'd3, 16'd5, 16'd6, 16'd7: begin
						VGA_R <= 8'd0;
						VGA_G <= 8'd0;
						VGA_B <= 8'd255;
					end
					
					// Should never happen
					default: begin
						VGA_R <= 8'd0;
						VGA_G <= 8'd0;
						VGA_B <= 8'd0;
					end
				endcase
			end
			
			// Blue Bike Horizontal 8
			glyph17: begin
				case (pixelPosition)
					// Background
					16'd8, 16'd9, 16'd10, 16'd11, 16'd12, 16'd13, 16'd14, 16'd15: begin
						VGA_R <= 8'd0;
						VGA_G <= 8'd0;
						VGA_B <= 8'd0;
					end
					
					// Blue Portion of Bike
					16'd0, 16'd1, 16'd2, 16'd3, 16'd4, 16'd5, 16'd6, 16'd7: begin
						VGA_R <= 8'd0;
						VGA_G <= 8'd0;
						VGA_B <= 8'd255;
					end
					
					// Should never happen
					default: begin
						VGA_R <= 8'd0;
						VGA_G <= 8'd0;
						VGA_B <= 8'd0;
					end
				endcase
			end
			
			// Blue Bike Horizontal 9
			glyph18: begin
				case (pixelPosition)
					// Background
					16'd3, 16'd7, 16'd8, 16'd9, 16'd10, 16'd11, 16'd12, 16'd13, 16'd14, 16'd15: begin
						VGA_R <= 8'd0;
						VGA_G <= 8'd0;
						VGA_B <= 8'd0;
					end
					
					// Blue Portion of Bike
					16'd0, 16'd1, 16'd2, 16'd4, 16'd5, 16'd6: begin
						VGA_R <= 8'd0;
						VGA_G <= 8'd0;
						VGA_B <= 8'd255;
					end
					
					// Should never happen
					default: begin
						VGA_R <= 8'd0;
						VGA_G <= 8'd0;
						VGA_B <= 8'd0;
					end
				endcase
			end
			
			// Blue Bike Vertical 1
			glyph19: begin
				case (pixelPosition)
					// Background
					16'd0, 16'd1, 16'd2, 16'd3, 16'd4, 16'd5, 16'd8, 16'd9, 16'd12, 16'd13: begin
						VGA_R <= 8'd0;
						VGA_G <= 8'd0;
						VGA_B <= 8'd0;
					end
					
					// Blue Portion of Bike
					 16'd6, 16'd7, 16'd10, 16'd11, 16'd14, 16'd15: begin
						VGA_R <= 8'd0;
						VGA_G <= 8'd0;
						VGA_B <= 8'd255;
					end
					
					// Should never happen
					default: begin
						VGA_R <= 8'd0;
						VGA_G <= 8'd0;
						VGA_B <= 8'd0;
					end
				endcase
			end
			
			// Blue Bike Vertical 2
			glyph20: begin
				case (pixelPosition)
					// Tire
					16'd0, 16'd1, 16'd2, 16'd3, 16'd4, 16'd5, 16'd6, 16'd7, 16'd8, 16'd9, 16'd10, 16'd11: begin
						VGA_R <= 8'd127;
						VGA_G <= 8'd127;
						VGA_B <= 8'd127;
					end
					
					// Blue Portion of Bike
					16'd12, 16'd13, 16'd14, 16'd15: begin
						VGA_R <= 8'd0;
						VGA_G <= 8'd0;
						VGA_B <= 8'd255;
					end
					// Should never happen
					default: begin
						VGA_R <= 8'd0;
						VGA_G <= 8'd0;
						VGA_B <= 8'd0;
					end
				endcase
			end
			
			// Blue Bike Vertical 3
			glyph21: begin
				case (pixelPosition)
					// Background
					16'd0, 16'd1, 16'd2, 16'd3, 16'd6, 16'd7, 16'd10, 16'd11, 16'd14, 16'd15: begin
						VGA_R <= 8'd0;
						VGA_G <= 8'd0;
						VGA_B <= 8'd0;
					end
					
					// Blue Portion of Bike
					16'd4, 16'd5, 16'd8, 16'd9, 16'd12, 16'd13: begin
						VGA_R <= 8'd0;
						VGA_G <= 8'd0;
						VGA_B <= 8'd255;
					end
					
					// Should never happen
					default: begin
						VGA_R <= 8'd0;
						VGA_G <= 8'd0;
						VGA_B <= 8'd0;
					end
				endcase
			end
			
			// Blue Bike Vertical 4
			glyph22: begin
				case (pixelPosition)
					// Background
					16'd0, 16'd1, 16'd4, 16'd5, 16'd8, 16'd9, 16'd12, 16'd13: begin
						VGA_R <= 8'd0;
						VGA_G <= 8'd0;
						VGA_B <= 8'd0;
					end
					
					// Blue Portion of Bike
					 16'd2, 16'd3, 16'd6, 16'd7, 16'd10, 16'd11, 16'd14, 16'd15: begin
						VGA_R <= 8'd0;
						VGA_G <= 8'd0;
						VGA_B <= 8'd255;
					end
					
					// Should never happen
					default: begin
						VGA_R <= 8'd0;
						VGA_G <= 8'd0;
						VGA_B <= 8'd0;
					end
				endcase
			end
			
			// Blue Bike Vertical 5
			glyph23: begin
				case (pixelPosition)
					// Gray
					16'd1, 16'd2, 16'd5, 16'd6, 16'd9, 16'd10, 16'd13, 16'd14: begin
						VGA_R <= 8'd127;
						VGA_G <= 8'd127;
						VGA_B <= 8'd127;
					end
					
					// Blue Portion of Bike
					16'd0, 16'd3, 16'd4, 16'd7, 16'd8, 16'd11, 16'd12, 16'd15: begin
						VGA_R <= 8'd0;
						VGA_G <= 8'd0;
						VGA_B <= 8'd255;
					end
					
					// Should never happen
					default: begin
						VGA_R <= 8'd0;
						VGA_G <= 8'd0;
						VGA_B <= 8'd0;
					end
				endcase
			end
			
			// Blue Bike Vertical 6
			glyph24: begin
				case (pixelPosition)
					// Background
					16'd2, 16'd3, 16'd6, 16'd7, 16'd10, 16'd11, 16'd14, 16'd15: begin
						VGA_R <= 8'd0;
						VGA_G <= 8'd0;
						VGA_B <= 8'd0;
					end
					
					// Blue Portion of Bike
					16'd0, 16'd1, 16'd4, 16'd5, 16'd8, 16'd9, 16'd12, 16'd13: begin
						VGA_R <= 8'd0;
						VGA_G <= 8'd0;
						VGA_B <= 8'd255;
					end
					
					// Should never happen
					default: begin
						VGA_R <= 8'd0;
						VGA_G <= 8'd0;
						VGA_B <= 8'd0;
					end
				endcase
			end
			
			// Blue Bike Vertical 7
			glyph25: begin
				case (pixelPosition)
					// Background
					16'd0, 16'd1, 16'd4, 16'd5, 16'd8, 16'd9, 16'd12, 16'd13, 16'd14, 16'd15: begin
						VGA_R <= 8'd0;
						VGA_G <= 8'd0;
						VGA_B <= 8'd0;
					end
					
					// Blue Portion of Bike
					16'd2, 16'd3, 16'd6, 16'd7, 16'd10, 16'd11: begin
						VGA_R <= 8'd0;
						VGA_G <= 8'd0;
						VGA_B <= 8'd255;
					end
					
					// Should never happen
					default: begin
						VGA_R <= 8'd0;
						VGA_G <= 8'd0;
						VGA_B <= 8'd0;
					end
				endcase
			end
			
			// Blue Bike Vertical 8
			glyph26: begin
				case (pixelPosition)
					// Tire
					 16'd4, 16'd5, 16'd6,  16'd7, 16'd8, 16'd9, 16'd10, 16'd11, 16'd12, 16'd13, 16'd14, 16'd15: begin
						VGA_R <= 8'd127;
						VGA_G <= 8'd127;
						VGA_B <= 8'd127;
					end
					
					// Blue Portion of Bike
					   16'd0, 16'd1, 16'd2, 16'd3: begin
						VGA_R <= 8'd0;
						VGA_G <= 8'd0;
						VGA_B <= 8'd255;
					end
					
					// Should never happen
					default: begin
						VGA_R <= 8'd0;
						VGA_G <= 8'd0;
						VGA_B <= 8'd0;
					end
				endcase
			end
			
			// Blue Bike Vertical 9
			glyph27: begin
				case (pixelPosition)
					// Background
					16'd2, 16'd3, 16'd6, 16'd7, 16'd10, 16'd11, 16'd12, 16'd13, 16'd14, 16'd15: begin
						VGA_R <= 8'd0;
						VGA_G <= 8'd0;
						VGA_B <= 8'd0;
					end
					
					// Blue Portion of Bike
					16'd0, 16'd1, 16'd4, 16'd5, 16'd8, 16'd9: begin
						VGA_R <= 8'd0;
						VGA_G <= 8'd0;
						VGA_B <= 8'd255;
					end
					
					// Should never happen
					default: begin
						VGA_R <= 8'd0;
						VGA_G <= 8'd0;
						VGA_B <= 8'd0;
					end
				endcase
			end
			
			// Yellow Horizontal Path
			glyph28: begin
				case (pixelPosition)
					// Outer Edge
					16'd0, 16'd1, 16'd2, 16'd3, 16'd12, 16'd13, 16'd14, 16'd15: begin
						VGA_R <= 8'd255;
						VGA_G <= 8'd201;
						VGA_B <= 8'd14;
					end
					
					// Inner
					16'd4, 16'd5, 16'd6, 16'd7, 16'd8, 16'd9, 16'd10, 16'd11: begin
						VGA_R <= 8'd255;
						VGA_G <= 8'd254;
						VGA_B <= 8'd145;
					end
					
					// Should never happen
					default: begin
						VGA_R <= 8'd0;
						VGA_G <= 8'd0;
						VGA_B <= 8'd0;
					end
				endcase
			end
			
			// Yellow Vertical Path
			glyph29: begin
				case (pixelPosition)
					// Outer Edge
					16'd0, 16'd3, 16'd4, 16'd7, 16'd8, 16'd11, 16'd12, 16'd15: begin
						VGA_R <= 8'd255;
						VGA_G <= 8'd201;
						VGA_B <= 8'd14;
					end
					
					// Inner
					16'd1, 16'd2, 16'd5, 16'd6, 16'd9, 16'd10, 16'd13, 16'd14: begin
						VGA_R <= 8'd255;
						VGA_G <= 8'd254;
						VGA_B <= 8'd145;
					end
					
					// Should never happen
					default: begin
						VGA_R <= 8'd0;
						VGA_G <= 8'd0;
						VGA_B <= 8'd0;
					end
				endcase
			end
			
			// Yellow Generic Corner Path
			glyph30: begin
				case (pixelPosition)
					// Outer Edge
					16'd0, 16'd1, 16'd2, 16'd3, 16'd4, 16'd7, 16'd8, 16'd11, 16'd12, 16'd13, 16'd14, 16'd15: begin
						VGA_R <= 8'd255;
						VGA_G <= 8'd201;
						VGA_B <= 8'd14;
					end
					
					// Inner
					16'd5, 16'd6, 16'd9, 16'd10: begin
						VGA_R <= 8'd255;
						VGA_G <= 8'd254;
						VGA_B <= 8'd145;
					end
					
					// Should never happen
					default: begin
						VGA_R <= 8'd0;
						VGA_G <= 8'd0;
						VGA_B <= 8'd0;
					end
				endcase
			end
			
			// Yellow Corner Left Down
			glyph31: begin
				case (pixelPosition)
					// Outer Edge
					16'd0, 16'd1, 16'd2, 16'd3, 16'd7, 16'd11, 16'd12, 16'd15: begin
						VGA_R <= 8'd255;
						VGA_G <= 8'd201;
						VGA_B <= 8'd14;
					end
					
					// Inner
					16'd4, 16'd5, 16'd6, 16'd8, 16'd9, 16'd10, 16'd13, 16'd14: begin
						VGA_R <= 8'd255;
						VGA_G <= 8'd254;
						VGA_B <= 8'd145;
					end
					
					// Should never happen
					default: begin
						VGA_R <= 8'd0;
						VGA_G <= 8'd0;
						VGA_B <= 8'd0;
					end
				endcase
			end
			
			// Yellow Corner Left Up
			glyph32: begin
				case (pixelPosition)
					// Outer Edge
					16'd0, 16'd3, 16'd7, 16'd11, 16'd12, 16'd13, 16'd14, 16'd15: begin
						VGA_R <= 8'd255;
						VGA_G <= 8'd201;
						VGA_B <= 8'd14;
					end
					
					// Inner
					16'd1, 16'd2, 16'd4, 16'd5, 16'd6, 16'd8, 16'd9, 16'd10: begin
						VGA_R <= 8'd255;
						VGA_G <= 8'd254;
						VGA_B <= 8'd145;
					end
					
					// Should never happen
					default: begin
						VGA_R <= 8'd0;
						VGA_G <= 8'd0;
						VGA_B <= 8'd0;
					end
				endcase
			end
			
			// Yellow Corner Right Down
			glyph33: begin
				case (pixelPosition)
					// Outer Edge
					16'd0, 16'd1, 16'd2, 16'd3, 16'd4, 16'd8, 16'd12, 16'd15: begin
						VGA_R <= 8'd255;
						VGA_G <= 8'd201;
						VGA_B <= 8'd14;
					end
					
					// Inner
					 16'd5, 16'd6, 16'd7, 16'd9, 16'd10, 16'd11, 16'd13, 16'd14: begin
						VGA_R <= 8'd255;
						VGA_G <= 8'd254;
						VGA_B <= 8'd145;
					end
					
					// Should never happen
					default: begin
						VGA_R <= 8'd0;
						VGA_G <= 8'd0;
						VGA_B <= 8'd0;
					end
				endcase
			end
			
			// Yellow Corner Right UP
			glyph34: begin
				case (pixelPosition)
					// Outer Edge
					16'd0, 16'd3, 16'd4, 16'd8, 16'd12, 16'd13, 16'd14, 16'd15: begin
						VGA_R <= 8'd255;
						VGA_G <= 8'd201;
						VGA_B <= 8'd14;
					end
					
					// Inner
					 16'd1, 16'd2, 16'd5, 16'd6, 16'd7, 16'd9, 16'd10, 16'd11: begin
						VGA_R <= 8'd255;
						VGA_G <= 8'd254;
						VGA_B <= 8'd145;
					end
					
					// Should never happen
					default: begin
						VGA_R <= 8'd0;
						VGA_G <= 8'd0;
						VGA_B <= 8'd0;
					end
				endcase
			end
			
			// Yellow Bike Horizontal 1
			glyph35: begin
				case (pixelPosition)
					// Background
					16'd0, 16'd1, 16'd2, 16'd3, 16'd4, 16'd5, 16'd6, 16'd7, 16'd8, 16'd12: begin
						VGA_R <= 8'd0;
						VGA_G <= 8'd0;
						VGA_B <= 8'd0;
					end
					
					// Yellow Portion of Bike
					 16'd9, 16'd10, 16'd11, 16'd13, 16'd14, 16'd15: begin
						VGA_R <= 8'd255;
						VGA_G <= 8'd255;
						VGA_B <= 8'd0;
					end
					
					// Should never happen
					default: begin
						VGA_R <= 8'd0;
						VGA_G <= 8'd0;
						VGA_B <= 8'd0;
					end
				endcase
			end
			
			// Yellow Bike Horizontal 2
			glyph36: begin
				case (pixelPosition)
					// Background
					16'd0, 16'd1, 16'd2, 16'd3, 16'd4, 16'd5, 16'd6, 16'd7: begin
						VGA_R <= 8'd0;
						VGA_G <= 8'd0;
						VGA_B <= 8'd0;
					end
					
					// Yellow Portion of Bike
					 16'd8, 16'd9, 16'd10, 16'd11, 16'd12, 16'd13, 16'd14, 16'd15: begin
						VGA_R <= 8'd255;
						VGA_G <= 8'd255;
						VGA_B <= 8'd0;
					end
					
					// Should never happen
					default: begin
						VGA_R <= 8'd0;
						VGA_G <= 8'd0;
						VGA_B <= 8'd0;
					end
				endcase
			end
			
			// Yellow Bike Horizontal 3
			glyph37: begin
				case (pixelPosition)
					// Background
					16'd0, 16'd1, 16'd2, 16'd3, 16'd4, 16'd5, 16'd6, 16'd7, 16'd11, 16'd15: begin
						VGA_R <= 8'd0;
						VGA_G <= 8'd0;
						VGA_B <= 8'd0;
					end
					
					// Yellow Portion of Bike
					16'd8, 16'd9, 16'd10, 16'd12, 16'd13, 16'd14: begin
						VGA_R <= 8'd255;
						VGA_G <= 8'd255;
						VGA_B <= 8'd0;
					end
					
					// Should never happen
					default: begin
						VGA_R <= 8'd0;
						VGA_G <= 8'd0;
						VGA_B <= 8'd0;
					end
				endcase
			end
			
			// Yellow Bike Horizontal 4
			glyph38: begin
				case (pixelPosition)
					// Tire
					16'd0, 16'd1, 16'd2, 16'd4, 16'd5, 16'd6, 16'd8, 16'd9, 16'd10, 16'd12, 16'd13, 16'd14: begin
						VGA_R <= 8'd127;
						VGA_G <= 8'd127;
						VGA_B <= 8'd127;
					end
					
					// Yellow Portion of Bike
					16'd3, 16'd7, 16'd11, 16'd15: begin
						VGA_R <= 8'd255;
						VGA_G <= 8'd255;
						VGA_B <= 8'd0;
					end
					
					// Should never happen
					default: begin
						VGA_R <= 8'd0;
						VGA_G <= 8'd0;
						VGA_B <= 8'd0;
					end
				endcase
			end
			
			// Yellow Bike Horizontal 5
			glyph39: begin
				case (pixelPosition)
					// Gray
					16'd4, 16'd5, 16'd6, 16'd7, 16'd8, 16'd9, 16'd10, 16'd11: begin
						VGA_R <= 8'd127;
						VGA_G <= 8'd127;
						VGA_B <= 8'd127;
					end
					
					// Yellow Portion of Bike
					16'd0, 16'd1, 16'd2, 16'd3, 16'd12, 16'd13, 16'd14, 16'd15: begin
						VGA_R <= 8'd255;
						VGA_G <= 8'd255;
						VGA_B <= 8'd0;
					end
					
					// Should never happen
					default: begin
						VGA_R <= 8'd0;
						VGA_G <= 8'd0;
						VGA_B <= 8'd0;
					end
				endcase
			end
			
			// Yellow Bike Horizontal 6
			glyph40: begin
				case (pixelPosition)
					// Tire
					 16'd1, 16'd2, 16'd3,  16'd5, 16'd6, 16'd7,  16'd9, 16'd10, 16'd11, 16'd13, 16'd14, 16'd15: begin
						VGA_R <= 8'd127;
						VGA_G <= 8'd127;
						VGA_B <= 8'd127;
					end
					
					// Yellow Portion of Bike
					   16'd0, 16'd4, 16'd8, 16'd12: begin
						VGA_R <= 8'd255;
						VGA_G <= 8'd255;
						VGA_B <= 8'd0;
					end
					
					// Should never happen
					default: begin
						VGA_R <= 8'd0;
						VGA_G <= 8'd0;
						VGA_B <= 8'd0;
					end
				endcase
			end
			
			// Yellow Bike Horizontal 7
			glyph41: begin
				case (pixelPosition)
					// Background
					16'd0, 16'd4, 16'd8, 16'd9, 16'd10, 16'd11, 16'd12, 16'd13, 16'd14, 16'd15: begin
						VGA_R <= 8'd0;
						VGA_G <= 8'd0;
						VGA_B <= 8'd0;
					end
					
					// Yellow Portion of Bike
					16'd1, 16'd2, 16'd3, 16'd5, 16'd6, 16'd7: begin
						VGA_R <= 8'd255;
						VGA_G <= 8'd255;
						VGA_B <= 8'd0;
					end
					
					// Should never happen
					default: begin
						VGA_R <= 8'd0;
						VGA_G <= 8'd0;
						VGA_B <= 8'd0;
					end
				endcase
			end
			
			// Yellow Bike Horizontal 8
			glyph42: begin
				case (pixelPosition)
					// Background
					16'd8, 16'd9, 16'd10, 16'd11, 16'd12, 16'd13, 16'd14, 16'd15: begin
						VGA_R <= 8'd0;
						VGA_G <= 8'd0;
						VGA_B <= 8'd0;
					end
					
					// Yellow Portion of Bike
					16'd0, 16'd1, 16'd2, 16'd3, 16'd4, 16'd5, 16'd6, 16'd7: begin
						VGA_R <= 8'd255;
						VGA_G <= 8'd255;
						VGA_B <= 8'd0;
					end
					
					// Should never happen
					default: begin
						VGA_R <= 8'd0;
						VGA_G <= 8'd0;
						VGA_B <= 8'd0;
					end
				endcase
			end
			
			// Yellow Bike Horizontal 9
			glyph43: begin
				case (pixelPosition)
					// Background
					16'd3, 16'd7, 16'd8, 16'd9, 16'd10, 16'd11, 16'd12, 16'd13, 16'd14, 16'd15: begin
						VGA_R <= 8'd0;
						VGA_G <= 8'd0;
						VGA_B <= 8'd0;
					end
					
					// Yellow Portion of Bike
					16'd0, 16'd1, 16'd2, 16'd4, 16'd5, 16'd6: begin
						VGA_R <= 8'd255;
						VGA_G <= 8'd255;
						VGA_B <= 8'd0;
					end
					
					// Should never happen
					default: begin
						VGA_R <= 8'd0;
						VGA_G <= 8'd0;
						VGA_B <= 8'd0;
					end
				endcase
			end
			
			// Yellow Bike Vertical 1
			glyph44: begin
				case (pixelPosition)
					// Background
					16'd0, 16'd1, 16'd2, 16'd3, 16'd4, 16'd5, 16'd8, 16'd9, 16'd12, 16'd13: begin
						VGA_R <= 8'd0;
						VGA_G <= 8'd0;
						VGA_B <= 8'd0;
					end
					
					// Yellow Portion of Bike
					 16'd6, 16'd7, 16'd10, 16'd11, 16'd14, 16'd15: begin
						VGA_R <= 8'd255;
						VGA_G <= 8'd255;
						VGA_B <= 8'd0;
					end
					
					// Should never happen
					default: begin
						VGA_R <= 8'd0;
						VGA_G <= 8'd0;
						VGA_B <= 8'd0;
					end
				endcase
			end
			
			// Yellow Bike Vertical 2
			glyph45: begin
				case (pixelPosition)
					// Tire
					16'd0, 16'd1, 16'd2, 16'd3, 16'd4, 16'd5, 16'd6, 16'd7, 16'd8, 16'd9, 16'd10, 16'd11: begin
						VGA_R <= 8'd127;
						VGA_G <= 8'd127;
						VGA_B <= 8'd127;
					end
					
					// Yellow Portion of Bike
					16'd12, 16'd13, 16'd14, 16'd15: begin
						VGA_R <= 8'd255;
						VGA_G <= 8'd255;
						VGA_B <= 8'd0;
					end
					// Should never happen
					default: begin
						VGA_R <= 8'd0;
						VGA_G <= 8'd0;
						VGA_B <= 8'd0;
					end
				endcase
			end
			
			// Yellow Bike Vertical 3
			glyph46: begin
				case (pixelPosition)
					// Background
					16'd0, 16'd1, 16'd2, 16'd3, 16'd6, 16'd7, 16'd10, 16'd11, 16'd14, 16'd15: begin
						VGA_R <= 8'd0;
						VGA_G <= 8'd0;
						VGA_B <= 8'd0;
					end
					
					// Yellow Portion of Bike
					16'd4, 16'd5, 16'd8, 16'd9, 16'd12, 16'd13: begin
						VGA_R <= 8'd255;
						VGA_G <= 8'd255;
						VGA_B <= 8'd0;
					end
					
					// Should never happen
					default: begin
						VGA_R <= 8'd0;
						VGA_G <= 8'd0;
						VGA_B <= 8'd0;
					end
				endcase
			end
			
			// Yellow Bike Vertical 4
			glyph47: begin
				case (pixelPosition)
					// Background
					16'd0, 16'd1, 16'd4, 16'd5, 16'd8, 16'd9, 16'd12, 16'd13: begin
						VGA_R <= 8'd0;
						VGA_G <= 8'd0;
						VGA_B <= 8'd0;
					end
					
					// Yellow Portion of Bike
					 16'd2, 16'd3, 16'd6, 16'd7, 16'd10, 16'd11, 16'd14, 16'd15: begin
						VGA_R <= 8'd255;
						VGA_G <= 8'd255;
						VGA_B <= 8'd0;
					end
					
					// Should never happen
					default: begin
						VGA_R <= 8'd0;
						VGA_G <= 8'd0;
						VGA_B <= 8'd0;
					end
				endcase
			end
			
			// Yellow Bike Vertical 5
			glyph48: begin
				case (pixelPosition)
					// Gray
					16'd1, 16'd2, 16'd5, 16'd6, 16'd9, 16'd10, 16'd13, 16'd14: begin
						VGA_R <= 8'd127;
						VGA_G <= 8'd127;
						VGA_B <= 8'd127;
					end
					
					// Yellow Portion of Bike
					16'd0, 16'd3, 16'd4, 16'd7, 16'd8, 16'd11, 16'd12, 16'd15: begin
						VGA_R <= 8'd255;
						VGA_G <= 8'd255;
						VGA_B <= 8'd0;
					end
					
					// Should never happen
					default: begin
						VGA_R <= 8'd0;
						VGA_G <= 8'd0;
						VGA_B <= 8'd0;
					end
				endcase
			end
			
			// Yellow Bike Vertical 6
			glyph49: begin
				case (pixelPosition)
					// Background
					16'd2, 16'd3, 16'd6, 16'd7, 16'd10, 16'd11, 16'd14, 16'd15: begin
						VGA_R <= 8'd0;
						VGA_G <= 8'd0;
						VGA_B <= 8'd0;
					end
					
					// Yellow Portion of Bike
					16'd0, 16'd1, 16'd4, 16'd5, 16'd8, 16'd9, 16'd12, 16'd13: begin
						VGA_R <= 8'd255;
						VGA_G <= 8'd255;
						VGA_B <= 8'd0;
					end
					
					// Should never happen
					default: begin
						VGA_R <= 8'd0;
						VGA_G <= 8'd0;
						VGA_B <= 8'd0;
					end
				endcase
			end
			
			// Yellow Bike Vertical 7
			glyph50: begin
				case (pixelPosition)
					// Background
					16'd0, 16'd1, 16'd4, 16'd5, 16'd8, 16'd9, 16'd12, 16'd13, 16'd14, 16'd15: begin
						VGA_R <= 8'd0;
						VGA_G <= 8'd0;
						VGA_B <= 8'd0;
					end
					
					// Blue Portion of Bike
					16'd2, 16'd3, 16'd6, 16'd7, 16'd10, 16'd11: begin
						VGA_R <= 8'd255;
						VGA_G <= 8'd255;
						VGA_B <= 8'd0;
					end
					
					// Should never happen
					default: begin
						VGA_R <= 8'd0;
						VGA_G <= 8'd0;
						VGA_B <= 8'd0;
					end
				endcase
			end
			
			// Yellow Bike Vertical 8
			glyph51: begin
				case (pixelPosition)
					// Tire
					 16'd4, 16'd5, 16'd6,  16'd7, 16'd8, 16'd9, 16'd10, 16'd11, 16'd12, 16'd13, 16'd14, 16'd15: begin
						VGA_R <= 8'd127;
						VGA_G <= 8'd127;
						VGA_B <= 8'd127;
					end
					
					// Blue Portion of Bike
					   16'd0, 16'd1, 16'd2, 16'd3: begin
						VGA_R <= 8'd255;
						VGA_G <= 8'd255;
						VGA_B <= 8'd0;
					end
					
					// Should never happen
					default: begin
						VGA_R <= 8'd0;
						VGA_G <= 8'd0;
						VGA_B <= 8'd0;
					end
				endcase
			end
			
			// Yellow Bike Vertical 9
			glyph52: begin
				case (pixelPosition)
					// Background
					16'd2, 16'd3, 16'd6, 16'd7, 16'd10, 16'd11, 16'd12, 16'd13, 16'd14, 16'd15: begin
						VGA_R <= 8'd0;
						VGA_G <= 8'd0;
						VGA_B <= 8'd0;
					end
					
					// Yellow Portion of Bike
					16'd0, 16'd1, 16'd4, 16'd5, 16'd8, 16'd9: begin
						VGA_R <= 8'd255;
						VGA_G <= 8'd255;
						VGA_B <= 8'd0;
					end
					
					// Should never happen
					default: begin
						VGA_R <= 8'd0;
						VGA_G <= 8'd0;
						VGA_B <= 8'd0;
					end
				endcase
			end
			
			// White Square
			glyph53: begin
				VGA_R <= 8'd255;
				VGA_G <= 8'd255;
				VGA_B <= 8'd255;
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

endmodule
