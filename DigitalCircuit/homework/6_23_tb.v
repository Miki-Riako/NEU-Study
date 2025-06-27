`timescale 1ns/1ps

module T6_23_tb;
    reg X;
    reg CLK;
    reg CLRn;
    wire Z;
    wire [2:0] Q;
    T6_23 uut (
        .X(X),
        .CLK(CLK),
        .CLRn(CLRn),
        .Z(Z),
        .Q(Q)
    );
    initial begin
        CLK = 0;
        forever #20 CLK = ~CLK;
    end
    initial begin
        X = 0;
        CLRn = 0;
        $dumpfile("tb.vcd");
        $dumpvars(0, T6_23_tb);
        #10 CLRn = 1;
        #40 X = 1;
        #240 X = 0;
        #80 X = 1;
        #80 X = 0;
        #40 X = 1;
        #180 X = 0;
        #40 X = 1;
        #90 $finish;
    end
endmodule
