module tb_controller_dataPath();
reg clk;
reg reset;
reg [15:0] instruction;
wire [15:0] addressOut;
wire [15:0] busOutput;

controller_dataPath UUT(
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
	additionInstruction;
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


task additionInstruction;
begin
    reset = 1;
    instruction = 16'b0000000101010010;
    repeat(3) @(posedge clk);
    ResetInstruction;
end
endtask

task MOVInstruction;
begin
    reset = 1;
    instruction = 16'b0000000111010101;
    repeat(3) @(posedge clk);
    ResetInstruction;
end
endtask

task ANDInstruction;
begin
    instruction = 16'b0001000111111110;
    repeat(3) @(posedge clk);
    ResetInstruction;
end
endtask

task ADDIInstruction;
begin
    instruction = 16'b0101000110010011;
    repeat(3) @(posedge clk);
    ResetInstruction;
end
endtask

task SubInstruction;
begin
    instruction = 16'b0000000110010010;
    repeat(3) @(posedge clk);
    ResetInstruction;
end
endtask

task SubIInstruction;
begin
    instruction = 16'b1001000100000001;
    repeat(3) @(posedge clk);
    ResetInstruction;
end
endtask

task CMPInstruction;
begin
    instruction = 16'b0000000110110001;
    repeat(3) @(posedge clk);
    ResetInstruction;
end
endtask

task CMPIInstruction;
begin
    instruction = 16'b1011000100000010;
    repeat(3) @(posedge clk);
    ResetInstruction;
end
endtask

task ANDIInstruction;
begin
    instruction = 16'b0001000111110010;
    repeat(3) @(posedge clk);
    ResetInstruction;
end
endtask

task ORInstruction;
begin
    instruction = 16'b0000000100100010;
    repeat(3) @(posedge clk);
    ResetInstruction;
end
endtask

task ORIInstruction;
begin
    instruction = 16'b0010000100001110;
    repeat(3) @(posedge clk);
    ResetInstruction;
end
endtask

task XORInstruction;
begin
    instruction = 16'b0000000100111110;
    repeat(3) @(posedge clk);
    ResetInstruction;
end
endtask

task XORIInstruction;
begin
    instruction = 16'b0011000100001110;
    repeat(3) @(posedge clk);
    ResetInstruction;
end
endtask

task LSHInstruction;
begin
    instruction = 16'b1000000101000001;
    repeat(3) @(posedge clk);
    ResetInstruction;
end
endtask

task LSHI0Instruction;
begin
    instruction = 16'b1000000100000001;


    repeat(3) @(posedge clk);
    ResetInstruction;
end
endtask

task LSHI1Instruction;
begin
    instruction = 16'b1000000100010001;
    repeat(3) @(posedge clk);
    ResetInstruction;
end
endtask

task LUIInstruction;
begin
    instruction = 16'b1111000100000001;
    repeat(3) @(posedge clk);
    ResetInstruction;
end
endtask

endmodule


