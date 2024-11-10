/*
Module to link inputs and outputs to the memory.
*/
module exmem #(parameter DATA_WIDTH=16, parameter ADDR_WIDTH=16) (
	input [(DATA_WIDTH-1):0] dataIn1,
	input [(ADDR_WIDTH-1):0] addr1,
	input [(DATA_WIDTH-1):0] dataIn2,
	input [(ADDR_WIDTH-1):0] addr2,
	
	input [(DATA_WIDTH-1):0] ProgramCounter,
	input we1, we2, clk,
	input fetchPhase,
	input switches,
	
	output reg  [(DATA_WIDTH-1):0] LED,
	output wire [(DATA_WIDTH-1):0] dataOut1,
	output wire [(DATA_WIDTH-1):0] dataOut2,
	output wire [(DATA_WIDTH-1):0] instruction
);

// Declare the RAM variable
reg [DATA_WIDTH-1:0] ram[2**ADDR_WIDTH-1:0];

// Variable to hold the read address
reg [ADDR_WIDTH-1:0] addr1_reg;
reg [ADDR_WIDTH-1:0] addr2_reg;
reg [15:0] temp_instruction;

//enable IO
wire IO;
assign IO = (addr1[15:14] == 2'b11);

initial begin
	$display("Loading memory");
	$readmemh("C:\\IntelQuartus\\23.1.1\\ece3710\\Tron\\Checkpoint3.dat", ram);
	$display("done loading");
end


always @(posedge clk) begin
	// Write
	if(we1) begin
		if(IO) begin //If IO is enabled then write the computed value to the LED's
			LED <= dataIn1;	
		end else begin
			ram[addr1] <= dataIn1;
		end
	end if(we2) begin
		ram[addr2] <= dataIn2;
	end
	// register to hold the next address
	addr1_reg <= addr1;
	addr2_reg <= addr2;
end

always @(posedge clk) begin
	if (fetchPhase)
		temp_instruction <= ram[ProgramCounter];
end

assign dataOut1 = IO ? switches : ram[addr1_reg];
assign dataOut2 = ram[addr2_reg];
assign instruction = temp_instruction;

endmodule
