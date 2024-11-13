/*
Module to link inputs and outputs to the memory.
*/
module exmem #(parameter DATA_WIDTH=16, parameter ADDR_WIDTH=16) (
	input [(DATA_WIDTH-1):0] dataIn1,
	input [(ADDR_WIDTH-1):0] addr1,
	input [(DATA_WIDTH-1):0] dataIn2,
	input [(ADDR_WIDTH-1):0] addr2,
	
	input we1, we2, clk,
	
	output reg [(DATA_WIDTH-1):0] LED,
	output reg [(DATA_WIDTH-1):0] dataOut1,
	output reg [(DATA_WIDTH-1):0] dataOut2
);


// Declare the RAM variable
reg [DATA_WIDTH-1:0] ram[2**ADDR_WIDTH-1:0];

// Variable to hold the read address
reg [ADDR_WIDTH-1:0] addr1_reg;
reg [ADDR_WIDTH-1:0] addr2_reg;


//enable IO
wire IO;
assign IO = (addr1[15:14] == 2'b11); //(ram[32768] == 16'b0000000000000001);

initial begin
	$display("Loading memory");
	$readmemh("C:\\IntelQuartus\\23.1.1\\ece3710\\Tron\\Checkpoint3.dat", ram);
	$display("done loading");
end


always @(posedge clk) begin
	if (we1) begin
		ram[addr1] <= dataIn1;
		dataOut1 <= dataIn1;
	end else begin
		dataOut1 <= ram[addr1];
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
	if (IO) begin //If IO is enabled then write the computed value to the LED's
		LED <= dataIn1;
	end 
end

endmodule
