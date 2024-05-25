module clock (
    input wire clk,
    input wire rst,
    input wire start,
    input wire stop,
    output reg [7:0] seg_ones,
    output reg [7:0] seg_tens,
    output wire running
);
    wire clk_1hz;
    wire [3:0] sec_ones;
    wire [3:0] sec_tens;
    
    divider u1 (
        .clk(clk),
        .rst(rst),
        .clk_out(clk_1hz)
    );
    counter u2 (
        .clk(clk_1hz),
        .rst(rst),
        .start(start),
        .stop(stop),
        .sec_ones(sec_ones),
        .sec_tens(sec_tens),
        .running_flag(running)
    );

    wire [7:0] seg_ones_wire;
    wire [7:0] seg_tens_wire;
    bit_to_7seg dpy_ones (
        .ctrl(1'b0),
        .bit(sec_ones),
        .seg(seg_ones_wire)
    );
    bit_to_7seg dpy_tens (
        .ctrl(1'b0),
        .bit(sec_tens),
        .seg(seg_tens_wire)
    );
    
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            seg_ones <= 8'b00000000;
            seg_tens <= 8'b00000000;
        end else begin
            seg_ones <= seg_ones_wire;
            seg_tens <= seg_tens_wire;
        end
    end
endmodule