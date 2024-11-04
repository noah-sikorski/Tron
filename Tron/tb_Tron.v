module tb_Tron();
reg clk;
reg reset;
reg [15:0] instruction;
wire [15:0] addressOut;
wire [15:0] busOutput;

Tron UUT(
	.clk(clk),
	.reset(reset),
	.instruction(instruction),
	.addressOut(addressOut),
	.busOutput(busOutput)
);

initial begin
clk = 0;
forever #5 clk = ~clk;
end

initial begin
	ADDInstruction;
	ADDIInstruction;
	SubInstruction;
	SubIInstruction;
	CMPInstruction;
	CMPIInstruction;
	ANDInstruction;
	ANDIInstruction;
	MOVInstruction;
	ORInstruction;
	ORIInstruction;
	XORInstruction;
	XORIInstruction;
	LSHInstruction;
	LSHI0Instruction;
	LSHI1Instruction;
	LUIInstruction;
	JALInstruction;
	StoreInstruction;
	LoadInstruction;
	instruction = 16'b0000000000000000;
	//$stop;
end

task ResetInstruction;
begin
	reset = 1;
   instruction = 16'b1101000100000001;
   repeat(3) @(posedge clk);
end
endtask


task ADDInstruction;
begin
   reset = 1;
   instruction = 16'b0000000101010010;
   repeat(3) @(posedge clk);
   if(addressOut == 16'h0001) 
		if((UUT.fsmController.regWrite) && (busOutput == 16'h0003)) begin
	   $display("Correct result: Addition Instruction Successful");
	end
   ResetInstruction;
end
endtask

task MOVInstruction;
begin
	reset = 1;
   instruction = 16'b0000000111010101;
   repeat(3) @(posedge clk);
   if(addressOut == 16'h0011) 
		if((UUT.fsmController.regWrite) && (busOutput == 16'h0005)) begin
	   $display("Correct result: MOV Instruction Successful");
	end
   ResetInstruction;
end
endtask

task ANDInstruction;
begin
   instruction = 16'b0000000100010011;
   repeat(3) @(posedge clk);
   if(addressOut == 16'h000d) 
      if((UUT.fsmController.regWrite) && (busOutput == 16'h0001)) begin
	   $display("Correct result: AND Instruction Successful");
	end
   ResetInstruction;
end
endtask

task ADDIInstruction;
begin
   instruction = 16'b0101000110010011;
   repeat(3) @(posedge clk);
   if(addressOut == 16'h0003) 
		if((UUT.fsmController.regWrite) && (busOutput == 16'hff94)) begin
	   $display("Correct result: Addition Immediate Instruction Successful");
	end
   ResetInstruction;
end
endtask

task SubInstruction;
begin
   instruction = 16'b0000000110010010;
   repeat(3) @(posedge clk);
   if(addressOut == 16'h0005) 
		if((UUT.fsmController.regWrite) && (busOutput == 16'hffff)) begin
	   $display("Correct result: Subtraction Instruction Successful");
	end
   ResetInstruction;
end
endtask

task SubIInstruction;
begin
   instruction = 16'b1001000100000001;
   repeat(3) @(posedge clk);
   if(addressOut == 16'h0007) 
      if((UUT.fsmController.regWrite) && (busOutput == 16'h0000)) begin
	   $display("Correct result: Subtraction Immediate Instruction Successful");
	end
   ResetInstruction;
end
endtask

task CMPInstruction;
begin
    instruction = 16'b0000000110110001;
    repeat(3) @(posedge clk);
    if(addressOut == 16'h0009) 
       if((!UUT.fsmController.regWrite) && (UUT.UUTdatapath.flagreg == 16'h0008)) begin
	   $display("Correct result: Compare Instruction Successful");
	end
    ResetInstruction;
end
endtask

task CMPIInstruction;
begin
    instruction = 16'b1011000100000010;
    repeat(3) @(posedge clk);
    if(addressOut == 16'h000b) 
       if((!UUT.fsmController.regWrite) && (UUT.UUTdatapath.flagreg == 16'h0011)) begin
	   $display("Correct result: Compare Immediate Instruction Successful");
	end
    ResetInstruction;
end
endtask

task ANDIInstruction;
begin
    instruction = 16'b0001000111110010;
    repeat(3) @(posedge clk);
    if(addressOut == 16'h000f) 
       if((UUT.fsmController.regWrite) && (busOutput == 16'h0000)) begin
	   $display("Correct result: AND Immediate Instruction Successful");
	end
    ResetInstruction;
end
endtask

task ORInstruction;
begin
    instruction = 16'b0000000100100010;
    repeat(3) @(posedge clk);
    if(addressOut == 16'h0013) 
       if((UUT.fsmController.regWrite) && (busOutput == 16'h0003)) begin
	   $display("Correct result: OR Instruction Successful");
	end
    ResetInstruction;
end
endtask

task ORIInstruction;
begin
    instruction = 16'b0010000100001110;
    repeat(3) @(posedge clk);
    if(addressOut == 16'h0015) 
       if((UUT.fsmController.regWrite) && (busOutput == 16'h000f)) begin
	   $display("Correct result: OR Immediate Instruction Successful");
	end
    ResetInstruction;
end
endtask

task XORInstruction;
begin
    instruction = 16'b0000000100111110;
    repeat(3) @(posedge clk);
    if(addressOut == 16'h0017) 
       if((UUT.fsmController.regWrite) && (busOutput == 16'h000f)) begin
	   $display("Correct result: XOR Instruction Successful");
	end
    ResetInstruction;
end
endtask

task XORIInstruction;
begin
    instruction = 16'b0011000100001110;
    repeat(3) @(posedge clk);
    if(addressOut == 16'h0019) 
       if((UUT.fsmController.regWrite) && (busOutput == 16'h000f)) begin
	   $display("Correct result: XOR Immediate Instruction Successful");
	end
    ResetInstruction;
end
endtask

task LSHInstruction;
begin
    instruction = 16'b1000000101000011;
    repeat(3) @(posedge clk);
    if(addressOut == 16'h001b) 
       if((UUT.fsmController.regWrite) && (busOutput == 16'h0008)) begin
	   $display("Correct result: LSHI Instruction Successful");
	end
    ResetInstruction;
end
endtask

task LSHI0Instruction;
begin
    instruction = 16'b1000000100000001;
    repeat(3) @(posedge clk);
    if(addressOut == 16'h001d) 
       if((UUT.fsmController.regWrite) && (busOutput == 16'h0002)) begin
	   $display("Correct result: LSHI0 Instruction Successful");
	end
    ResetInstruction;
end
endtask

task LSHI1Instruction;
begin
   instruction = 16'b1000000100010001;
   repeat(3) @(posedge clk);
   if(addressOut == 16'h001f) 
       if((UUT.fsmController.regWrite) && (busOutput == 16'h0002)) begin
	   $display("Correct result: LSHI1 Instruction Successful");
	end
   ResetInstruction;
end
endtask

task LUIInstruction;
begin
   instruction = 16'b1111000100000001;
   repeat(4) @(posedge clk);
   if(addressOut == 16'h0021) begin
		if((UUT.fsmController.regWrite) && (busOutput == 16'h0100)) begin
			$display("Correct result: LUI Instruction Successful");
		end else begin
			$display("Failed LUI Instruction");
		end
	end
   ResetInstruction;
end
endtask

task JALInstruction;
begin
	instruction = 16'b0100000110000010;
   repeat(3) @(posedge clk);
	if((UUT.fsmController.regWrite) && (busOutput == 16'h0023)) begin
		$display("Correct result: JAL Part1 Instruction Successful");
	end else begin
		$display("Failed JAL Part1 Instruction");
	end
	
	repeat(1) @(posedge clk);
	if(addressOut == 16'h0002) begin
		$display("Correct result: JAL Part2 Instruction Successful");
	end else begin
		$display("Failed JAL Part2 Instruction");
	end
   ResetInstruction;
end
endtask

task StoreInstruction;
begin
	instruction = 16'b0100010101000001;
	repeat(3) @(posedge clk);
	if((UUT.memWrite) && (busOutput == 16'h0005) && (UUT.regA)) begin
		$display("Correct result: Store Successful");
	end else begin
		$display("Failed Store Instruction");
		end
end
endtask

task LoadInstruction;
begin
	instruction = 16'b0100000100000001;
	repeat(4) @(posedge clk);
	if((UUT.regWrite) && (busOutput == 16'h0005) && (UUT.regA)) begin
		$display("Correct result: Load Successful");
	end else begin
		$display("Failed Load Instruction");
	end
	ResetInstruction;
end
endtask

endmodule
