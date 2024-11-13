module tb_tron_WI();
reg clk;
reg reset;
reg [7:0] switches;
wire [15:0] LED;

Tron UUT(
	.clk(clk),
	.reset(reset),
	.switches(switches),
	.LED(LED)
);

initial begin 
	switches = 4;
	clk = 0;
	forever #5 clk = ~clk;
end

endmodule
