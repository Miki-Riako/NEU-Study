module parallel_adder_8bit(
    input wire [7:0] A,
    input wire [7:0] B,
    input wire Cin,
    input wire Ctrl, // 低有效控制端
    output wire [7:0] Sum,
    output wire Cout
);
    wire [3:0] Sum_lower, Sum_upper;
    wire Cout_lower, Cout_upper;
    parallel_adder_4bit adder_lower (
        .A(A[3:0]),
        .B(B[3:0]),
        .Cin(Cin),
        .Ctrl(Ctrl),
        .Sum(Sum_lower),
        .Cout(Cout_lower)
    );
    parallel_adder_4bit adder_upper (
        .A(A[7:4]),
        .B(B[7:4]),
        .Cin(Cout_lower),
        .Ctrl(Ctrl),
        .Sum(Sum_upper),
        .Cout(Cout_upper)
    );
    assign Sum = {Sum_upper, Sum_lower};
    assign Cout = Cout_upper;
endmodule
