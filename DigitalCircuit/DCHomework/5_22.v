`timescale 1ns / 1ps
module P5_22(
    input wire SET,
    input wire CP,
    input wire J,
    input wire K,
    output wire Q,
    output wire Qn
);
reg QF;
assign Q = QF;
assign Qn = ~QF;
always @(posedge CP or negedge SET)
begin
    if (!SET)
        QF <= 1;
    else
        QF <= J & ~QF | ~K & QF;
end
endmodule

// module tb_P5_22;
// reg SET;
// reg CP;
// reg J;
// reg K;
// wire Q;
// wire Qn;
// P5_22 uut (
//     .SET(SET),
//     .CP(CP),
//     .J(J),
//     .K(K),
//     .Q(Q),
//     .Qn(Qn)
// );
//     initial begin
//         $dumpfile("P5_22.vcd");
//         $dumpvars(0, tb_P5_22);
//         CP = 0;
//         K = 0;
//         J = 0;
//         SET = 0;
//         #5;  SET = 1; // 5
//         #2;  K = 1; // 7
//         #18; K = 0; // 25
//         #12; J = 1; K = 1; // 47
//         #10; K = 0; // 57
//         #8;  J = 0; // 65
//         #2;  K = 1; // 67
//         #15; K = 0; // 82
//         #5; SET = 0; //87
//         #15; SET = 1; // 102
//         #25; J = 1; K = 1; // 127
//         #10; J = 0; // 137
//         #20 $finish;
//     end
//     always begin
//         #10 CP = ~CP;
//     end
// endmodule