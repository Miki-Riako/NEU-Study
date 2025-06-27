module Traffic_Light_Display(
    input wire AG,
    input wire AY,
    input wire AR,
    input wire BG,
    input wire BY,
    input wire BR,
    output reg [5:0] lights
);
    always @(*) begin
        lights = {BR, BY, BG, AR, AY, AG};
    end
endmodule
