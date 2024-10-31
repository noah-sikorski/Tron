/*
-----------------------------------------------------------------------------------
Module: FSM (Finite State Machine for Datapath Control)
-----------------------------------------------------------------------------------
Description:
This FSM controls the flow of the datapath in the CPU. It transitions through four 
states: Fetch, Decode, Execute, and PCUpdate. The primary function of the FSM is to 
assert control signals (such as IR_load) during different stages of the instruction 
cycle to ensure correct operation of the datapath.

State Descriptions:
1. Fetch: The FSM asserts IR_load to load the instruction from memory into the 
          Instruction Register (IR).
2. Decode: The instruction in the IR is decoded in this state.
3. Execute: The instruction is executed in this state (ALU operations, shifts, etc.).
4. PCUpdate: The Program Counter (PC) is updated in this state for the next instruction.

The FSM cycles through these states in a loop, allowing for continuous execution of
instructions.

Inputs:
- clk: System clock
- reset: Synchronous reset signal (active low)

Outputs:
- IR_load: Control signal to load the Instruction Register (IR)

-----------------------------------------------------------------------------------
*/

module FSM (
    input  wire clk,         // System clock
    input  wire reset,       // Active-low reset signal
    output reg IR_load       // Control signal to load Instruction Register (IR)
);

    // Define states as 4-bit parameters
    parameter Fetch    = 4'b0001;  // Fetch instruction from memory
    parameter Decode   = 4'b0010;  // Decode the fetched instruction
    parameter Execute  = 4'b0011;  // Execute the instruction
    parameter PCUpdate = 4'b0100;  // Update Program Counter (PC) for next instruction

    // State registers for holding current and next states
    reg [3:0] state, nextstate;

    // Synchronous state transition on clock edge or reset
    always @(posedge clk) begin
        if (~reset) 
            state <= Fetch;  // Start in Fetch state after reset
        else 
            state <= nextstate;  // Transition to the next state
    end

    // Next state logic (determines what the next state will be)
    always @(*) begin
        case(state)
            Fetch:    nextstate <= Decode;     // Move from Fetch to Decode
            Decode:   nextstate <= Execute;    // Move from Decode to Execute
            Execute:  nextstate <= PCUpdate;   // Move from Execute to PCUpdate
            PCUpdate: nextstate <= Fetch;      // After PC update, go back to Fetch
            default:  nextstate <= Fetch;      // Default state is Fetch
        endcase
    end

    // Output logic (controls what happens in each state)
    always @(*) begin
        case(state)
            Fetch: begin
                IR_load = 1;  // Load instruction into IR during Fetch
            end

            Decode: begin
                IR_load = 0;  // Disable IR load during Decode
            end

            Execute: begin
                IR_load = 0;  // No IR load during Execute
            end

            PCUpdate: begin
                IR_load = 0;  // No IR load during PC update
            end

            default: begin
                IR_load = 0;  // Default case, IR load is disabled
            end
        endcase
    end

endmodule
