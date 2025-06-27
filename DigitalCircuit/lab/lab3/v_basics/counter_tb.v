`timescale 1ns / 1ps
module counter_tb;
    reg clk;
    reg rst;
    reg start;
    reg stop;
    wire [3:0] sec_ones;
    wire [3:0] sec_tens;
    wire running_flag;
    counter uut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .stop(stop),
        .sec_ones(sec_ones),
        .sec_tens(sec_tens),
        .running_flag(running_flag)
    );
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    initial begin
        rst = 1;
        start = 0;
        stop = 0;
        #10;   rst = 0;
        #10;   start = 1;
        #10;   start = 0;
        #1000; stop = 1;
        #10;   stop = 0;
        #100;  rst = 1;
        #10;   rst = 0; start = 1;
        #10;   start = 0;
        #1000;
        $finish;
    end
    initial begin
        $dumpfile("tb.vcd");
        $dumpvars(0, counter_tb);
    end
endmodule
