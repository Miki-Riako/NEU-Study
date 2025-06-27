module T6_24(
    input X,
    input CLK,
    input CLRn,
    output Z,
    output[2:0] Q
);
    wire D0, D1, D2;
    reg QF0, QF1, QF2;
    assign Q = {QF2, QF1, QF0};
    assign Z = QF2 & X;
    assign D0 = ~QF2 & ~QF1 & X;
    assign D1 = QF0 & X;
    assign D2 = QF2 & X | QF1 & ~QF0 & X;
    always @(posedge CLK or negedge CLRn) begin
        if (!CLRn) QF0 <= 0;
        else QF0 <= D0;
    end
    always @(posedge CLK or negedge CLRn) begin
        if (!CLRn) QF1 <= 0;
        else QF1 <= D1;
    end
    always @(posedge CLK or negedge CLRn) begin
        if (!CLRn) QF2 <= 0;
        else QF2 <= D2;
    end
endmodule
