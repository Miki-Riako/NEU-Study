module counter (
    input wire clk,
    input wire rst,
    input wire start,
    input wire stop,
    output reg [3:0] sec_ones,
    output reg [3:0] sec_tens,
    output wire running_flag
    );
    reg running;
    assign running_flag = running;
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            sec_ones <= 4'd0;
            sec_tens <= 4'd0;
            running  <= 1'b0;
        end else if (start) begin
            running <= 1'b1;
        end else if (stop) begin
            running <= 1'b0;
        end else if (running) begin
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
        end
    end
endmodule
