module Counter30(
    input wire clk,
    input wire reset,
    output reg [5:0] count
);
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            count <= 6'd29;
        end else begin
            if (count == 6'd0) begin
                count <= 6'd29;
            end else begin
                count <= count - 1;
            end
        end
    end
endmodule
