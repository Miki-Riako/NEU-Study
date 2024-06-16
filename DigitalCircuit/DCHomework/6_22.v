module T6_22(
    input X,
    input CP,
    input CLR,
    output F,
    output[1:0] Q
);
    wire J0, K0;
    wire J1, K1;
    reg QF0, QF1;
    assign J0 = X ~^ QF1;
    assign K0 = ~(X & QF1);
    assign J1 = QF0 ^ X;
    assign K1 = ~(~X & QF0);
    assign F = ~QF0 & (X ^ QF1);
    assign Q = {QF1, QF0};
    always @(posedge CP or negedge CLR) begin
        if (!CLR) QF0 <= 0;
        else QF0 <= J0 & ~QF0 | ~K0 & QF0;
    end
    always @(posedge CP or negedge CLR) begin
        if (!CLR) QF1 <= 0;
        else QF1 <= J1 & ~QF1 | ~K1 & QF1;
    end
endmodule
