module parallel_adder_8bit(
    input wire [7:0] A,
    input wire [7:0] B,
    input wire Cin,
    input wire Ctrl, // 低有效控制端
    input wire BCDCtrl,
    output wire [11:0] Sum,
    output wire Cout
);
    wire [7:0] BinarySum;
    wire Cout_lower, Cout_upper;

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
            BCDSum = {BCDSum[10:0], BinarySum[i]};
        end
    end
    
    assign Cout = Cout_upper;
    assign Sum = BCDCtrl ? BCDSum : {4'b0, BinarySum};
endmodule
