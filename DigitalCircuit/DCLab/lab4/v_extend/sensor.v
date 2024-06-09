module Traffic_Sensor(
    input wire AS1, AS2, BS1, BS2,
    output reg AS, BS
);
    always @(*) begin
        AS = AS1 | AS2;
        BS = BS1 | BS2;
    end
endmodule
