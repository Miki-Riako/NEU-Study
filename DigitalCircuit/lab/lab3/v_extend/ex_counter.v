module ex_counter (
    input wire clk,
    input wire rst,
    input wire start,
    input wire stop,
    input wire mode,      // KEY3: 0 for countdown, 1 for count up
    input wire set_value, // KEY3 = 0, use this to set initial countdown value
    input wire [5:0] value,
    output reg [3:0] sec_ones,
    output reg [3:0] sec_tens,
    output wire running_flag,
    output reg led_blink
);
    reg running;
    reg counting_up;
    reg blink;
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            if (value < 10) begin
                sec_ones <= value[3:0];
                sec_tens <= 4'd0;
            end else begin
                sec_ones <= value % 10;
                sec_tens <= value / 10;
            end
            running  <= 1'b0;
            counting_up <= 1'b1;
            led_blink <= 1'b0;
            blink <= 1'b0;
        end else if (set_value && !mode) begin
            if (value < 10) begin
                sec_ones <= value[3:0];
                sec_tens <= 4'd0;
            end else begin
                sec_ones <= value % 10;
                sec_tens <= value / 10;
            end
            counting_up <= 1'b0;
            led_blink <= 1'b0;
            blink <= 1'b0;
        end else if (start) begin
            running <= 1'b1;
            counting_up <= mode;
            blink <= 1'b0;
        end else if (stop) begin
            running <= 1'b0;
            blink <= 1'b0;
        end else if (running) begin
            if (counting_up) begin
                if (sec_ones == 4'd9) begin
                    sec_ones <= 4'd0;
                    if (sec_tens == 4'd5) begin
                        sec_tens <= 4'd0;
                    end else begin
                        sec_tens <= sec_tens + 1;
                    end
                end else begin
                    sec_ones <= sec_ones + 1;
                end
            end else begin
                if (sec_ones == 4'd0) begin
                    if (sec_tens == 4'd0) begin
                        running <= 1'b0;
                        blink <= 1'b1;
                    end else begin
                        sec_tens <= sec_tens - 1;
                        sec_ones <= 4'd9;
                    end
                end else begin
                    sec_ones <= sec_ones - 1;
                end
            end
        end else if (blink) begin
            led_blink <= ~led_blink;
        end
    end
    assign running_flag = running;
endmodule
