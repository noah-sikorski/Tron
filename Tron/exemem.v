/*
Module to link inputs and outputs to the memory.
*/
module exemem #(parameter DATA_WIDTH=16, parameter ADDR_WIDTH=14) (
	input [(DATA_WIDTH-1):0] dataIn1,
	input [15:0] addr1,
	input [(DATA_WIDTH-1):0] dataIn2,
	input [15:0] addr2,
	input [15:0] ProgramCounter,
	input                    we1, we2, clk,
	output reg [7:0]LED,
	output wire [15:0] dataOut1,
	output wire [15:0] dataOut2,
	output wire [15:0] Instruction
);

// Declare the RAM variable
reg [DATA_WIDTH-1:0] ram[(2**ADDR_WIDTH)-1:0];

//enable IO

wire IO = 1;//(ram[16383] == 16'b0000000000000001);

// Variable to hold the read address
reg [ADDR_WIDTH-1:0] addr1_reg;
reg [ADDR_WIDTH-1:0] addr2_reg;
reg [15:0] temp_instruction;


initial begin
$display("Loading memory");
$readmemh("C:\\intelFPGA_lite\\23.1std\\quartus\\bin64\\3710\\Tron\\Checkpoint3.dat", ram);
$display("done loading");
end


always @(posedge clk) begin
	// Write
	if(we1) begin
			if(IO) begin //If IO is enabled then write the computed value to the LED's
				LED <= dataIn1;	
				end
		ram[addr1] <= dataIn1;
	end if(we2) begin
		ram[addr2] <= dataIn2;
	end
	// register to hold the next address
	addr1_reg <= addr1;
	addr2_reg <= addr2;
end

always @(ProgramCounter) begin
    temp_instruction <= ram[ProgramCounter];
end

assign dataOut1 = ram[addr1_reg];
assign dataOut2 = ram[addr2_reg];
assign Instruction = temp_instruction;

endmodule
