`timescale 1ns/10ps
module adder_subtractor_8bit_tb;
    reg [7:0] A;
    reg [7:0] B;
    reg Cin;
    reg Ctrl;
    reg BCDCtrl;
    reg AddSubCtrl;
    wire [11:0] Sum;
    wire Cout;
    wire NegativeFlag;
    wire [7:0] dpy0;
    wire [7:0] dpy1;
    adder_subtractor_8bit DUT (
        .A(A),
        .B(B),
        .Cin(Cin),
        .Ctrl(Ctrl),
        .BCDCtrl(BCDCtrl),
        .AddSubCtrl(AddSubCtrl),
        .Sum(Sum),
        .Cout(Cout),
        .NegativeFlag(NegativeFlag),
        .dpy0(dpy0),
        .dpy1(dpy1)
    );

    initial begin
        $dumpfile("tb.vcd");
        $dumpvars(0, adder_subtractor_8bit_tb);
        A = 8'b00000000; B = 8'b00000000; Cin = 0; Ctrl = 0; BCDCtrl = 0; AddSubCtrl = 0;
        #10; A = 8'b11111111; B = 8'b00000001; Cin = 1; Ctrl = 1; BCDCtrl = 0; AddSubCtrl = 0;
        #10; A = 8'b00001111; B = 8'b11110000; Cin = 1; Ctrl = 1; BCDCtrl = 1; AddSubCtrl = 0;
        #10; A = 8'b00000001; B = 8'b00000001; Cin = 0; Ctrl = 0; BCDCtrl = 0; AddSubCtrl = 0;
        #10; A = 8'b01010101; B = 8'b10101010; Cin = 0; Ctrl = 0; BCDCtrl = 0; AddSubCtrl = 0;
        #10; A = 8'b11111111; B = 8'b00000001; Cin = 1; Ctrl = 0; BCDCtrl = 0; AddSubCtrl = 0;
        #10; A = 8'b10100101; B = 8'b01011010; Cin = 0; Ctrl = 0; BCDCtrl = 0; AddSubCtrl = 0;
        #10; A = 8'b00001111; B = 8'b11110000; Cin = 1; Ctrl = 0; BCDCtrl = 1; AddSubCtrl = 0;
        #10; A = 8'b00001111; B = 8'b00000001; Cin = 0; Ctrl = 0; BCDCtrl = 0; AddSubCtrl = 1;
        #10; A = 8'b10000000; B = 8'b00000001; Cin = 0; Ctrl = 0; BCDCtrl = 0; AddSubCtrl = 1;
        #10; A = 8'b00000011; B = 8'b00001100; Cin = 0; Ctrl = 0; BCDCtrl = 1; AddSubCtrl = 1;
        #10; A = 8'b00000000; B = 8'b00000000; Cin = 0; Ctrl = 0; BCDCtrl = 0; AddSubCtrl = 0;
        #10; $stop;
    end
endmodule
