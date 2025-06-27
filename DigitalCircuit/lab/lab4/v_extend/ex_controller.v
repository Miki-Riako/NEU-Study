module Traffic_Controller(
    input wire clk,
    input wire reset,
    input wire ctrl_btn,
    output reg [5:0] countdown,
    output reg AG,
    output reg AY,
    output reg AR,
    output reg AL,
    output reg BG,
    output reg BY,
    output reg BR,
    output reg BL
);
    wire [1:0] light_main;
    wire [1:0] light_sub;
    wire [5:0] count_main;
    wire [5:0] count_sub;
    wire [6:0] count;
    wire T75;

    Counter counter_inst (
        .clk(clk),
        .reset(reset),
        .T75(T75),
        .light_main(light_main),
        .light_sub(light_sub),
        .count_main(count_main),
        .count_sub(count_sub),
        .count(count)
    );

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            AG <= 1;
            AY <= 0;
            AR <= 0;
            AL <= 0;
            BG <= 0;
            BY <= 0;
            BR <= 1;
            BL <= 0;
        end else begin
            AG <= (light_main == 2'b00);
            AY <= (light_main == 2'b01);
            AR <= (light_main == 2'b10);
            AL <= (light_main == 2'b11);

            BG <= (light_sub == 2'b00);
            BY <= (light_sub == 2'b01);
            BR <= (light_sub == 2'b10);
            BL <= (light_sub == 2'b11);
        end
    end

    always @(*) begin
        if (ctrl_btn) begin
            countdown = count_main;
        end else begin
            countdown = count_sub;
        end
    end
endmodule
