module datapath_top #(parameter WIDTH=16, REGBITS=4) (
    input             clk,         // System clock
    input             reset,       // Synchronous reset
    input             pc_write_en, // Program Counter write enable
    input             pc_src_sel,  // PC Source select for jump/branch
    input             alu_src,     // ALU MUX control (0 = reg data, 1 = immediate)
    input             reg_dst,     // Register destination MUX control
    input             reg_write,   // Register file write enable
    input             ir_load,     // Instruction register load enable
    input  [3:0]      alu_op,      // ALU operation select
    input  [WIDTH-1:0] mem_in,     // Input data from memory
    output [WIDTH-1:0] mem_out,    // Output data to memory
    output [WIDTH-1:0] addr,       // Memory address
    output [WIDTH-1:0] ir_out      // Output of instruction register
);

    // Internal signals
    wire [WIDTH-1:0] pc_in, pc_out, alu_result, alu_src_b, reg_data1, reg_data2, wd, imm_ext, next_pc;
    wire [REGBITS-1:0] wa, ra1, ra2;

    // Program Counter (PC)
    // PC register with enable and reset
    flopenr #(WIDTH) PC_reg (
        .clk(clk),
        .reset(reset),
        .en(pc_write_en),
        .d(pc_in),       // New PC value from next_pc
        .q(pc_out)       // Current PC value
    );
    
    // Next PC logic: MUX to select either PC+4 or ALU result for jump/branch
    assign next_pc = (pc_src_sel) ? alu_result : pc_out + 16'd2; // Example: PC incremented by 2 for word-addressing
    
    // PC input for writing to PC register
    assign pc_in = next_pc;  // Feed selected next PC value

    // Instruction Register (IR)
    // Instruction register to load from memory
    flopenr #(WIDTH) IR_reg (
        .clk(clk),
        .reset(reset),
        .en(ir_load),
        .d(mem_in),      // Instruction from memory
        .q(ir_out)       // Output instruction for decoding
    );

    // Sign Extension Unit
    assign imm_ext = {{8{ir_out[7]}}, ir_out[7:0]};  // Sign extend 8-bit immediate to 16 bits

    // Register File (RF)
    assign ra1 = ir_out[11:8];  // Register address 1
    assign ra2 = ir_out[7:4];   // Register address 2
    assign wa  = (reg_dst) ? ir_out[3:0] : ir_out[7:4]; // Write address based on reg_dst

    Registers rf (
        .clk(clk),
        .regwrite(reg_write),
        .ra1(ra1),
        .ra2(ra2),
        .wd(wd),
        .rd1(reg_data1),   // Output from RF, connected to ALU input
        .rd2(reg_data2)    // Output from RF, connected to ALU input
    );

    // ALU Source MUX: Select between reg_data2 and immediate (imm_ext)
    assign alu_src_b = (alu_src) ? imm_ext : reg_data2;

    // ALU
    ALU alu (
        .reg1(reg_data1),     // First input from register file
        .reg2(alu_src_b),     // Second input from register file or immediate
        .inst(alu_op),        // ALU operation from control unit
        .result(alu_result),  // ALU result
        .flagreg()            // Ignored for now
    );

    // Data Output Flip-Flop (for memory writes)
    flopenr #(WIDTH) DOUT_reg (
        .clk(clk),
        .reset(reset),
        .en(reg_write),
        .d(reg_data2),  // Data from register to be written to memory
        .q(mem_out)     // Data output to memory
    );

    // Address Flip-Flop (for memory accesses)
    flopenr #(WIDTH) ADDR_reg (
        .clk(clk),
        .reset(reset),
        .en(pc_write_en),
        .d(alu_result),  // Address calculated by the ALU
        .q(addr)         // Output address for memory access
    );

endmodule
