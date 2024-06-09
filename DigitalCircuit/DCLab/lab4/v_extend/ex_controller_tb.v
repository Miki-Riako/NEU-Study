`timescale 1ns / 1ps

module tb_Traffic_Controller;
    reg clk;
    reg reset;
    reg ctrl_btn;
    wire [5:0] countdown;
    wire AG;
    wire AY;
    wire AR;
    wire AL;
    wire BG;
    wire BY;
    wire BR;
    wire BL;

    Traffic_Controller uut (
        .clk(clk), 
        .reset(reset), 
        .ctrl_btn(ctrl_btn), 
        .countdown(countdown), 
        .AG(AG), 
        .AY(AY), 
        .AR(AR), 
        .AL(AL), 
        .BG(BG), 
        .BY(BY), 
        .BR(BR), 
        .BL(BL)
    );

    initial begin
        clk = 0;
        reset = 0;
        ctrl_btn = 0;
        #5 reset = 1;
        #10 reset = 0;
        #2000 $finish;
    end
    always #5 clk = ~clk;
    initial begin
        $dumpfile("tb.vcd");
        $dumpvars(0, tb_Traffic_Controller);
    end
endmodule
