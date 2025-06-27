`timescale 1ns / 1ps

module tb_Traffic_Controller;
    reg clk;
    reg reset;
    reg AS;
    reg BS;
    reg [5:0] countdown;
    wire AG;
    wire AY;
    wire AR;
    wire BG;
    wire BY;
    wire BR;

    Traffic_Controller uut (
        .clk(clk), 
        .reset(reset), 
        .AS(AS), 
        .BS(BS), 
        .countdown(countdown), 
        .AG(AG), 
        .AY(AY), 
        .AR(AR), 
        .BG(BG), 
        .BY(BY), 
        .BR(BR)
    );

    initial begin
        clk = 0;
        reset = 0;
        AS = 0;
        BS = 0;
        countdown = 6'd30;

        #5 reset = 1;
        #10 reset = 0;
        #50 AS = 1; countdown = 6'd3;
        #20 AS = 0; countdown = 6'd0;
        #50 BS = 1; countdown = 6'd3;
        #20 BS = 0; countdown = 6'd0;
        #200 $finish;
    end

    always #5 clk = ~clk;
    initial begin
        $dumpfile("tb.vcd");
        $dumpvars(0, tb_Traffic_Controller);
    end
endmodule
