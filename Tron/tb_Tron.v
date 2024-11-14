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
	JumpInstructions;
	BranchInstructions;
	StoreInstruction;
	LoadInstruction;
	instruction = 16'b0000000000000000;
	$stop;
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
	
   if(addressOut == 16'h0000) 
		if((UUT.fsmController.regWrite) && (busOutput == 16'h0003))
			$display("Correct result: ADD Instruction Successful");
		else
			$display("Incorrect result: ADD Instruction Not Successful");
   ResetInstruction;
end
endtask

task MOVInstruction;
begin
	reset = 1;
   instruction = 16'b0000000111010101;
   repeat(3) @(posedge clk);
	
   if(addressOut == 16'h0010) 
		if((UUT.fsmController.regWrite) && (busOutput == 16'h0005))
			$display("Correct result: MOV Instruction Successful");
		else
			$display("Incorrect result: MOV Instruction Not Successful");
   ResetInstruction;
end
endtask

task ANDInstruction;
begin
   instruction = 16'b0000000100010011;
   repeat(3) @(posedge clk);
	
   if(addressOut == 16'h000c) 
      if((UUT.fsmController.regWrite) && (busOutput == 16'h0001))
			$display("Correct result: AND Instruction Successful");
		else
			$display("Incorrect result: AND Instruction Not Successful");
   ResetInstruction;
end
endtask

task ADDIInstruction;
begin
   instruction = 16'b0101000110010011;
   repeat(3) @(posedge clk);
	
   if(addressOut == 16'h0002) 
		if((UUT.fsmController.regWrite) && (busOutput == 16'hff94))
			$display("Correct result: ADDI Instruction Successful");
		else
			$display("Incorrect result: ADDI Instruction Not Successful");
   ResetInstruction;
end
endtask

task SubInstruction;
begin
   instruction = 16'b0000000110010010;
   repeat(3) @(posedge clk);
	
   if(addressOut == 16'h0004) 
		if((UUT.fsmController.regWrite) && (busOutput == 16'hffff))
			$display("Correct result: SUB Instruction Successful");
		else
			$display("Incorrect result: SUB Instruction Not Successful");
   ResetInstruction;
end
endtask

task SubIInstruction;
begin
   instruction = 16'b1001000100000001;
   repeat(3) @(posedge clk);
	
   if(addressOut == 16'h0006) 
      if((UUT.fsmController.regWrite) && (busOutput == 16'h0000))
			$display("Correct result: SUBI Instruction Successful");
		else
			$display("Incorrect result: SUBI Instruction Not Successful");
   ResetInstruction;
end
endtask

task CMPInstruction;
begin
   instruction = 16'b0000000110110001;
   repeat(3) @(posedge clk);
	 
	if(addressOut == 16'h0008) 
		if((!UUT.fsmController.regWrite) && (UUT.UUTdatapath.flagreg == 16'h0008))
			$display("Correct result: CMP Instruction Successful");
		else
			$display("Incorrect result: CMP Instruction Not Successful");
	ResetInstruction;
end
endtask

task CMPIInstruction;
begin
   instruction = 16'b1011000100000010;
   repeat(3) @(posedge clk);
	 
   if(addressOut == 16'h000a) 
		if((!UUT.fsmController.regWrite) && (UUT.UUTdatapath.flagreg == 16'h0011))
			$display("Correct result: CMPI Instruction Successful");
		else
			$display("Incorrect result: CMPI Instruction Not Successful");
   ResetInstruction;
end
endtask

task ANDIInstruction;
begin
   instruction = 16'b0001000111110010;
   repeat(3) @(posedge clk);
	
   if(addressOut == 16'h000e) 
		if((UUT.fsmController.regWrite) && (busOutput == 16'h0000))
			$display("Correct result: ANDI Instruction Successful");
		else
			$display("Incorrect result: ANDI Not Successful");
   ResetInstruction;
end
endtask

task ORInstruction;
begin
   instruction = 16'b0000000100100010;
   repeat(3) @(posedge clk);
	 
	if(addressOut == 16'h0012) 
		if((UUT.fsmController.regWrite) && (busOutput == 16'h0003))
			$display("Correct result: OR Instruction Successful");
		else
			$display("Incorrect result: OR Instruction Not Successful");
	ResetInstruction;
end
endtask

task ORIInstruction;
begin
	instruction = 16'b0010000100001110;
   repeat(3) @(posedge clk);
	
   if(addressOut == 16'h0014) 
      if((UUT.fsmController.regWrite) && (busOutput == 16'h000f))
			$display("Correct result: ORI Instruction Successful");
		else
			$display("Incorrect result: ORI Instruction Not Successful");
	ResetInstruction;
end
endtask

task XORInstruction;
begin
	instruction = 16'b0000000100111110;
   repeat(3) @(posedge clk);
	 
   if(addressOut == 16'h0016) 
		if((UUT.fsmController.regWrite) && (busOutput == 16'h000f))
			$display("Correct result: XOR Instruction Successful");
		else
			$display("Incorrect result: XOR Instruction Not Successful");
		
	ResetInstruction;
end
endtask

task XORIInstruction;
begin
   instruction = 16'b0011000100001110;
   repeat(3) @(posedge clk);
	
   if(addressOut == 16'h0018) 
		if((UUT.fsmController.regWrite) && (busOutput == 16'h000f))
			$display("Correct result: XORI Instruction Successful");
		else
			$display("Incorrect result: XORI Instruction Not Successful");
   ResetInstruction;
end
endtask

task LSHInstruction;
begin
   instruction = 16'b1000000101000011;
   repeat(3) @(posedge clk);
	
   if(addressOut == 16'h001a) 
		if((UUT.fsmController.regWrite) && (busOutput == 16'h0008))
			$display("Correct result: LSH Instruction Successful");
		else
			$display("Incorrect result: LSH Instruction Not Successful");
   ResetInstruction;
end
endtask

task LSHI0Instruction;
begin
   instruction = 16'b1000000100000001;
   repeat(3) @(posedge clk);
	 
   if(addressOut == 16'h001c) 
		if((UUT.fsmController.regWrite) && (busOutput == 16'h0002))
			$display("Correct result: LSHI0 Instruction Successful");
		else
			$display("Incorrect result: LSHI0 Instruction Not Successful");
   ResetInstruction;
end
endtask

task LSHI1Instruction;
begin
   instruction = 16'b1000000100010001;
   repeat(3) @(posedge clk);
	
   if(addressOut == 16'h001e) 
		if((UUT.fsmController.regWrite) && (busOutput == 16'h0002))
			$display("Correct result: LSHI1 Instruction Successful");
		else
			$display("Incorrect result: LSHI1 Instruction Not Successful");
   ResetInstruction;
end
endtask

task LUIInstruction;
begin
   instruction = 16'b1111000100000001;
   repeat(4) @(posedge clk);
	
   if(addressOut == 16'h0020)
		if((UUT.fsmController.regWrite) && (busOutput == 16'h0100))
			$display("Correct result: LUI Instruction Successful");
		else
			$display("Incorrect result: LUI Instruction Not Successful");
   ResetInstruction;
end
endtask

task JALInstruction;
begin
	instruction = 16'b0100000110000010;
   repeat(3) @(posedge clk);
	
	if((UUT.fsmController.regWrite) && (busOutput == 16'h0022))
		$display("Correct result: JAL Part1 Instruction Successful");
	else
		$display("Incorrect result: JAL Part1 Instruction Not Successful");
		
	repeat(1) @(posedge clk);
	
	if(addressOut == 16'h0023)
		$display("Correct result: JAL Part2 Instruction Successful");
	else
		$display("Incorrect result: JAL Part2 Instruction Not Successful");
   ResetInstruction;
end
endtask

task StoreInstruction;
begin
	instruction = 16'b0100010101000001;
	repeat(3) @(posedge clk);
	
	if((UUT.memWrite) && (busOutput == 16'h0005) && (UUT.regA))
		$display("Correct result: STOR Successful");
	else
		$display("Incorrect result: STOR Instruction Not Successful");
	
	repeat(1) @(posedge clk);
end
endtask

task LoadInstruction;
begin
	instruction = 16'b0100000100000001;
	repeat(3) @(posedge clk);
	
	if((UUT.regWrite) && (busOutput == 16'h0005) && (UUT.regA))
		$display("Correct result: LOAD Successful");
	else
		$display("Incorrect result: LOAD Instruction Not Successful");
	ResetInstruction;
end
endtask

task JumpInstructions;
begin
	// Uncodonditonal Jump
	instruction = 16'b0100111011000001;
	repeat(3) @(posedge clk);
	
	// Compare two equals
	instruction = 16'b0000000110110001;
	repeat(1) @(posedge clk);
	if(addressOut == 16'h0001)
		$display("Correct result: JUC Successful");
	else
		$display("Incorrect result: JUC Not Successful");
	repeat(2) @(posedge clk);
	
	
	// Equal Jump
	instruction = 16'b0100000011000001;
	repeat(3) @(posedge clk);
	
	// Compare two non-equals
	instruction = 16'b0000010010110001;
	repeat(1) @(posedge clk);
	if(addressOut == 16'h0001)
		$display("Correct result: JEQ Successful");
	else
		$display("Incorrect result: JEQ Not Successful");
	repeat(2) @(posedge clk);
	
	
	// Non-Equal Jump
	instruction = 16'b0100000111000001;
	repeat(3) @(posedge clk);
	
	// Compare less than
	instruction = 16'b0000001010110001; // rsrc < rdst
	repeat(1) @(posedge clk);
	if(addressOut == 16'h0001)
		$display("Correct result: JNE Successful");
	else
		$display("Incorrect result: JNE Not Successful");
	repeat(2) @(posedge clk);
	
	
	// Less Than Jump
	instruction = 16'b0100110011000001;
	repeat(3) @(posedge clk);
	
	// Compare greater than
	instruction = 16'b0000000110110010; // rsrc > rdst
	repeat(1) @(posedge clk);
	if(addressOut == 16'h0001)
		$display("Correct result: JLT Successful");
	else
		$display("Incorrect result: JLT Not Successful");
	repeat(2) @(posedge clk);
	
	
	// Greater Than Jump
	instruction = 16'b0100011011000001;
	repeat(3) @(posedge clk);
	
	// Filler
	instruction = 16'b0000000110110010;
	repeat(1) @(posedge clk);
	if(addressOut == 16'h0001)
		$display("Correct result: JGT Successful");
	else
		$display("Incorrect result: JGT Not Successful");
	repeat(2) @(posedge clk);
end
endtask

task BranchInstructions;
begin
	// Uncodonditonal Branch 3
	instruction = 16'b1100111000000011;
	repeat(3) @(posedge clk);
	
	// Compare two equals
	instruction = 16'b0000000110110001;
	repeat(1) @(posedge clk);
	if(addressOut == 16'h0005)
		$display("Correct result: BUC Successful");
	else
		$display("Incorrect result: BUC Not Successful");
	repeat(2) @(posedge clk);
	
	
	// Equal Branch 3
	instruction = 16'b1100000000000011;
	repeat(3) @(posedge clk);
	
	// Compare two non-equals
	instruction = 16'b0000010010110001;
	repeat(1) @(posedge clk);
	if(addressOut == 16'h0009)
		$display("Correct result: BEQ Successful");
	else
		$display("Incorrect result: BEQ Not Successful");
	repeat(2) @(posedge clk);
	
	
	// Non-Equal Branch 3
	instruction = 16'b1100000100000011;
	repeat(3) @(posedge clk);
	
	// Compare less than
	instruction = 16'b0000001010110001; // rsrc < rdst
	repeat(1) @(posedge clk);
	if(addressOut == 16'h000d)
		$display("Correct result: BNE Successful");
	else
		$display("Incorrect result: BNE Not Successful");
	repeat(2) @(posedge clk);
	
	
	// Less Than Branch 3
	instruction = 16'b1100110000000011;
	repeat(3) @(posedge clk);
	
	// Compare greater than
	instruction = 16'b0000000110110010; // rsrc > rdst
	repeat(1) @(posedge clk);
	if(addressOut == 16'h0011)
		$display("Correct result: BLT Successful");
	else
		$display("Incorrect result: BLT Not Successful");
	repeat(2) @(posedge clk);
	
	
	// Greater Than Branch 3
	instruction = 16'b1100011000000011;
	repeat(3) @(posedge clk);
	
	// Filler
	instruction = 16'b0000000110110010;
	repeat(1) @(posedge clk);
	if(addressOut == 16'h0015)
		$display("Correct result: BGT Successful");
	else
		$display("Incorrect result: BGT Not Successful");
	repeat(2) @(posedge clk);
end
endtask

endmodule
