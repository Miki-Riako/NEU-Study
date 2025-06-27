module T6_25(
    input CP, CLRn, X,
    output wire[2:0] state,
    output wire Z
);
    reg[2:0] cur_state, next_state;
    reg Zout;
    parameter [2:0] S0 = 3'b000, S1 = 3'b001,
        S2 = 3'b010, S3 = 3'b011,
        S4 = 3'b100, S5 = 3'b101;
    assign state = cur_state;
    assign Z = Zout;
    
    always @(*) begin
        case(cur_state)
        S0: if (X) next_state <= S1;
            else next_state <= S0;
        S1: if (X) next_state <= S2;
            else next_state <= S0;
        S2: if (X) next_state <= S2;
            else next_state <= S3;
        S3: if (X) next_state <= S1;
            else next_state <= S4;
        S4: if (X) next_state <= S5;
            else next_state <= S1;
        S5: if (X) next_state <= S2;
            else next_state <= S0;
        endcase
    end
    always @(posedge CP or negedge CLRn) begin
        if (CLRn == 0) cur_state <= S0;
        else begin
            cur_state <= next_state;
        end
    end
    always @(*) begin: com_part_G
        if (~CLRn) Zout <= 0;
        else if (cur_state == S5) Zout <= 1;
        else Zout <= 0;
    end
endmodule
