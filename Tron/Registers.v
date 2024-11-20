/*
This module controls the registers for RAM.
It uses the register addresses to retrieve values from RAM to be placed into registers.
Place write data into the second register in RAM.
*/
module Registers #(parameter WIDTH=16, REGBITS=4) (
input clk, 
input regwrite, 
input [REGBITS-1:0] ra1, ra2,
input [WIDTH-1:0] wd,
output [WIDTH-1:0] rd1, rd2);

reg [WIDTH-1:0] RAM [(1<<REGBITS)-1:0];

// Load file RAM into the reg RAM.
initial begin
	$display("Loading register file");
	$readmemb("C:\\IntelQuartus\\23.1.1\\ece3710\\Tron\\emptyreg.dat", RAM); 
	$display("done with RF load"); 
end

// Save the write data into the second register.
always @(posedge clk) begin
	if (regwrite) RAM[ra2] <= wd;
end

// Retrieve value in ram for registers 1 and 2 and reg 0 is always 0.
assign rd1 = ra1 ? RAM[ra1] : 16'b0;
assign rd2 = ra2 ? RAM[ra2] : 16'b0;

endmodule
