`timescale 1ns / 1ps

module tb_T6_26;
    reg CLK;
    reg CLRn;
    reg S1;
    wire [3:0] Q;
    T6_26 dut (
        .CLK(CLK),
        .CLRn(CLRn),
        .S1(S1),
        .Q(Q)
    );
    always #5 CLK = ~CLK;
    initial begin
        CLRn = 0;
        CLK = 1;
        S1 = 0;
        $dumpfile("tb.vcd");
        $dumpvars(0, tb_T6_26);
        #2 CLRn = 1;#8
        #80 S1 = 1;
        #20 S1 = 0;
        #90 $finish;
    end
endmodule
