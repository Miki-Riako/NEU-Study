module adder_74283(
    input [3:0] A,
    input [3:0] B,
    input Cin,
    output [3:0] Sum,
    output Cout
);
assign {Cout, Sum} = A + B + Cin;
endmodule
module eight_bit_adder(
    input [7:0] num1,
    input [7:0] num2,
    output [7:0] result,
    output carry_out
);
    wire carry_intermediate;
    adder_74283 lower_bits(
        .A(num1[3:0]),
        .B(num2[3:0]),
        .Cin(1'b0),
        .Sum(result[3:0]),
        .Cout(carry_intermediate)
    );
    adder_74283 upper_bits(
        .A(num1[7:4]),
        .B(num2[7:4]),
        .Cin(carry_intermediate),
        .Sum(result[7:4]),
        .Cout(carry_out)
    );
endmodule