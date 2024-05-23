`timescale 1ns/10ps
module full_adder_tb;
    reg A;
    reg B;
    reg Cin;
    reg Ctrl;
    wire Sum;
    wire Cout;
    full_adder DUT (
        .A(A),
        .B(B),
        .Cin(Cin),
        .Ctrl(Ctrl),
        .Sum(Sum),
        .Cout(Cout)
    );
    initial begin
        // $dumpfile("tb.vcd");
        // $dumpvars(0, full_adder_tb);
        A = 0; B = 0; Cin = 0; Ctrl = 0;
        #10; A = 0; B = 1; Cin = 0; Ctrl = 0;
        #10; A = 1; B = 0; Cin = 0; Ctrl = 0;
        #10; A = 1; B = 1; Cin = 0; Ctrl = 0;
        #10; A = 0; B = 0; Cin = 1; Ctrl = 0;
        #10; A = 0; B = 1; Cin = 1; Ctrl = 0;
        #10; A = 1; B = 0; Cin = 1; Ctrl = 0;
        #10; A = 1; B = 1; Cin = 1; Ctrl = 0;
        #10; A = 0; B = 1; Cin = 0; Ctrl = 1;
        #10; A = 1; B = 1; Cin = 1; Ctrl = 1;
        #10; A = 0; B = 0; Cin = 0; Ctrl = 0;
        #10; $stop;
    end
endmodule
