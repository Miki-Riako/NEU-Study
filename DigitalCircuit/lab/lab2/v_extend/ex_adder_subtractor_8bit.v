module adder_subtractor_8bit(
    input wire [7:0] A,
    input wire [7:0] B,
    input wire Cin,
    input wire Ctrl, // 低有效控制端
    input wire BCDCtrl,
    input wire AddSubCtrl, // 加减控制端
    output wire [11:0] Sum,
    output wire Cout,
    output wire NegativeFlag,
    output wire [7:0] dpy0,
    output wire [7:0] dpy1
);
    wire [7:0] B_mod;
    wire [7:0] BinarySum;
    assign B_mod = AddSubCtrl ? ~(B + Cin) + 1 : B;
    parallel_adder_8bit adder (
        .A(A),
        .B(B_mod),
        .Cin(AddSubCtrl ? 0 : Cin),
        .Ctrl(Ctrl),
        .Sum(BinarySum),
        .Cout(Cout),
        .NegativeFlag(NegativeFlag)
    );
    
    wire [7:0] AbsSum;
    assign AbsSum = NegativeFlag ? ~BinarySum + 1 : BinarySum;

    integer i;
    reg [11:0] BCDSum;
    always @(*) begin
        BCDSum = 12'd0;
        for (i = 7; i >= 0; i = i - 1) begin
            if (BCDSum[3:0] > 4)
                BCDSum[3:0] = BCDSum[3:0] + 3;
            if (BCDSum[7:4] > 4)
                BCDSum[7:4] = BCDSum[7:4] + 3;
            if (BCDSum[11:8] > 4)
                BCDSum[11:8] = BCDSum[11:8] + 3;
            BCDSum = {BCDSum[10:0], AbsSum[i]};
        end
    end
    
    assign Sum = BCDCtrl ? BCDSum : {4'b0, BinarySum};
    wire [3:0] lower_digit = BCDCtrl ? BCDSum[3:0] : AbsSum[3:0];
    wire [3:0] upper_digit = BCDCtrl ? BCDSum[7:4] : AbsSum[7:4];
    bit_to_7seg display0 (.ctrl(Ctrl), .bit(lower_digit), .seg(dpy0));
    bit_to_7seg display1 (.ctrl(Ctrl), .bit(upper_digit), .seg(dpy1));
endmodule
