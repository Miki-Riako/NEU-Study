module Traffic_Light_System(
    input wire clk,
    input wire rst,
    input wire AS1,
    input wire AS2,
    input wire BS1,
    input wire BS2,
    output wire [5:0] lights,
    output wire [7:0] seg_ones,
    output wire [7:0] seg_tens
);
    wire AS, BS, clk_1Hz;
    wire [5:0] countdown;
    reg [3:0] bcd_ones, bcd_tens;
    wire AG, AY, AR, BG, BY, BR;

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

    Counter30 counter30_inst (
        .clk(clk_1Hz),
        .reset(rst),
        .count(countdown)
    );

    Traffic_Controller controller_inst (
        .clk(clk_1Hz),
        .reset(rst),
        .AS(AS),
        .BS(BS),
        .countdown(countdown),
        .AG(AG),
        .AY(AY),
        .AR(AR),
        .BG(BG),
        .BY(BY),
        .BR(BR)
    );

    Traffic_Light_Display display_inst (
        .AG(AG),
        .AY(AY),
        .AR(AR),
        .BG(BG),
        .BY(BY),
        .BR(BR),
        .lights(lights)
    );

    reg [5:0] _countdown;
    always @(*) begin
        if (AY == 1'b1 || BY == 1'b1) begin
            _countdown = countdown % 60;
        end else begin
            _countdown = countdown % 60 - 3;
        end
        
        bcd_tens = _countdown / 10;
        if (bcd_tens >= 6) begin
            bcd_tens = bcd_tens - 6;
            bcd_ones = bcd_ones - 1;
        end
        bcd_ones = _countdown % 10;
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
