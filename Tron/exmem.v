/*
This is the file that implements the use of memory.
It allows the use of the M10k blocks in the FPGA.
There are functions for reading and writing to
the RAM and implementing IO to read from an input
and write to an output.

By: Tron-Tastic Engineers
*/
module exmem #(parameter DATA_WIDTH=16, parameter ADDR_WIDTH=16) (
	// The 50Mhz clock.
	input clk,

	// Port 1 inputs and outputs.
	input we1,
   input [(DATA_WIDTH-1):0] dataIn1,
   input [(ADDR_WIDTH-1):0] addr1,
	output wire [(DATA_WIDTH-1):0] dataOut1,

	// Port 2 inputs and outputs.
	input we2,
   input [(DATA_WIDTH-1):0] dataIn2,
   input [(ADDR_WIDTH-1):0] addr2,
	output reg [(DATA_WIDTH-1):0] dataOut2,
	
	// Switches and audio being IO.
   input [9:0] switches,
   output reg [15:0] audioOutput
);

// Declare the RAM variable
reg [DATA_WIDTH-1:0] ram[2**ADDR_WIDTH-1:0];

// Address to hold onto to compute into next address.
reg [ADDR_WIDTH-1:0] tempDataOut1;

// TO is set to be the 16 bit number at address 60000.
wire IO;
assign IO = (addr1 == 16'd60000);

// Initialize the memory with the lines of machine code.
initial begin
    $display("Loading memory");
    $readmemh("C:\\IntelQuartus\\23.1.1\\ece3710\\Assembler\\FinalTron.dat", ram);
    $display("done loading");
end

// Port 1 of the RAM. Used for reading and writing.
always @(posedge clk) begin
	if (we1) begin
		tempDataOut1 <= dataIn1;
		ram[addr1] <= dataIn1;
	end else begin
		tempDataOut1 <= ram[addr1];
	end 
end

// Port 2 of the RAM. Used for reading and writing.
always @(posedge clk) begin
    if (we2) begin
        ram[addr2] <= dataIn2;
        dataOut2 <= dataIn2;
    end else begin
        dataOut2 <= ram[addr2];
    end
end

// Output IO is implemented here.
always @(posedge clk) begin
	if (IO & we1)
		audioOutput <= dataIn1;
end

// Input IO is implemented here.
assign dataOut1 = IO ? {6'b0, switches} : tempDataOut1;


endmodule
