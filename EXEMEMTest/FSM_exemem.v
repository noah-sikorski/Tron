/*
FSM to test the memory and verify it is working correctly.
Runs through memory to read and write to certain locations.
*/
module FSM_exemem(
	input clk,
	input reset,
	output [15:0] dataOut1,
	output [15:0] dataOut2
);

reg [3:0] state;
reg [3:0] nextstate;
reg [15:0] dataIn1;
reg [15:0] dataIn2;
reg [7:0] addr1;
reg [7:0] addr2;
reg we1;
reg we2;

parameter initializeMem   = 2'b00;
parameter setValuesInMem  = 2'b01;
parameter readDataFromMem = 2'b10;

exemem memory (
	.dataIn1(dataIn1),
	.addr1(addr1),
	.dataIn2(dataIn2),
	.addr2(addr2),
	.we1(we1),
	.we2(we2),
	.clk(clk),
	.dataOut1(dataOut1),
	.dataOut2(dataOut2)
);

always @(posedge clk) begin
	if(~reset) state <= initializeMem;
   else state <= nextstate;
end

always @(*) begin
	case(state)
		initializeMem: begin
			dataIn1 <= 16'b0;
			dataIn2 <= 16'b0;
			addr1 <= 8'b0;
			addr2 <= 8'b0;
			we1 <= 1'b0;
			we2 <= 1'b0;		
		end
		
		setValuesInMem: begin
			dataIn1 <= 16'd69;
			dataIn2 <= 16'd21;
			addr1 <= 8'd1;
			addr2 <= 8'd3;
			we1 <= 1'b1;
			we2 <= 1'b1;		
		end
		
		readDataFromMem: begin 
			dataIn1 <= 16'd69;
			dataIn2 <= 16'd21;
			addr1 <= 8'd1;
			addr2 <= 8'd3;
			we1 <= 1'b0;
			we2 <= 1'b0;		
		end 
		
		default: begin
			dataIn1 <= 16'b0;
			dataIn2 <= 16'b0;
			addr1 <= 8'b0;
			addr2 <= 8'b0;
			we1 <= 1'b0;
			we2 <= 1'b0;
		end
	endcase	
end

always@(*) begin
	case(state)
		initializeMem: begin
			nextstate <= setValuesInMem;
		end
		
		setValuesInMem: begin
			nextstate <= readDataFromMem;
		end
		
		readDataFromMem: begin
			nextstate <= initializeMem;
		end
		
		default: begin
			nextstate <= initializeMem;
		end
	endcase
end

endmodule 
