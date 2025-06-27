`timescale 1ns/10ps
module voter_tb;
    reg A, B, C;
    wire F;
    voter DUT(
        .A(A),
        .B(B),
        .C(C),
        .F(F)
    );
    initial begin
        A = 0; B = 0; C = 0;
        #10 A = 0; B = 0; C = 1;
        #10 A = 0; B = 1; C = 0;
        #10 A = 0; B = 1; C = 1;
        #10 A = 1; B = 0; C = 0;
        #10 A = 1; B = 0; C = 1;
        #10 A = 1; B = 1; C = 0;
        #10 A = 1; B = 1; C = 1;
        #10 A = 0; B = 0; C = 0;
        #10 $stop;
    end
endmodule
