module exmem2 #(parameter DATA_WIDTH=8, parameter ADDR_WIDTH=8)
	   (input [(ADDR_WIDTH-1):0] addr1,
       input clk,
	    output wire [7:0] LEDS,
);

	// Declare the RAM variable
	reg [DATA_WIDTH-1:0] ram[2**ADDR_WIDTH-1:0];
	
	initial begin
	$display("Loading memory");
	$readmemh("/home/u1278438/mem.dat", ram);
	$display("done loading");
	end
	
	
	always @ (posedge clk)
	begin
	 LEDS <= ram[addr];
	end
	
endmodule
		