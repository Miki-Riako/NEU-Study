`timescale 1ns / 1ps

module T6_25_tb;
    reg CP;
    reg CLRn;
    reg X;
    wire [2:0] state;
    wire Z;
    T6_25 dut (
        .CP(CP),
        .CLRn(CLRn),
        .X(X),
        .state(state),
        .Z(Z)
    );
    initial begin
        CP = 0;
        forever #5 CP = ~CP;
    end
    initial begin
        CLRn = 0;
        X = 1;
        $dumpfile("tb.vcd");
        $dumpvars(0, T6_25_tb);
        #2 CLRn = 1;
        #18 X = 0;
        #20 X = 1;
        #10 X = 0;
        #20 X = 1;
        #30 X = 0;
        #20 X = 1;
        #20 X = 0;
        #20 X = 1;
        #10 X = 0;
        #15 $finish;
    end

endmodule
