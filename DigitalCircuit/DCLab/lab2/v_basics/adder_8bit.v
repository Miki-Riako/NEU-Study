module adder_8bit(
    input wire [7:0] A,
    input wire [7:0] B,
    input wire Cin,
    input wire Ctrl, // 低有效控制端
    input wire BCDCtrl,
    output wire [11:0]Sum,
    output wire Cout,
    output wire [7:0] dpy0,
    output wire [7:0] dpy1
);
    wire [7:0] BinarySum;
    wire [6:0] carry;
    
    full_adder fa0 (.A(A[0]), .B(B[0]), .Cin(Cin),      .Ctrl(Ctrl), .Sum(BinarySum[0]), .Cout(carry[0]));
    full_adder fa1 (.A(A[1]), .B(B[1]), .Cin(carry[0]), .Ctrl(Ctrl), .Sum(BinarySum[1]), .Cout(carry[1]));
    full_adder fa2 (.A(A[2]), .B(B[2]), .Cin(carry[1]), .Ctrl(Ctrl), .Sum(BinarySum[2]), .Cout(carry[2]));
    full_adder fa3 (.A(A[3]), .B(B[3]), .Cin(carry[2]), .Ctrl(Ctrl), .Sum(BinarySum[3]), .Cout(carry[3]));
    full_adder fa4 (.A(A[4]), .B(B[4]), .Cin(carry[3]), .Ctrl(Ctrl), .Sum(BinarySum[4]), .Cout(carry[4]));
    full_adder fa5 (.A(A[5]), .B(B[5]), .Cin(carry[4]), .Ctrl(Ctrl), .Sum(BinarySum[5]), .Cout(carry[5]));
    full_adder fa6 (.A(A[6]), .B(B[6]), .Cin(carry[5]), .Ctrl(Ctrl), .Sum(BinarySum[6]), .Cout(carry[6]));
    full_adder fa7 (.A(A[7]), .B(B[7]), .Cin(carry[6]), .Ctrl(Ctrl), .Sum(BinarySum[7]), .Cout(Cout));
    
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
    
    assign Sum = BCDCtrl ? BCDSum : {4'b0, BinarySum};

    wire [3:0] lower_digit = BCDCtrl ? BCDSum[3:0] : BinarySum[3:0];
    wire [3:0] upper_digit = BCDCtrl ? BCDSum[7:4] : BinarySum[7:4];
    bit_to_7seg display0 (.ctrl(Ctrl), .bit(lower_digit), .seg(dpy0));
    bit_to_7seg display1 (.ctrl(Ctrl), .bit(upper_digit), .seg(dpy1));
endmodule
