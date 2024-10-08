/*
This module takes in an instruction, extends the immediate 
as needed and returns the immediate after extending.
*/
module SignExtension #(parameter WIDTH=16)(
input [WIDTH-1:0] inst,
output wire [WIDTH-1:0] result
);

parameter ADDI_OP = 0101; // Sign Extended
parameter SUBI_OP = 1001; // Sign Extended
parameter CMPI_OP = 1011; // Sign Extended
parameter ANDI_OP = 0001; // Zero Extended
parameter ORI_OP  = 0010; // Zero Extended
parameter XORI_OP = 0011; // Zero Extended
parameter MOVI_OP = 1101; // Zero Extended
parameter LSHI_OP = 1000; // ???
parameter LUI_OP  = 1111; // ???

wire[3:0] opcode = inst[15:12];
wire SignExtension;
assign SignExtension = (opcode == ADDI_OP) || (opcode == SUBI_OP) || (opcode == CMPI_OP);

assign result = SignExtension ? {{8{inst[7]}}, inst[7:0]} : {8'b0, inst[7:0]};

endmodule
