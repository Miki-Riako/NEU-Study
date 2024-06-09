module Counter(
    input wire clk,
    input wire reset,
    output reg T75,
    output reg [1:0] light_main,
    output reg [1:0] light_sub,
    output reg [5:0] count_main,
    output reg [5:0] count_sub,
    output reg [6:0] count
);
    localparam GREEN  = 2'b00;
    localparam YELLOW = 2'b01;
    localparam RED    = 2'b10;
    localparam LEFT   = 2'b11;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            count <= 7'd74;
            T75 <= 1'b0;
        end else begin
            if (count == 7'd0) begin
                count <= 7'd74;
                T75 <= 1'b1;
            end else begin
                count <= count - 1;
                T75 <= 1'b0;
            end
        end
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            light_main <= GREEN;
            light_sub <= RED;
            count_main <= 6'd26;
            count_sub <= 6'd44;
        end else begin
            if (count > 48) begin
                count_main <= count - 49;
                count_sub <= count - 31;
                light_main <= GREEN;
                light_sub <= RED;
            end else if (count > 45) begin
                count_main <= count - 46;
                count_sub <= count - 31;
                light_main <= YELLOW;
                light_sub <= RED;
            end else if (count > 33) begin
                count_main <= count - 34;
                count_sub <= count - 31;
                light_main <= LEFT;
                light_sub <= RED;
            end else if (count > 30) begin
                count_main <= count - 31;
                count_sub <= count -31;
                light_main <= YELLOW;
                light_sub <= RED;
            end else if (count > 13) begin
                count_main <= count - 1;
                count_sub <= count - 14;
                light_main <= RED;
                light_sub <= GREEN;
            end else if (count > 10) begin
                count_main <= count - 1;
                count_sub <= count - 11;
                light_main <= RED;
                light_sub <= YELLOW;
            end else if (count > 3) begin
                count_main <= count - 1;
                count_sub <= count - 4;
                light_main <= RED;
                light_sub <= LEFT;
            end else if (count > 0) begin
                count_main <= count - 1;
                count_sub <= count - 1;
                light_main <= RED;
                light_sub <= YELLOW;
            end else begin
                count_main <= 26;
                count_sub <= 44;
                light_main <= GREEN;
                light_sub <= RED;
            end
            // if (count > 48) begin
            //     count_main <= count - 49;
            //     count_sub <= count - 31;
            //     light_main <= GREEN;
            //     light_sub <= RED;
            //     if (count == 49) begin
            //         light_main <= YELLOW;
            //     end
            // end else if (count > 45) begin
            //     count_main <= count - 46;
            //     count_sub <= count - 31;
            //     light_main <= YELLOW;
            //     light_sub <= RED;
            //     if (count == 46) begin
            //         light_main <= LEFT;
            //     end
            // end else if (count > 33) begin
            //     count_main <= count - 34;
            //     count_sub <= count - 31;
            //     light_main <= LEFT;
            //     light_sub <= RED;
            //     if (count == 34) begin
            //         light_main <= YELLOW;
            //     end
            // end else if (count > 30) begin
            //     count_main <= count - 31;
            //     count_sub <= count -31;
            //     light_main <= YELLOW;
            //     light_sub <= RED;
            //     if (count == 31) begin
            //         light_main <= RED;
            //         light_sub <= GREEN;
            //     end
            // end else if (count > 13) begin
            //     count_main <= count - 1;
            //     count_sub <= count - 14;
            //     light_main <= RED;
            //     light_sub <= GREEN;
            //     if (count == 14) begin
            //         light_sub <= YELLOW;
            //     end
            // end else if (count > 10) begin
            //     count_main <= count - 1;
            //     count_sub <= count - 11;
            //     light_main <= RED;
            //     light_sub <= YELLOW;
            //     if (count == 11) begin
            //         light_sub <= LEFT;
            //     end
            // end else if (count > 3) begin
            //     count_main <= count - 1;
            //     count_sub <= count - 4;
            //     light_main <= RED;
            //     light_sub <= LEFT;
            //     if (count == 4) begin
            //         light_sub <= YELLOW;
            //     end
            // end else if (count > 0) begin
            //     count_main <= count - 1;
            //     count_sub <= count - 1;
            //     light_main <= RED;
            //     light_sub <= YELLOW;
            //     if (count == 1) begin
            //         light_main <= GREEN;
            //         light_sub <= RED;
            //     end
            // end else begin
            //     count_main <= 26;
            //     count_sub <= 44;
            //     light_main <= GREEN;
            //     light_sub <= RED;
            // end
        end
    end
endmodule
