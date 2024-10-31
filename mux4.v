module mux4(
    input  [15:0] register,      // Input from register file
    input  [15:0] dataMem,     // Input from data memory
    input  [15:0] ALUResult,      // Input from ALU result
    input  [15:0] shifterResult,  // Input from shifter result
    input  [2:0]  selector,   // Selector signal for choosing the input
    output reg [15:0] dataOut // Selected output
);

    // Define selector values for different inputs
	 parameter ALUFF_sel    = 2'b00;
	 parameter shifterFF_sel = 2'b01;
    parameter regFF_sel    = 2'b10;
    parameter dataFF_sel   = 2'b11;
   

    // MUX selection logic
    always @(*) begin
        case (selector)
            regFF_sel:    dataOut = register;       // Select register file data
            dataFF_sel:   dataOut = dataMem;      // Select data from memory
            ALUFF_sel:    dataOut = ALUResult;       // Select ALU result
            shifterFF_sel: dataOut = shifterResult;  // Select shifter result
            default:      dataOut = 16'b0;       // Default to 0
        endcase
    end

endmodule