module tb_tron_WI();
reg clk;
reg reset;
wire [15:0] addressOut;
wire [15:0] busOutput;

Tron UUT(
	.clk(clk),
	.reset(reset),
	.addressOut(addressOut),
	.busOutput(busOutput)
);

initial begin 
clk = 0;
forever #5 clk = ~clk;
end

endmodule