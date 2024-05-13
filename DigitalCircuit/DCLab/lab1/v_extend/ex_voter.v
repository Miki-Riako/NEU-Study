`timescale 1ns/10ps
module main_judge_voter(A, B, C, F);
    // A is the main judge
    // B and C are the secondary judges
    input A, B, C;
    output F;
    assign F = A & (B | C);
endmodule
