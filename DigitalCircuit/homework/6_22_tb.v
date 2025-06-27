`timescale 1ns/1ps

module T6_22_tb;
    reg X;
    reg CP;
    reg CLR;
    wire F;
    wire [1:0] Q;
    T6_22 dut (
        .X(X),
        .CP(CP),
        .CLR(CLR),
        .F(F),
        .Q(Q)
    );
    initial begin
        CP = 0;
        forever #20 CP = ~CP;
    end
    initial begin
        X = 0;
        CLR = 0;
        $dumpfile("tb.vcd");
        $dumpvars(0, T6_22_tb);
        #10 CLR = 1;
        #230 X = 1;
        #200 X = 0;
        #60 $finish;
    end
endmodule
