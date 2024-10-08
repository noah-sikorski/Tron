/*
This module should take in the output from the instruction register and split it up in to the needed information to be used
in other places thorughout the data path.
*/

module decoder (
    input  [15:0] ir,          // The instruction word from the IR
    output reg [3:0] alu_op,   // Control signals for the ALU operation
    output reg       alu_src,  // Select between register and immediate for ALU source
    output reg       reg_dst,  // Select between rd and rt for register destination
    output reg       reg_write, // Enable signal for writing to register file
    output reg [1:0] shift_op, // Control signal for shifter operation (00 = LSL, 01 = LSR, 10 = ASR, 11 = ROR)
    output reg [3:0] shamt,    // Shift amount for shifter
    output reg       shift_en  // Enable signal for the shifter
);

    // Define opcode constants
    localparam [3:0]
        ADDI_OP  = 4'b0101,
        SUBI_OP  = 4'b1001,
        CMPI_OP  = 4'b1011,
        ANDI_OP  = 4'b0001,
        ORI_OP   = 4'b0010,
        XORI_OP  = 4'b0011,
        MOVI_OP  = 4'b1101,
        LSHI_OP  = 4'b1000,
        LUI_OP   = 4'b1111,
        ADD_OP   = 4'b0000,
        SUB_OP   = 4'b0100,
        CMP_OP   = 4'b0110,
        AND_OP   = 4'b0001,  // Assuming same as ANDI_OP
        OR_OP    = 4'b0010,  // Assuming same as ORI_OP
        XOR_OP   = 4'b0011,  // Assuming same as XORI_OP
        MOV_OP   = 4'b1100,
        LSL_OP   = 4'b0011,  // Logical Shift Left
        LSR_OP   = 4'b0101,  // Logical Shift Right
        ASR_OP   = 4'b0111,  // Arithmetic Shift Right
        ROR_OP   = 4'b1001,
        NOP_OP   = 4'b1110;

    always @(*) begin
        // Default control signals
        alu_op     = 4'b0000;
        alu_src    = 1'b0;
        reg_dst    = 1'b0;
        reg_write  = 1'b0;
        shift_op   = 2'b00;
        shamt      = 4'b0000;
        shift_en   = 1'b0;

        case (ir[15:12]) // Opcode field
            // ALU Instructions
            ADDI_OP: begin
                alu_op     = 4'b0001;  // ALU operation code for ADD
                alu_src    = 1'b1;     // Use immediate value
                reg_dst    = 1'b0;     // Destination register in rt field
                reg_write  = 1'b1;     // Enable register write
            end
            SUBI_OP: begin
                alu_op     = 4'b0010;  // ALU operation code for SUB
                alu_src    = 1'b1;     // Use immediate value
                reg_dst    = 1'b0;     
                reg_write  = 1'b1;
            end
            ANDI_OP: begin
                alu_op     = 4'b0100;  // ALU operation code for AND
                alu_src    = 1'b1;
                reg_dst    = 1'b0;
                reg_write  = 1'b1;
            end
            ORI_OP: begin
                alu_op     = 4'b0101;  // ALU operation code for OR
                alu_src    = 1'b1;
                reg_dst    = 1'b0;
                reg_write  = 1'b1;
            end
            XORI_OP: begin
                alu_op     = 4'b0110;  // ALU operation code for XOR
                alu_src    = 1'b1;
                reg_dst    = 1'b0;
                reg_write  = 1'b1;
            end
            MOVI_OP: begin
                alu_op     = 4'b0111;  // ALU operation code for MOV
                alu_src    = 1'b1;
                reg_dst    = 1'b0;
                reg_write  = 1'b1;
            end

            // Shift Instructions
            LSL_OP: begin
                shift_op   = 2'b00;    // Logical Shift Left
                shamt      = ir[3:0];  // Shift amount from instruction
                shift_en   = 1'b1;     // Enable shifter
                reg_dst    = 1'b0;
                reg_write  = 1'b1;     // Write result to register
            end
            LSR_OP: begin
                shift_op   = 2'b01;    // Logical Shift Right
                shamt      = ir[3:0];  // Shift amount from instruction
                shift_en   = 1'b1;
                reg_dst    = 1'b0;
                reg_write  = 1'b1;
            end
            ASR_OP: begin
                shift_op   = 2'b10;    // Arithmetic Shift Right
                shamt      = ir[3:0];  // Shift amount from instruction
                shift_en   = 1'b1;
                reg_dst    = 1'b0;
                reg_write  = 1'b1;
            end
            ROR_OP: begin
                shift_op   = 2'b11;    // Rotate Right
                shamt      = ir[3:0];  // Shift amount from instruction
                shift_en   = 1'b1;
                reg_dst    = 1'b0;
                reg_write  = 1'b1;
            end

            // Other Instructions (ADD, SUB, etc.)
            ADD_OP: begin
                alu_op     = 4'b0001;  // ALU operation code for ADD
                alu_src    = 1'b0;     // Use register value
                reg_dst    = 1'b1;     // Destination register in rd field
                reg_write  = 1'b1;
            end
            SUB_OP: begin
                alu_op     = 4'b0010;  // ALU operation code for SUB
                alu_src    = 1'b0;
                reg_dst    = 1'b1;
                reg_write  = 1'b1;
            end
            // Include other instructions similarly
            NOP_OP: begin
                // NOP operation; do nothing
                alu_op     = 4'b0000;
                alu_src    = 1'b0;
                reg_dst    = 1'b0;
                reg_write  = 1'b0;
            end
            default: begin
                // Undefined opcode; default control signals
                alu_op     = 4'b0000;
                alu_src    = 1'b0;
                reg_dst    = 1'b0;
                reg_write  = 1'b0;
            end
        endcase
    end

endmodule
