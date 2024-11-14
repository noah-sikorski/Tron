/*
Simply run the code from the dat file.
*/
module tb_tron_WI();

reg clk;
reg reset;
reg [7:0] switches;
wire [7:0] LED;

Tron UUT(
	.clk(clk),
	.reset(reset),
	.switches(switches),
	.LED(LED)
);

initial begin 
	clk = 0;
	forever #5 clk = ~clk;
	
end

initial begin
switches = 0;
repeat(600)@(posedge clk);
switches = 6;
end

endmodule
