module Traffic_Light_Display(
    input wire AG,
    input wire AY,
    input wire AR,
    input wire AL,
    input wire BG,
    input wire BY,
    input wire BR,
    input wire BL,
    output wire [7:0] lights
);
    assign lights = {BL, BR, BY, BG, AL, AR, AY, AG};
endmodule
