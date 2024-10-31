module mux5(
    input  [15:0] register,      // Input from register file
    input  [15:0] dataMem,     // Input from data memory
    input  [15:0] ALUResult,      // Input from ALU result
    input  [15:0] shifterResult,  // Input from shifter result
	 input  [15:0] pcValue,
    input  [2:0]  selector,   // Selector signal for choosing the input
    output reg [15:0] dataOut // Selected output
);

    // Define selector values for different inputs
	 parameter ALUFF_sel    = 3'b000;
	 parameter shifterFF_sel = 3'b001;
    parameter regFF_sel    = 3'b010;
    parameter dataFF_sel   = 3'b011;
	 parameter pc_sel = 3'b100;
   

    // MUX selection logic
    always @(*) begin
        case (selector)
            regFF_sel:    dataOut <= register;       // Select register file data
            dataFF_sel:   dataOut <= dataMem;      // Select data from memory
            ALUFF_sel:    dataOut <= ALUResult;       // Select ALU result
            shifterFF_sel: dataOut <= shifterResult;  // Select shifter result
				pc_sel: dataOut <= pc_sel;
            default:      dataOut <= 16'b0;       // Default to 0
        endcase
    end

endmodule