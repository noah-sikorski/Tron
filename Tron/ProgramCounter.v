/*
This is the file that manages the control of the
program counter by incrementing it as needed and moving around.
*/
module ProgramCounter #(parameter WIDTH = 16) (
	 input reset,
	 input clk,

    input [3:0] flagOp,
	 input [4:0] flagRegister,
	 input [15:0] immediate,
	 input [15:0] rTarget,
	 
	 input pcAdd,
	 input pcJump,
	 input pcBranch,
	 
    output wire [WIDTH-1:0] addressOut
);

reg [15:0] pcAddress = 0;

assign addressOut = pcAddress;

localparam EQ = 4'b0000;
localparam NE = 4'b0001;
localparam CS = 4'b0010;
localparam CC = 4'b0011;
localparam HI = 4'b0100;
localparam LS = 4'b0101;
localparam GT = 4'b0110;
localparam LE = 4'b0111;
localparam FS = 4'b1000;
localparam FC = 4'b1001;
localparam LO = 4'b1010;
localparam HS = 4'b1011;
localparam LT = 4'b1100;
localparam GE = 4'b1101;
localparam UC = 4'b1110;
localparam JAL = 4'b1111;

always @(posedge clk) begin
	if (!reset) begin
		pcAddress <= 16'b0;
	// The case of just simply going to the next instruction.
	end else if (pcAdd) begin
		pcAddress <= pcAddress + 16'b1;
	// Branch the code if this bit is activated.
	end else if (pcBranch) begin
	  case (flagOp)
			EQ: begin
				if (flagRegister[3]) begin
					pcAddress <= pcAddress + immediate;
				end else begin
					pcAddress <= pcAddress + 16'b1;
				end
			end
			NE: begin
				if (!flagRegister[3]) begin
					pcAddress <= pcAddress + immediate;
				end else begin
					pcAddress <= pcAddress + 16'b1;
				end
			end
			CS: begin
				if (flagRegister[0]) begin
					pcAddress <= pcAddress + immediate;
				end else begin
					pcAddress <= pcAddress + 16'b1;
				end
			end
			CC: begin
				if (!flagRegister[0]) begin
					pcAddress <= pcAddress + immediate;
				end else begin
					pcAddress <= pcAddress + 16'b1;
				end
			end
			HI: begin
				if (flagRegister[1]) begin
					pcAddress <= pcAddress + immediate;
				end else begin
					pcAddress <= pcAddress + 16'b1;
				end
			end
			LS: begin
				if (!flagRegister[1]) begin
					pcAddress <= pcAddress + immediate;
				end else begin
					pcAddress <= pcAddress + 16'b1;
				end
			end
			GT: begin
				if (flagRegister[4]) begin
				   pcAddress <= pcAddress + immediate;
				end else begin
					pcAddress <= pcAddress + 16'b1;
				end
			end
			LE: begin
				if (!flagRegister[4]) begin
				   pcAddress <= pcAddress + immediate;
				end else begin
					pcAddress <= pcAddress + 16'b1;
				end
			end
			FS: begin
				if (flagRegister[2]) begin
					pcAddress <= pcAddress + immediate;
				end else begin
					pcAddress <= pcAddress + 16'b1;
				end
			end
			FC: begin
				if (!flagRegister[2]) begin
					pcAddress <= pcAddress + immediate;
				end else begin
					pcAddress <= pcAddress + 16'b1;
				end
			end
			LO: begin
				if (!flagRegister[1] && !flagRegister[3]) begin
					pcAddress <= pcAddress + immediate;
				end else begin
					pcAddress <= pcAddress + 16'b1;
				end
			end
			HS: begin
				if (flagRegister[1] || flagRegister[3]) begin
					pcAddress <= pcAddress + immediate;
				end else begin
					pcAddress <= pcAddress + 16'b1;
				end
			end
			LT: begin
				if (!flagRegister[3] && !flagRegister[4]) begin
					pcAddress <= pcAddress + immediate;
				end else begin
					pcAddress <= pcAddress + 16'b1;
				end
			end
			GE: begin
				if (flagRegister[3] || flagRegister[4]) begin
					pcAddress <= pcAddress + immediate;
				end else begin
					pcAddress <= pcAddress + 16'b1;
				end
			end
			UC: begin
				pcAddress <= pcAddress + immediate;
			end
			default: begin
				pcAddress <= pcAddress + 16'b1;
			end
		endcase
	// Jump the code if this bit is activated.
	end else if (pcJump) begin
		case (flagOp)
			EQ: begin
				if(flagRegister[3]) begin
					pcAddress <= rTarget;
				end else begin
					pcAddress <= pcAddress + 16'b1;
				end
			end
			NE: begin
				if(!flagRegister[3]) begin
					pcAddress <= rTarget;
				end else begin
					pcAddress <= pcAddress + 16'b1;
				end
			end
			CS: begin
				if(flagRegister[0]) begin
					pcAddress <= rTarget;
				end else begin
					pcAddress <= pcAddress + 16'b1;
				end
			end
			CC: begin
				if(!flagRegister[0]) begin
					pcAddress <= rTarget;
				end else begin
					pcAddress <= pcAddress + 16'b1;
				end
			end
			HI: begin
				if(flagRegister[1]) begin
					pcAddress <= rTarget;
				end else begin
					pcAddress <= pcAddress + 16'b1;
				end
			end
			LS: begin
				if(!flagRegister[1]) begin
					pcAddress <= rTarget;
				end else begin
					pcAddress <= pcAddress + 16'b1;
				end
			end
			GT: begin
				if(flagRegister[4]) begin
					pcAddress <= rTarget;
				end else begin
					pcAddress <= pcAddress + 16'b1;
				end
			end
			LE: begin
				if(!flagRegister[4]) begin
					pcAddress <= rTarget;
				end else begin
					pcAddress <= pcAddress + 16'b1;
				end
			end
			FS: begin
				if(flagRegister[2]) begin
					pcAddress <= rTarget;
				end else begin
					pcAddress <= pcAddress + 16'b1;
				end
			end
			FC: begin
				if(!flagRegister[2]) begin
					pcAddress <= rTarget;
				end else begin
					pcAddress <= pcAddress + 16'b1; 
				end
			end
			LO: begin
				if(!flagRegister[1] && !flagRegister[3]) begin
					pcAddress <= rTarget;
				end else begin
					pcAddress <= pcAddress + 16'b1;
				end
			end
			HS: begin
				if(flagRegister[1] || flagRegister[3]) begin
					pcAddress <= rTarget;
				end else begin
					pcAddress <= pcAddress + 16'b1;
				end
			end
			LT: begin
				if(!flagRegister[3] && !flagRegister[4]) begin
					pcAddress <= rTarget;
				end else begin
					pcAddress <= pcAddress + 16'b1;
				end
			end
			GE: begin
				if(flagRegister[3] || flagRegister[4]) begin
					pcAddress <= rTarget;
				end else begin
					pcAddress <= pcAddress + 16'b1;
				end
			end
			UC: begin
				pcAddress <= rTarget;
			end
			JAL: begin
				pcAddress <= rTarget;
			end
			default: begin
				pcAddress <= pcAddress + 16'b1;
			end
		endcase
	end
end

endmodule
