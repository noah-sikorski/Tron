module ProgramCounter #(parameter WIDTH = 16) (
	 input reset,

    input [3:0] flagOp,
	 input [15:0] flagRegister,
	 input [15:0] immediate,
	 
	 input pcAdd,
	 input pcJump,
	 input pcBranch,
	 
    output wire[WIDTH-1:0] addressOut = 0
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

always @(*) begin
	if (reset) begin
		pcAddress <= 16'b0;
	end else if (pcAdd) begin
		pcAddress <= pcAddress + 16'b1;
	end else if (pcBranch) begin
	  case (flagOp)
			EQ: begin
				if (flagRegister[3]) begin
					pcAddress <= pcAddress + 16'b1 + immediate;
				end
			end
			NE: begin
				if (!flagRegister[3]) begin
					pcAddress <= pcAddress + 16'b1 + immediate;
				end
			end
			CS: begin
				if (flagRegister[0]) begin
					pcAddress <= pcAddress + 16'b1 + immediate;
				end
			end
			CC: begin
				if (!flagRegister[0]) begin
					pcAddress <= pcAddress + 16'b1 + immediate;
				end
			end
			HI: begin
				if (flagRegister[1]) begin
					pcAddress <= pcAddress + 16'b1 + immediate;
				end
			end
			LS: begin
				if (!flagRegister[1]) begin
					pcAddress <= pcAddress + 16'b1 + immediate;
				end
			end
			GT: begin
				if (flagRegister[4]) begin
				   pcAddress <= pcAddress + 16'b1 + immediate;
				end
			end
			LE: begin
				if (!flagRegister[4]) begin
				   pcAddress <= pcAddress + 16'b1 + immediate;
				end
			end
			FS: begin
				if (flagRegister[2]) begin
					pcAddress <= pcAddress + 16'b1 + immediate;
				end
			end
			FC: begin
				if (!flagRegister[2]) begin
					pcAddress <= pcAddress + 16'b1 + immediate;
				end
			end
			LO: begin
				if (!flagRegister[1] && !flagRegister[3]) begin
					pcAddress <= pcAddress + 16'b1 + immediate;
				end
			end
			HS: begin
				if (flagRegister[1] || flagRegister[3]) begin
					pcAddress <= pcAddress + 16'b1 + immediate;
				end
			end
			LT: begin
				if (!flagRegister[3] && !flagRegister[4]) begin
					pcAddress <= pcAddress + 16'b1 + immediate;
				end
			end
			GE: begin
				if (flagRegister[3] || flagRegister[4]) begin
					pcAddress <= pcAddress + 16'b1 + immediate;
				end
			end
			UC: begin
				pcAddress <= pcAddress + 16'b1 + immediate;
			end
			default: begin
				pcAddress <= pcAddress + 16'b1;
			end
		endcase
	end else if (pcJump) begin
		case (flagOp)
			EQ: begin
				if(flagRegister[3]) begin
					pcAddress <= immediate;
				end
			end
			NE: begin
				if(!flagRegister[3]) begin
					pcAddress <= immediate;
				end
			end
			CS: begin
				if(flagRegister[0]) begin
					pcAddress <= immediate;
				end
			end
			CC: begin
				if(!flagRegister[0]) begin
					pcAddress <= immediate;
				end
			end
			HI: begin
				if(flagRegister[1]) begin
					pcAddress <= immediate;
				end
			end
			LS: begin
				if(!flagRegister[1]) begin
					pcAddress <= immediate;
				end
			end
			GT: begin
				if(flagRegister[4]) begin
					pcAddress <= immediate;
				end
			end
			LE: begin
				if(!flagRegister[4]) begin
					pcAddress <= immediate;
				end
			end
			FS: begin
				if(flagRegister[2]) begin
					pcAddress <= immediate;
				end
			end
			FC: begin
				if(!flagRegister[2]) begin
					pcAddress <= immediate;
				end
			end
			LO: begin
				if(!flagRegister[1] && !flagRegister[3]) begin
					pcAddress <= immediate;
				end
			end
			HS: begin
				if(flagRegister[1] || flagRegister[3]) begin
					pcAddress <= immediate;
				end
			end
			LT: begin
				if(!flagRegister[3] && !flagRegister[4]) begin
					pcAddress <= immediate;
				end
			end
			GE: begin
				if(flagRegister[3] || flagRegister[4]) begin
					pcAddress <= immediate;
				end
			end
			UC: begin
				pcAddress <= immediate;
			end
			default: begin
				pcAddress <= pcAddress + 16'b1;
			end
		endcase
	 end
end

endmodule
