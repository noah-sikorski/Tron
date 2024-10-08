/*
This module should take in the output from the instruction register and split it up in to the needed information to be used
in other places thorughout the data path.
*/

module decoder (
    input [15:0] ir,         // The instruction word from the IR
    output reg [3:0] alu_op, // Control signals for the ALU operation
    output reg mux_select,   // Control for mux to select data sources
    output reg reg_write_en  // Enable signal for writing to register files
);

always @(*) begin
    case (ir[15:12]) // Opcode field
	 // XX I am unsure of how the muxes need to be enabled but I imagine it will depend on our controller?
	 
        4'b0001: begin // ADD instruction
            alu_op = 4'b0001;  // ALU set to add
            mux_select = 1'b0; // Mux set to pass register data
            reg_write_en = 1'b1; // Enable writing to destination register
        end
        4'b0010: begin // SUB instruction
            alu_op = 4'b0010;  // ALU set to subtract
            mux_select = 1'b0; // Mux set to pass register data
            reg_write_en = 1'b1; // Enable writing to destination register
        end
        // XX We need to add the other instructions 
        default: begin
            alu_op = 4'b0000;  // Default no-op
            mux_select = 1'b0; // Default mux state
            reg_write_en = 1'b0; // Disable register write
        end
    endcase
end

endmodule
