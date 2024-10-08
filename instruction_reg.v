/*
This is the instruciton register (IR) and it is responsible for loading the value of an instruciton in memory from the
memory data register (MDR) and ourputting it to the ALU.
*/

module instruction_reg(
    input  wire        clk,        // System clock
    input  wire        reset,      // Synchronous reset
    input  wire        IR_load,    // Control signal to load IR
    input  wire [15:0] MDR_data,   // Data input from MDR
    output reg  [15:0] IR_out      // Output of the instruction register
);

/*
This always block sets the output value of the IR to be 0 if reset is pressed or, if enabled, it writes the instruction
held in MDR to the output.
*/
    always @(posedge clk) begin
        if (reset) begin
            IR_out <= 16'b0;
        end else if (IR_load) begin
            IR_out <= MDR_data;
        end
    end

endmodule