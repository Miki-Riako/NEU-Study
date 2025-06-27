module full_adder(
    input A,
    input B,
    input wire Cin,
    input wire Ctrl, // 低有效控制端
    output wire Sum,
    output wire Cout
);
    assign Sum = ~Ctrl ? A ^ B ^ Cin : 0;
    assign Cout = ~Ctrl ? (A & B) | (Cin & (A ^ B)) : 0;
endmodule
