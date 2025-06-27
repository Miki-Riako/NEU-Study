module parallel_adder_8bit(
    input wire [7:0] A,
    input wire [7:0] B,
    input wire Cin,
    input wire Ctrl, // 低有效控制端
    output wire [7:0] Sum,
    output wire Cout,
    output wire NegativeFlag
);
    wire [7:0] BinarySum;
    wire Cout_lower, Cout_upper;

    wire AFlag = A[7];
    wire BFlag = B[7];

    parallel_adder_4bit adder_lower (
        .A(A[3:0]),
        .B(B[3:0]),
        .Cin(Cin),
        .Ctrl(Ctrl),
        .Sum(BinarySum[3:0]),
        .Cout(Cout_lower)
    );
    parallel_adder_4bit adder_upper (
        .A(A[7:4]),
        .B(B[7:4]),
        .Cin(Cout_lower),
        .Ctrl(Ctrl),
        .Sum(BinarySum[7:4]),
        .Cout(Cout_upper)
    );

    assign Cout = (AFlag ^ BFlag) ? 0 : (BinarySum[7] ? ~Cout_upper : Cout_upper);
    assign NegativeFlag = (AFlag ^ BFlag) ? BinarySum[7] : (AFlag ? 1 : 0);
    assign Sum = {NegativeFlag, BinarySum[6:0]};
endmodule
