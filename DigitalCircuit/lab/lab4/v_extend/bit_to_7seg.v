module bit_to_7seg (
    input wire ctrl,
    input wire [3:0] bit,
    output reg [7:0] seg
);
    always @(*) begin
        if (ctrl) begin
            seg = 8'b00000000;
        end else begin
            case (bit)
                4'b0000: seg = 8'b01111110;
                4'b0001: seg = 8'b00010010;
                4'b0010: seg = 8'b10111100;
                4'b0011: seg = 8'b10110110;
                4'b0100: seg = 8'b11010010;
                4'b0101: seg = 8'b11100110;
                4'b0110: seg = 8'b11101110;
                4'b0111: seg = 8'b00110010;
                4'b1000: seg = 8'b11111110;
                4'b1001: seg = 8'b11110110;
                4'b1010: seg = 8'b11111010;
                4'b1011: seg = 8'b11001110;
                4'b1100: seg = 8'b10001100;
                4'b1101: seg = 8'b10011110;
                4'b1110: seg = 8'b11101100;
                4'b1111: seg = 8'b11101000;
                default: seg = 8'b00000000;
            endcase
        end
    end
endmodule
