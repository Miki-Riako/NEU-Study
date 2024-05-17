`timescale 1ns/10ps
module adder_8bit_tb;
    reg [7:0] A;
    reg [7:0] B;
    reg Cin;
    reg Ctrl;
    wire [7:0] Sum;
    wire Cout;
    adder_8bit DUT (
        .A(A), 
        .B(B), 
        .Cin(Cin), 
        .Ctrl(Ctrl), 
        .Sum(Sum), 
        .Cout(Cout)
    );
    initial begin
        // $dumpfile("tb.vcd");
        // $dumpvars(0, adder_8bit_tb);
        A = 8'h00; B = 8'h00; Cin = 0; Ctrl = 0;
        #10; A = 8'h01; B = 8'h01; Cin = 0; Ctrl = 0;
        #10; A = 8'h55; B = 8'hAA; Cin = 0; Ctrl = 0;
        #10; A = 8'hA5; B = 8'h5A; Cin = 0; Ctrl = 0;
        #10; A = 8'hFF; B = 8'h01; Cin = 1; Ctrl = 0;
        #10; A = 8'hFF; B = 8'h01; Cin = 1; Ctrl = 1;
        #10; A = 8'h0F; B = 8'hF0; Cin = 1; Ctrl = 0;
        #10; A = 8'h0F; B = 8'hF0; Cin = 1; Ctrl = 1;
        #10; A = 8'h00; B = 8'h00; Cin = 0; Ctrl = 0;
        #10; $stop;
    end
endmodule
