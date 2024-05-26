module ex_clock (
    input wire clk,
    input wire rst,
    input wire start,
    input wire stop,
    input wire mode_btn,
    input wire [5:0] value,
    output reg [7:0] seg_ones,
    output reg [7:0] seg_tens,
    output wire running,
    output wire mode_flag,
    output wire led_blink
);
    wire clk_1hz;
    wire [3:0] sec_ones;
    wire [3:0] sec_tens;

    reg mode;
    reg prev_mode_btn;
    reg set_value;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            mode <= 1'b1;
            prev_mode_btn <= 1'b0;
            set_value <= 1'b1;
        end else begin
            if (mode_btn && !prev_mode_btn) begin
                mode <= ~mode;
                set_value <= 1'b1;
            end else begin
                set_value <= 1'b0;
            end
            prev_mode_btn <= mode_btn;
        end
    end

    divider u1 (
        .clk(clk),
        .rst(rst),
        .clk_out(clk_1hz)
    );

    ex_counter u2 (
        .clk(clk_1hz),
        .rst(rst),
        .start(start),
        .stop(stop),
        .mode(mode),
        .set_value(set_value),
        .value(value),
        .sec_ones(sec_ones),
        .sec_tens(sec_tens),
        .running_flag(running),
        .led_blink(led_blink)
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

    assign mode_flag = mode;
endmodule
