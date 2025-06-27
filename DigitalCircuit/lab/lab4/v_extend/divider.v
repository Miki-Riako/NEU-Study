module divider (
    input wire clk,
    input wire rst,
    output reg clk_out
);
    reg [25:0] counter;
    // Divider to 50,000,000 times
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            counter <= 26'd0;
            clk_out <= 1'b0;
        end else begin
            if (counter == 26'd24999999) begin
                counter <= 26'd0;
                clk_out <= ~clk_out;
            end else begin
                counter <= counter + 1;
            end
        end
    end
endmodule
