/*
Module to link inputs and outputs to the memory.
*/
module exmem #(parameter DATA_WIDTH=16, parameter ADDR_WIDTH=16) (
    input [(DATA_WIDTH-1):0] dataIn1,
    input [(ADDR_WIDTH-1):0] addr1,
    input [(DATA_WIDTH-1):0] dataIn2,
    input [(ADDR_WIDTH-1):0] addr2,
    input [9:0] switches,

    input we1, we2, clk,

    output reg [15:0] audioOutput,
    output wire [(DATA_WIDTH-1):0] dataOut1,
    output reg [(DATA_WIDTH-1):0] dataOut2
);

// Declare the RAM variable
reg [DATA_WIDTH-1:0] ram[2**ADDR_WIDTH-1:0];

// Address to hold onto to compute into next address.
reg [ADDR_WIDTH-1:0] tempDataOut1;

//enable IO
wire IO;
assign IO = (addr1 == 16'd60000);

initial begin
    $display("Loading memory");
    $readmemh("C:\\IntelQuartus\\23.1.1\\ece3710\\Assembler\\FinalTron.dat", ram);
    $display("done loading");
end


always @(posedge clk) begin
	if (we1) begin
		tempDataOut1 <= dataIn1;
		ram[addr1] <= dataIn1;
	end else begin
		tempDataOut1 <= ram[addr1];
	end 
end

always @(posedge clk) begin
    if (we2) begin
        ram[addr2] <= dataIn2;
        dataOut2 <= dataIn2;
    end else begin
        dataOut2 <= ram[addr2];
    end
end

always @(posedge clk) begin
	if (IO & we1)
		audioOutput <= dataIn1;
end

assign dataOut1 = IO ? {6'b0, switches} : tempDataOut1;

endmodule
