/*
Test the exemem and verify it can read and write to certain locations in memory.
*/
module tb_exemem();

reg clk;
reg reset;
wire [15:0] dataOut1;
wire [15:0] dataOut2;

FSM_exemem UUT(
	.clk(clk),
	.reset(reset),
	.dataOut1(dataOut1),
	.dataOut2(dataOut2)
);

initial begin 
	clk = 0;
	forever #5 clk = ~clk;
end 

initial begin
	reset = 0;
	repeat(1)@(posedge clk);
	reset = 1;
	repeat(1)@(posedge clk);
	reset = 0;
end

always @(posedge clk) begin
   if(UUT.memory.we1) begin
		if((UUT.memory.addr1 == 8'd1) && (UUT.memory.dataIn1 == 16'd69)) begin
			$display("YaY! - data value in memory addresss at 1 is correct");
    	end else begin
			$display("Opps - wrong value written to addr 1: %h", UUT.memory.addr1);
	   end
	end
	if(UUT.memory.we2) begin
		if((UUT.memory.addr2 == 8'd3) && (UUT.memory.dataIn2 == 16'd21)) begin
 	      $display("YaY! - data value in memory addresss at 3 is correct");
    	end else begin 
			$display("Opps - wrong value written to addr 3: %h", UUT.memory.addr2);
	   end
	end
end

endmodule 
