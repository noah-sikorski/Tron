/*
Simply run the code from the dat file.
*/
module tb_tron_WI();

reg clk;
reg reset;
reg [7:0] switches;

wire VGA_HS;
wire VGA_VS;
wire VGA_CLK;
wire VGA_SYNC_N;
wire VGA_BLANK_N;

wire[7:0] VGA_R;
wire[7:0] VGA_G;
wire[7:0] VGA_B;




Tron UUT(
	.clk(clk),
	.reset(reset),
	.switches(switches),
	.VGA_HS(VGA_HS),
	.VGA_VS(VGA_VS),
	.VGA_CLK(VGA_CLK),
	.VGA_SYNC_N(VGA_SYNC_N),
	.VGA_BLANK_N(VGA_BLANK_N),
	.VGA_R(VGA_R),
	.VGA_G(VGA_G),
	.VGA_B(VGA_B)
	

);

initial begin 
	clk = 0;
	forever #5 clk = ~clk;
	
end

initial begin
reset = 0;
switches = 0;
repeat(600)@(posedge clk);
switches = 6;
end

endmodule
