`timescale 1ns / 1ps
module ex_counter_tb;
    reg clk;
    reg rst;
    reg start;
    reg stop;
    reg mode;
    reg set_value;
    reg [5:0] value;
    wire [3:0] sec_ones;
    wire [3:0] sec_tens;
    wire running_flag;
    wire led_blink;
    ex_counter uut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .stop(stop),
        .mode(mode),
        .set_value(set_value),
        .value(value),
        .sec_ones(sec_ones),
        .sec_tens(sec_tens),
        .running_flag(running_flag),
        .led_blink(led_blink)
    );
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    initial begin
        rst = 1;
        start = 0;
        stop = 0;
        mode = 0;
        set_value = 0;
        value = 6'd0;
        #10;  rst = 0; set_value = 1; value = 6'd15;
        #10;  set_value = 0; start = 1;
        #10;  start = 0;
        #500; stop = 1;
        #10;  stop = 0; rst = 1;
        #10;  rst = 0; mode = 1; start = 1;
        #10;  start = 0;
        #500; $finish;
    end
    initial begin
        $dumpfile("tb.vcd");
        $dumpvars(0, ex_counter_tb);
    end
endmodule
