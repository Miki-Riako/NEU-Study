`timescale 1ns / 1ps
module sr_latch_with_clock (
    input wire S,
    input wire R,
    input wire CP,
    output reg Q,
    output reg Qn
);
initial begin
    Q = 0;
    Qn = 1;
end
always @(posedge CP) begin
    if (S && !R) begin
        Q <= 1;
        Qn <= 0;
    end else if (!S && R) begin
        Q <= 0;
        Qn <= 1;
    end else if (S && R) begin
        Q <= 0;  // Undefined state
        Qn <= 0;
    end
    // When S == 0 and R == 0, retain the previous state
end
endmodule

module tb_sr_latch_with_clock;
reg S;
reg R;
reg CP;
wire Q;
wire Qn;
// Instantiate the Unit Under Test (UUT)
sr_latch_with_clock uut (
    .S(S),
    .R(R),
    .CP(CP),
    .Q(Q),
    .Qn(Qn)
);
// Clock generation
initial begin
    CP = 0;
    forever #5 CP = ~CP;  // 10ns period clock
end
initial begin
    // Initialize Inputs
    S = 1;
    R = 0;
    // Generate the waveform file
    $dumpfile("output.vcd");
    $dumpvars(0, tb_sr_latch_with_clock);
    // Apply test vectors
    #12 S = 0; // 12
    #3  R = 1; // 15
    #7  S = 1; R = 0; //22
    #11 R = 1; // 33
    #6  S = 0; // 39
    #1  S = 1; // 40
    #1  S = 0; R = 0; // 41
    #7  S = 1; // 48
    #2  S = 0; // 504
    #3  R = 1;
    #5 $finish;
end
endmodule

