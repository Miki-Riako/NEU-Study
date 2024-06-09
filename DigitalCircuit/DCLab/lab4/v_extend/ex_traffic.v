module Traffic_Light_System(
    input wire clk,
    input wire rst,
    input wire AS1,
    input wire AS2,
    input wire BS1,
    input wire BS2,
    input wire ctrl_btn,
    output wire [7:0] lights,
    output wire [7:0] seg_ones,
    output wire [7:0] seg_tens,
    output wire display_flag
);

    wire clk_1Hz;
    wire [5:0] countdown;
    wire [1:0] light_main;
    wire [1:0] light_sub;
    wire [5:0] count_main;
    wire [5:0] count_sub;
    reg [3:0] bcd_ones, bcd_tens;

    wire AG, AY, AR, AL, BG, BY, BR, BL;

    assign display_flag = ctrl_btn;

    divider divider_inst (
        .clk(clk),
        .rst(rst),
        .clk_out(clk_1Hz)
    );

    Traffic_Sensor sensor_inst (
        .AS1(AS1),
        .AS2(AS2),
        .BS1(BS1),
        .BS2(BS2),
        .AS(AS),
        .BS(BS)
    );

    Traffic_Controller controller_inst (
        .clk(clk_1Hz),
        .reset(rst),
        .ctrl_btn(ctrl_btn),
        .countdown(countdown),
        .AG(AG),
        .AY(AY),
        .AR(AR),
        .AL(AL),
        .BG(BG),
        .BY(BY),
        .BR(BR),
        .BL(BL)
    );

    Traffic_Light_Display display_inst (
        .AG(AG),
        .AY(AY),
        .AR(AR),
        .AL(AL),
        .BG(BG),
        .BY(BY),
        .BR(BR),
        .BL(BL),
        .lights(lights)
    );

    always @(*) begin
        bcd_tens <= countdown / 10;
        bcd_ones <= countdown % 10;
    end

    bit_to_7seg seg_ones_inst (
        .ctrl(0),
        .bit(bcd_ones),
        .seg(seg_ones)
    );
    bit_to_7seg seg_tens_inst (
        .ctrl(0),
        .bit(bcd_tens),
        .seg(seg_tens)
    );
endmodule
