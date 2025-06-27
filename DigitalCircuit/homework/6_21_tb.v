`timescale 1ns/1ps

module T6_21_tb;
    reg X;
    reg CP;
    reg CLR;
    wire F;
    wire [1:0] Q;
    T6_21 dut (
        .X(X),
        .CP(CP),
        .CLR(CLR),
        .F(F),
        .Q(Q)
    );
    initial begin
        CP = 0;
        forever #5 CP = ~CP;
    end
    initial begin
        $dumpfile("tb.vcd");
        $dumpvars(0, T6_21_tb);
        CLR = 0;
        X = 0;
        #10 CLR = 1;
        #10 X = 1;
        #10 X = 0;
        #10 X = 1;
        #10 X = 0;
        #20 X = 1;
        #20 X = 0;
        #100 $finish;
    end
endmodule
