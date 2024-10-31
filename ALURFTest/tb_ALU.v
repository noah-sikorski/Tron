/*
Testbench for the ALU module.
Verifies different ALU operations including addition, subtraction, AND, OR, and XOR.
Each instruction is tested 1000 times with random values for the input registers.
*/
module tb_ALU();

integer i; // Loop variable for test iterations

reg [15:0] reg1, reg2; // 16-bit registers for ALU operands
reg [3:0] inst;  // 4-bit instruction for ALU operation
wire [15:0] result, flagreg; // ALU result and flag register output

// Instantiate the ALU
ALU UUT(
    .reg1(reg1),
    .reg2(reg2),
    .inst(inst),
    .result(result),
    .flagreg(flagreg)
);

// Test addition
initial begin
    // Test signed addition
    for(i = 0; i < 1000; i = i + 1) begin
        #1;
        inst = 4'b0000;  // Addition instruction
        reg1 = $signed($urandom % 10); // Random operand 1
        reg2 = $signed($urandom % 10); // Random operand 2
        #10; // Wait for result
        // Verify result and flags
        if ((result != reg1 + reg2) || 
            (flagreg[2] != ((reg2[15] == reg1[15]) && (result[15] != reg1[15]))) || 
            (flagreg[4] != result[15]) || 
            (flagreg[3] != (result == 0))) begin
            #1; $display("FAILURE");  
            #1; $display("inst: %b, reg1: %d, reg2: %d, result: %d", inst, reg1, reg2, result);
            $stop;
        end 
    end
    #1; $display("Complete Addition: Success"); #1;


// Test subtraction
    for(i = 0; i < 1000; i = i + 1) begin
        #1;
        inst = 4'b1000;  // Subtraction instruction
        reg1 = $signed($urandom % 10); // Random operand 1
        reg2 = $signed($urandom % 10); // Random operand 2
        #10; // Wait for result
        // Verify result and flags
        if ((result != reg1 - reg2) || 
            (flagreg[2] != ((reg2[15] == reg1[15]) && (result[15] != reg1[15]))) || 
            (flagreg[4] != result[15]) || 
            (flagreg[3] != (result == 0))) begin
            #1; $display("FAILURE");  
            #1; $display("Expected: %d", reg1 - reg2); 
            #1; $display("inst: %b, reg1: %d, reg2: %d, result: %d", inst, reg1, reg2, result);
            $stop;
        end 
    end
    #1; $display("Complete Subtraction: Success"); #1;

// Test AND operation
    for(i = 0; i < 1000; i = i + 1) begin
        #1;
        inst = 4'b0001;  // AND instruction
        reg1 = $urandom % 10; // Random operand 1
        reg2 = $urandom % 10; // Random operand 2
        #10; // Wait for result
        // Verify result and zero flag
        if ((result != (reg1 & reg2)) || 
            (flagreg[3] != (result == 0))) begin
            #1; $display("FAILURE");  
            #1; $display("inst: %b, reg1: %d, reg2: %d, result: %d", inst, reg1, reg2, result);
            $stop;
        end 
    end
    #1; $display("Complete AND instruction: Success"); #1;


    // Test bitwise OR operation
    for(i = 0; i < 1000; i = i + 1) begin
        #1;
        inst = 4'b0010;  // OR instruction
        reg1 = $urandom % 10; // Random operand 1
        reg2 = $urandom % 10; // Random operand 2
        #10; // Wait for result
        // Verify result and zero flag
        if ((result != (reg1 | reg2)) || 
            (flagreg[3] != (result == 0))) begin
            #1; $display("FAILURE");  
            #1; $display("inst: %b, reg1: %d, reg2: %d, result: %d", inst, reg1, reg2, result);
            $stop;
        end 
    end
    #1; $display("Complete OR instruction: Success"); #1;

// Test XOR operation
    // Test bitwise XOR operation
    for(i = 0; i < 1000; i = i + 1) begin
        #1;
        inst = 4'b0011;  // XOR instruction
        reg1 = $urandom % 10; // Random operand 1
        reg2 = $urandom % 10; // Random operand 2
        #10; // Wait for result
        // Verify result and zero flag
        if ((result != (reg1 ^ reg2)) || 
            (flagreg[3] != (result == 0))) begin
            #1; $display("FAILURE");  
            #1; $display("inst: %b, reg1: %d, reg2: %d, result: %d", inst, reg1, reg2, result);
            $stop;
        end 
    end
    #1; $display("Complete XOR instruction: Success"); #1;
end

endmodule
