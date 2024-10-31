/*
Module to Test ALU and Registers file together.
*/
module tb_ALU_RF();

// Declare registers for inputs and wires for outputs
reg clk;                    // Clock signal
reg regwrite;               // Control signal to write to registers
reg [4:0] ra1;              // First register address
reg [4:0] ra2;              // Second register address
reg [3:0] inst;             // Instruction to execute
wire [15:0] result;         // ALU result output
wire [15:0] flagreg;        // Flags output

// Instantiate the ALU_RF module under test (UUT)
ALU_RF UUT(
	.clk(clk),
	.regwrite(regwrite),
	.ra1(ra1),
	.ra2(ra2),
	.inst(inst),
	.result(result),
	.flagreg(flagreg)
);

// Clock generation block
initial begin
	clk = 0;                 // Initialize clock signal to 0
	forever #5 clk = ~clk;   // Toggle clock every 5 time units
end

// Main test sequence
initial begin
	overflowDetection;       // Test for overflow detection
	lowflagDetection;        // Test for low flag detection
	FFlagDection;            // Test for F flag detection
	ZflagDetection;          // Test for zero flag detection
	NFlagDetection;          // Test for negative flag detection
	ORInstr;                 // Test for OR instruction
	XORInstr;                // Test for XOR instruction
	StoringData;             // Test for storing data in the register file
	$display("complete simulation");
end

// Task to test overflow detection
task overflowDetection;
	begin
		inst = 4'b0000;
		ra1 = 5'b00001;
		ra2 = 5'b00010;
		regwrite = 0;
		#10;
		if((result != 16'b000000000000000) || (flagreg[0] != 1)) begin
			  #1; $display("FAILURE"); #1;  
			  $display("inst:%b, reg1:%b, reg2:%b, result:%b, overflow value:%b",
			  inst, UUT.rd1, UUT.rd2, result, flagreg[0]);
              		  $stop;
		end
	end
endtask

// Task to test low flag detection
task lowflagDetection;
	begin
		inst = 4'b0000;
		ra1 = 5'b00011;
		ra2 = 5'b00100;
		regwrite = 0;
		#10;
		if((result != 16'b1000000000000001) || (flagreg[1] != 1)) begin
			#1; $display("FAILURE"); #1;  
			$display("inst:%b, reg1:%b, reg2:%b, result:%b, lowflag value:%b",
			inst, UUT.rd1, UUT.rd2, result, flagreg[1]);
            		$stop;
		end
	end
endtask

// Task to test F flag detection
task FFlagDection;
	begin
	  inst = 4'b1000;
	  ra1 = 5'b00101;
	  ra2 = 5'b00110;
	  regwrite = 0;
	  #10;
	  if(result != 16'b0000000000000000 || flagreg[2] != 1) begin
			#1; $display("FAILURE"); #1;  
			$display("inst:%b, reg1:%b, reg2:%b, result:%b, fflag value:%b",
			inst, UUT.rd1, UUT.rd2, result, flagreg[2]);
            		$stop;
	  end
	end
endtask

// Task to test zero flag detection
task ZflagDetection;
	begin
		inst = 4'b0001;
		ra1 = 5'b00111;
		ra2 = 5'b01000;
		regwrite = 0;
		#5;
		if(flagreg[3] != 1) begin
			#1; $display("FAILURE"); #1;  
			$display("inst:%b, reg1:%b, reg2:%b, result:%b, zflag value:%b",
			inst, UUT.rd1, UUT.rd2, result, flagreg[3]);
            		$stop;
		end
	end
endtask	

// Task to test negative flag detection
task NFlagDetection;
	begin
		inst = 4'b0000;
		ra1 = 5'b01001;
		ra2 = 5'b01010;
		regwrite = 0;
		#5;
		if(flagreg[4] != 1) begin
			#1; $display("FAILURE"); #1;  
			$display("inst:%b, reg1:%b, reg2:%b, result:%b, Nflag value:%b",
			inst, UUT.rd1, UUT.rd2, result, flagreg[4]);
            		$stop;
		end
	end
endtask

// Task to test OR instruction
task ORInstr;
	begin
		inst = 4'b0010;
		ra1 = 5'b01011;
		ra2 = 5'b01100;
		regwrite = 0;
		#5;
		if(result != 16'b1111111111111111) begin
			#1; $display("FAILURE"); #1;  
			$display("inst:%b, reg1:%b, reg2:%b, result:%b",
			inst, UUT.rd1, UUT.rd2, result);
            		$stop;
		end
	end
endtask

// Task to test XOR instruction
task XORInstr;
	begin
		inst = 4'b0010;
		ra1 = 5'b01101;
		ra2 = 5'b01110;
		regwrite = 0;
		#5;
		if(result != 16'b1111111111111111) begin
			#1; $display("FAILURE"); #1;  
			$display("inst:%b, reg1:%b, reg2:%b, result:%b",
			inst, UUT.rd1, UUT.rd2, result);
            $stop;
		end
	end
endtask

// Task to test data storage in the register file
task StoringData;
	begin
		inst = 4'b0010;
		ra1 = 5'b01101;
		ra2 = 5'b01110;
		regwrite = 1;
		repeat(1)@(posedge clk)
		regwrite = 0;
		repeat(1)@(posedge clk)
		if(UUT.rd2 != 16'b1111111111111111) begin
			#1; $display("FAILURE"); #1;  
			$display("inst:%b, reg1:%b, reg2:%b, result:%b",
			inst, UUT.rd1, UUT.rd2, result);
         		$stop;
		end
	end
endtask
	
endmodule
