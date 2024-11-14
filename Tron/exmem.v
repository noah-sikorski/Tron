/*
Module to link inputs and outputs to the memory.
*/
module exmem #(parameter DATA_WIDTH=16, parameter ADDR_WIDTH=16) (
    input [(DATA_WIDTH-1):0] dataIn1,
    input [(ADDR_WIDTH-1):0] addr1,
    input [(DATA_WIDTH-1):0] dataIn2,
    input [(ADDR_WIDTH-1):0] addr2,
    input [7:0] switches,

    input we1, we2, clk,

    output reg [7:0] LED,
    output wire [(DATA_WIDTH-1):0] dataOut1,
    output reg [(DATA_WIDTH-1):0] dataOut2
);

// Declare the RAM variable
reg [DATA_WIDTH-1:0] ram[2**ADDR_WIDTH-1:0];

// Address to hold onto to compute into next address.
reg [ADDR_WIDTH-1:0] tempDataOut1;

//enable IO
wire IO;
assign IO = (addr1 == 16'd127);

initial begin
    $display("Loading memory");
    $readmemh("C:\\IntelQuartus\\23.1.1\\ece3710\\TronTemp\\program.dat", ram);
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
		LED <= dataIn1[7:0];
end

assign dataOut1 = IO ? {8'b0, switches} : tempDataOut1;

endmodule