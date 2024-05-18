module adder_subtractor_8bit(
    input wire [7:0] A,
    input wire [7:0] B,
    input wire Cin,
    input wire Ctrl, // 低有效控制端
    input wire BCDCtrl,
    input wire AddSubCtrl, // 加减控制端
    output wire [11:0] Sum,
    output wire Cout
);
    wire [7:0] B_mod;
    wire Cout_temp;
    assign B_mod = AddSubCtrl ? ~(B + Cin) + 1 : B;
    parallel_adder_8bit adder (
        .A(A),
        .B(B_mod),
        .Cin(AddSubCtrl ? 0 : Cin),
        .Ctrl(Ctrl),
        .BCDCtrl(BCDCtrl),
        .Sum(Sum),
        .Cout(Cout_temp)
    );
    assign Cout = Ctrl ? 0 : (AddSubCtrl ? ~Cout_temp : Cout_temp);
endmodule
