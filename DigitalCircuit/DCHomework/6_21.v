module T6_21(
    input X,
    input CP,
    input CLR,
    output F,
    output[1:0] Q
);
    wire D0, D1;
    reg QF0, QF1;
    assign D0 = QF1 & X | ~QF1 & ~QF0 & ~X;
    assign D1 = QF0 & ~X | ~QF1 & ~QF0 & X;
    assign F = ~X & ~QF0 & QF1 | ~QF1 & ~QF0 & X;
    assign Q = {QF1, QF0};
    always @(posedge CP or negedge CLR) begin
        if (!CLR) QF0 <= 0;
        else QF0 <= D0;
    end
    always @(posedge CP or negedge CLR) begin
        if (!CLR) QF1 <= 0;
        else QF1 <= D1;
    end
endmodule