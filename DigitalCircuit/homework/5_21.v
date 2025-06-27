`timescale 1ns / 1ps
module P5_21(
    input wire CP,
    input wire K,
    input wire J,
    input wire SET,
    output wire Sn,
    output wire Rn,
    output wire Qn,
    output wire Q
);
wire WQ, WQn, WRn, WSn;
assign Qn = WQn;
assign Q = WQ;
assign Sn = WSn;
assign Rn = WRn;
assign WRn = ~(CP & K & WQ);
assign WSn = ~(WQn & J & CP);
assign WQn = ~(WRn & WQ);
assign WQ = ~(SET & WSn & WQn);
endmodule

module tb_P5_21;
    reg CP;
    reg K;
    reg J;
    reg SET;
    wire Sn;
    wire Rn;
    wire Qn;
    wire Q;
    P5_21 uut (
        .CP(CP), 
        .K(K), 
        .J(J), 
        .SET(SET), 
        .Sn(Sn), 
        .Rn(Rn), 
        .Qn(Qn), 
        .Q(Q)
    );
    initial begin
        $dumpfile("P5_21.vcd");
        $dumpvars(0, tb_P5_21);
        CP = 0;
        K = 0;
        J = 0;
        SET = 0;
        #5;  SET = 1; // 5
        #2;  K = 1; // 7
        #18; K = 0; // 25
        #12; // J = 1; K = 1; // 47
        #10; K = 0; // 57
        #8;  J = 0; // 65
        #17; K = 1; // 82
        #5; SET = 0; //87
        #15; SET = 1; // 102
        #25; // J = 1; K = 1; // 127
        #10; J = 0; // 137
        #20 $finish;
    end
    always begin
        #10 CP = ~CP;
    end
endmodule