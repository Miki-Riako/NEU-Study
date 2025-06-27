module Traffic_Controller(
    input wire clk,
    input wire reset,
    input wire AS,
    input wire BS,
    input wire [5:0] countdown,
    output reg AG,
    output reg AY,
    output reg AR,
    output reg BG,
    output reg BY,
    output reg BR
);
    parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10, S3 = 2'b11;
    reg [1:0] state, next_state;

    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= S0;
        else
            state <= next_state;
    end

    always @(*) begin
        case (state)
            S0: if (AS && (countdown == 6'd3)) next_state = S1; else next_state = S0;
            S1: if (countdown == 6'd0) next_state = S2; else next_state = S1;
            S2: if (BS && (countdown == 6'd3)) next_state = S3; else next_state = S2;
            S3: if (countdown == 6'd0) next_state = S0; else next_state = S3;
            default: next_state = S0;
        endcase
    end

    always @(*) begin
        AG = 0; AY = 0; AR = 0;
        BG = 0; BY = 0; BR = 0;
        case (state)
            S0: begin
                AG = 1; AR = 0; BG = 0; BR = 1;
            end
            S1: begin
                AY = 1; AR = 0; BG = 0; BR = 1;
            end
            S2: begin
                AR = 1; AG = 0; BG = 1; BR = 0;
            end
            S3: begin
                AR = 1; AY = 0; BY = 1; BR = 0;
            end
            default: begin
                AG = 0; AY = 0; AR = 0;
                BG = 0; BY = 0; BR = 0;
            end
        endcase
    end
endmodule
