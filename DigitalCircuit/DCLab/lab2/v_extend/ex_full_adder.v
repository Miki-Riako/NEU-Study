module parallel_adder_4bit(
    input wire [3:0] A,
    input wire [3:0] B,
    input wire Cin,
    input wire Ctrl, // 低有效控制端
    output wire [3:0] Sum,
    output wire Cout
);
    wire [3:0] P, G, temp;
    wire [3:1] C;
    assign P = A ^ B;
    assign G = A & B;
    assign C[1] = G[0] | (P[0] & Cin);
    assign C[2] = G[1] | (P[1] & G[0]) | (P[1] & P[0] & Cin);
    assign C[3] = G[2] | (P[2] & G[1]) | (P[2] & P[1] & G[0]) | (P[2] & P[1] & P[0] & Cin);
    assign temp[0] = P[0] ^ Cin;
    assign temp[1] = P[1] ^ C[1];
    assign temp[2] = P[2] ^ C[2];
    assign temp[3] = P[3] ^ C[3];
    assign Sum = ~Ctrl ? temp : 0;
    assign Cout = ~Ctrl ? G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) | (P[3] & P[2] & P[1] & G[0]) | (P[3] & P[2] & P[1] & P[0] & Cin) : 0;
endmodule
