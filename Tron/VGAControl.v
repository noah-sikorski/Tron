/*

*/
module VGAControl (
input reset,
input clk,

output reg hSync,
output reg vSync,
output reg bright,

output reg [15:0] hCount,
output reg [15:0] vCount
);

always @(posedge clk) begin
    if (~reset) begin
        hCount <= 0;
        vCount <= 0;
    end

    if (vCount < 2) begin
        vSync <= 0;
    end else begin
        vSync <= 1;
    end

    if (hCount < 96) begin
        if (vCount >= 479)
            vCount <= 0;
        hSync <= 0;
        bright <= 0;
        hCount <= hCount + 1;

    end else if (hCount < 144) begin
        hSync <= 1;
        bright <= 0;
        hCount <= hCount + 1;
    end

    else if (hCount < 784) begin
        bright <= 1;
        hCount <= hCount + 1;
    end

    else if (hCount < 800) begin
        bright <= 0;
        if (hCount >= 799) begin
            hCount <= 0;
            vCount <= vCount + 1;
        end else begin
            hCount <= hCount + 1;
        end
    end
end

endmodule
