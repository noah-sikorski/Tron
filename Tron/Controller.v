/*

*/
module Controller #(parameter WIDTH=16, REGBITS=4) (
   input clk,
   input reset,
	input [15:0] instruction,
	
	output reg[7:0] instructionOp = 8'b0,
	output reg[WIDTH-1:0] immediate = 16'b0,
	output reg[REGBITS-1:0] regAddA = 4'b0,
	output reg[REGBITS-1:0] regAddB = 4'b0,
	output reg[3:0] flagOp = 4'b0,
	
	output reg[3:0] ALUOp,
   output reg[1:0] shiftOp,
	output reg[2:0] busOp,

	output reg immMUX,
	output reg regWrite,
	output reg memWrite,
	output reg flagWrite,
	
	output reg pcAdd,
	output reg pcJump,
	output reg pcBranch
);

// Different phases for different intructions.
localparam FETCH 	= 8'b00000100;
localparam DECODE = 8'b00001000;

localparam RTYPE	= 8'b10001100;
localparam ITYPE 	= 8'b10001101;
localparam SHIFT	= 8'b10001110;
localparam LUIS	= 8'b10001111;
localparam LOADS  = 8'b10001010;
localparam STORS  = 8'b10001011;

localparam ADD 	= 8'b00000101;
localparam ADDI   = 8'b01010000;
localparam SUB  	= 8'b00001001;
localparam SUBI   = 8'b10010000;
localparam CMP  	= 8'b00001011;
localparam CMPI   = 8'b10110000;
localparam AND   	= 8'b00000001;
localparam ANDI   = 8'b00010000;
localparam OR   	= 8'b00000010;
localparam ORI  	= 8'b00100000;
localparam XOR   	= 8'b00000011;
localparam XORI	= 8'b00110000;
localparam MOV 	= 8'b00001101;
localparam MOVI 	= 8'b11010000;

localparam LSH		= 8'b10000100;
localparam LSHI0 	= 8'b10000000;
localparam LSHI1 	= 8'b10000001;
localparam LUI		= 8'b11110000;
localparam LOAD	= 8'b01000000;
localparam STOR	= 8'b01000100;
localparam JAL		= 8'b01001000;

localparam BCOND 	= 8'b11000000;
localparam JCOND 	= 8'b01001100;

// State registers for holding current and next states
reg [7:0] currentstate = FETCH;
reg [7:0] nextstate = FETCH;

// Synchronous state transition on clock edge or reset
always @(posedge clk) begin
	if (~reset) 
		currentstate <= FETCH;  // Start in FETCH state after reset
	else 
		currentstate <= nextstate;  // Transition to the next state
end

// Next state logic (determines what the next state will be)
always @(currentstate) begin
	case(currentstate)
		FETCH: nextstate <= DECODE;
		
		DECODE: begin
			case (instructionOp)
				ADD: nextstate <= RTYPE;
				SUB: nextstate <= RTYPE;
				AND: nextstate <= RTYPE;
				OR:  nextstate <= RTYPE;
				XOR: nextstate <= RTYPE;
				CMP: nextstate <= RTYPE;
				MOV: nextstate <= RTYPE;
				
				LSHI0: nextstate <= SHIFT;
				LSHI1: nextstate <= SHIFT;
				LSH:	 nextstate <= SHIFT;
				
				ADDI: nextstate <= ITYPE;
				SUBI: nextstate <= ITYPE;
				ANDI: nextstate <= ITYPE;
				ORI:  nextstate <= ITYPE;
				XORI: nextstate <= ITYPE;
				CMPI: nextstate <= ITYPE;
				MOVI: nextstate <= ITYPE;
				default: nextstate <= instructionOp;
			endcase
		end
		
		LUI:  nextstate <= LUIS;
		JAL:  nextstate <= JCOND;
		LOAD: nextstate <= LOADS;
		STOR: nextstate <= STORS;
		
		default:	nextstate <= FETCH;
	endcase
end

// Output logic (controls what happens in each state)
always @(currentstate) begin
	// Initialize outputs.
	ALUOp     <= 4'b0;
   shiftOp   <= 2'b0;
	busOp     <= 3'b0;
	immMUX    <= 1'b0;
	regWrite  <= 1'b0;
	memWrite  <= 1'b0;
	flagWrite <= 1'b0;
	
	pcAdd 	<= 1'b0;
	pcJump	<= 1'b0;
	pcBranch	<= 1'b0;
	
	case (currentstate)
		// Phase to decode instruction.
		FETCH: begin
			// Initialize registers, immediate, and OPCode.
			regAddA       <= 4'b0;
			regAddB       <= 4'b0;
			immediate     <= 16'b0;
			instructionOp <= 8'b0;
			flagOp		  <= 4'b0;
			
			// Register Type Instruction
			if (instruction[15:12] == 4'b0000) begin
				instructionOp <= {instruction[15:12], instruction[7:4]};
				regAddA <= instruction[3:0];
				regAddB <= instruction[11:8];
				
			// Immediate Type Instruction
			end else if (instruction[13] || instruction[12]) begin
				instructionOp[7:4] <= instruction[15:12];
				regAddB <= instruction[11:8];
				immediate <= instruction[7:0];
			
			// Special Type Instruction
			end else if (instruction[15:12] == 4'b0100) begin	
				// LOAD Type Instruction
				if (instruction[7:4] == 4'b0000) begin
					instructionOp <= {instruction[15:12], instruction[7:4]};
					regAddA <= instruction[3:0];
					regAddB <= instruction[11:8];
					
				// STOR Type Instruction
				end else if (instruction[7:4] == 4'b0100) begin
					instructionOp <= {instruction[15:12], instruction[7:4]};
					regAddA <= instruction[3:0];
					regAddB <= instruction[11:8];
					
				// JAL Type Instruction
				end else begin
					instructionOp <= {instruction[15:12], instruction[7:4]};
					flagOp <= 4'b1111;
					regAddA <= instruction[3:0];
					regAddB <= instruction[11:8];
				end
			
			// Shift Type Instruction
			end else if (instruction[15:12] == 4'b1000) begin
				// LSH Type Instruction
				if (instruction[7:4] == 4'b0100) begin
					instructionOp <= {instruction[15:12], instruction[7:4]};
					regAddA <= instruction[3:0];
					regAddB <= instruction[11:8];
					
				// LSHI Type Instruction
				end else begin
					instructionOp <= {instruction[15:12], instruction[7:4]};
					regAddB <= instruction[11:8];
					immediate <= instruction[3:0];
				end
			
			// Conditional Type Instruction
			end else begin
				flagOp <= instruction[11:8];
				
				// Branch Cond Type Instruction
				if (instruction[15:12] == 4'b1100) begin
					instructionOp[7:4] <= instruction[15:12];
					immediate <= instruction[7:0];
				
				// Jump Cond Type Instruction
				end else begin
					instructionOp <= {instruction[15:12], instruction[7:4]};
					regAddA <= instruction[3:0];
				end
			end
		end
		
		// Phase to determine the next phase to go to.
		DECODE: begin 
			// Sign Extend the Immediate Value.
			if (instructionOp == ADDI || instructionOp == SUBI || instructionOp == CMPI || instructionOp == BCOND) begin
				immediate <= {{8{immediate[7]}}, immediate[7:0]};
			end else if (instructionOp == LSHI0 || instructionOp == LSHI1) begin
				immediate <= {{12{immediate[3]}}, immediate[3:0]};
			end else begin
				immediate <= {8'b0, immediate[7:0]};
			end
		end
		
		// Phase to determine RType outputs.
		RTYPE: begin
			immMUX  	 <= 1'b0;
			busOp     <= 3'b0;
			regWrite  <= 1'b1;
			pcAdd	    <= 1'b1;
			
			case (instructionOp)
				ADD: begin ALUOp <= 4'b0000; flagWrite <= 1'b1; end
				SUB: begin ALUOp <= 4'b1000; flagWrite <= 1'b1; end
				AND: begin ALUOp <= 4'b0001; flagWrite <= 1'b1; end
				OR:  begin ALUOp <= 4'b0010; flagWrite <= 1'b1; end
				XOR: begin ALUOp <= 4'b0011; flagWrite <= 1'b1; end
				CMP: begin ALUOp <= 4'b1000; regWrite <= 1'b0; flagWrite <= 1'b1; end
				MOV: begin ALUOp <= 4'b0000; busOp    <= 3'b010; end
				default: begin end
			endcase
		end

		// Phase to determine IType outputs.
		ITYPE: begin
			immMUX   <= 1'b1;
			busOp    <= 3'b0;
			regWrite <= 1'b1;
			pcAdd	   <= 1'b1;
			
			case (instructionOp)
				ADDI: begin ALUOp <= 4'b0000; flagWrite <= 1'b1; end
				SUBI: begin ALUOp <= 4'b1000; flagWrite <= 1'b1; end
				ANDI: begin ALUOp <= 4'b0001; flagWrite <= 1'b1; end
				ORI:  begin ALUOp <= 4'b0010; flagWrite <= 1'b1; end
				XORI: begin ALUOp <= 4'b0011; flagWrite <= 1'b1; end
				CMPI: begin ALUOp <= 4'b1000; regWrite <= 1'b0; flagWrite <= 1'b1; end
				MOVI: begin ALUOp <= 4'b0000; busOp    <= 3'b010; end
				default: begin end
			endcase
		end
		
		// Phase Load Upper Immediate.
		LUI: begin
			immMUX   <= 1'b1;
			busOp    <= 3'b010;
			regWrite <= 1'b1;
		end
		
		// Phase 2 Load Upper Immediate.
		LUIS: begin
			immediate <= 16'b0000000000001000;
			immMUX    <= 1'b1;
			busOp     <= 3'b001;
			regWrite  <= 1'b1;
			pcAdd		 <= 1'b1;
		end
		
		// Phase to shift input.
		SHIFT: begin
			busOp    <= 3'b001;
			shiftOp  <= 2'b0;
			regWrite <= 1'b1;
			pcAdd	   <= 1'b1;
			
			case (instructionOp)
				LSH:	 immMUX <= 1'b0;
				LSHI0: immMUX <= 1'b1;
				LSHI1: immMUX <= 1'b1;
				default: begin end
			endcase
		end
		
		// Stall to retrieve value form memory
		LOAD: begin
			
		end
		
		// Phase to Load to register.
		LOADS: begin
			busOp    <= 3'b011;
			regWrite <= 1'b1;
		end
		
		// Phase to store value to memory.
		STOR: begin
			busOp    <= 3'b101;
			memWrite <= 1'b1;
		end
		
		// Stall to allow store into memory.
		STORS: begin
		
		end
		
		// Phase to jump and save pc to memory.
		JAL: begin
			regWrite <= 1;
			pcAdd	   <= 1'b1;
			busOp    <= 3'b100;
		end
		
		// Phase to jump to a register.
		JCOND: begin
			pcJump <= 1'b1;
			immMUX <= 1'b0;
		end
		
		// Phase to jump by a displacement.
		BCOND: begin
			pcBranch <= 1'b1;
			immMUX <= 1'b1;
		end
		
		// Default Phase should never happen.
		default: begin 
			regAddA       <= 4'b0;
			regAddB       <= 4'b0;
			immediate     <= 16'b0;
			instructionOp <= 8'b0;
			flagOp		  <= 4'b0;
		end
	endcase
end

endmodule
