`timescale 1ns/1ps
module clock_tb;
    reg clk;
    reg rst;
    reg start;
    reg stop;
    wire [7:0] seg_ones;
    wire [7:0] seg_tens;
    wire running;
    clock uut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .stop(stop),
        .seg_ones(seg_ones),
        .seg_tens(seg_tens),
        .running(running)
    );
    initial begin
        clk = 0;
        forever #10 clk = ~clk;
    end
    initial begin
        rst   = 1;
        start = 0;
        stop  = 0;
        #200       rst = 0;
        #200       rst = 1;
        #200       rst = 0;
        #200       start = 1;
        #200       start = 0;
        #50000000  stop = 1;
        #200       stop = 0;
        #200000000 $finish;
    end
initial begin
    $dumpfile("tb.vcd");
    $dumpvars(0, clock_tb);
end
endmodule

