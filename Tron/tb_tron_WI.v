module tb_tron_WI();
reg clk;
reg reset;
wire [15:0] LED;

Tron UUT(
	.clk(clk),
	.reset(reset),
	.LED(LED)
);

initial begin 
	clk = 0;
	forever #5 clk = ~clk;
end

endmodule
