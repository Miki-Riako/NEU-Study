module LS194(
    input wire DSR,
    input wire DSL,
    input wire M0,
    input wire M1,
    input wire CLK,
    input wire CLR,
    output reg [3:0] Q
);

always @(posedge CLK or negedge CLR) begin
    if (!CLR)
        Q <= 4'b0000;
    else begin
        case ({M1, M0})
            2'b00: Q <= Q;
            2'b01: Q <= {DSR, Q[3:1]};
            2'b10: Q <= {Q[2:0], DSL};
            2'b11: Q <= {Q[3:1], Q[0]};
        endcase
    end
end

endmodule

module T6_26(
    input wire CLK,
    input wire CLRn,
    input wire S1,
    output wire [3:0] Q
);
LS194 u0(
    .DSR (~Q[3]),
    .DSL (1'b0),
    .M0 (1'b1),
    .M1 (S1),
    .CLK (CLK),
    .CLR (CLRn),
    .Q (Q)
);
endmodule
