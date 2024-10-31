module exmem2 #(parameter DATA_WIDTH=16, parameter ADDR_WIDTH=10)
	   (input [(DATA_WIDTH-1):0] dataIn1,
	    input [(ADDR_WIDTH-1):0] addr1,
	    input [(DATA_WIDTH-1):0] dataIn2,
	    input [(ADDR_WIDTH-1):0] addr2,
	    input                    we1,we2, clk,
	    output wire [(DATA_WIDTH-1):0] dataOut1,
	    output wire [(DATA_WIDTH-1):0] dataOut2
);

	// Declare the RAM variable
	reg [DATA_WIDTH-1:0] ram[2**ADDR_WIDTH-1:0];

	// Variable to hold the read address
	reg [ADDR_WIDTH-1:0] addr1_reg;
	reg [ADDR_WIDTH-1:0] addr2_reg;

	/*
	initial begin
	$display("Loading memory");
	$readmemh("/home/u1278438/mem.dat", ram);
	$display("done loading");
	end
	*/
	
	always @ (posedge clk)
	begin
		// Write
		if (we1)begin 
			ram[addr1] <= dataIn1;
		end if(we2) begin
			ram[addr2] <= dataIn2;
		end
      // register to hold the next address
		addr1_reg <= addr1;
		addr2_reg <= addr2;
	end
	
	assign dataOut1 = ram[addr1_reg];
	assign dataOut2 = ram[addr2_reg];
	
endmodule
		 