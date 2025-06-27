`timescale 1ns/10ps
module voter(A, B, C, F);
    input A, B, C;
    output F;
    wire h1, h2, h3;
    assign h1 = ~(A & B);
    assign h2 = ~(A & C);
    assign h3 = ~(B & C);
    assign F = ~(h1 & h2 & h3);
endmodule
