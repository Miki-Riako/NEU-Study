`timescale 1ns / 1ps
module test_eight_bit_adder;
    // 输入和输出
    reg [7:0] num1, num2;
    wire [7:0] result;
    wire carry_out;
    // 实例化被测试的模块
    eight_bit_adder uut (
        .num1(num1),
        .num2(num2),
        .result(result),
        .carry_out(carry_out)
    );
    // 初始化仿真
    initial begin
        // 打开VCD文件记录波形
        $dumpfile("output.vcd");
        $dumpvars(0, test_eight_bit_adder);
        // 应用第一组测试向量
        num1 = 8'b11001010; // 202
        num2 = 8'b01100111; // 103, 扩展成8位
        #10; // 维持10ns
        // 应用第二组测试向量
        num1 = 8'b00101101; // 另一组数据
        num2 = 8'b11010010;
        #10; // 维持10ns
        // 应用第三组测试向量
        num1 = 8'b11111111; // 边界测试
        num2 = 8'b00000001;
        #10;
        // 应用第四组测试向量
        num1 = 8'b00000000; // 零测试
        num2 = 8'b00000000;
        #10;
        // 应用第五组测试向量
        num1 = 8'b10101010; // 随机数据
        num2 = 8'b01010101;
        #10;
        // 结束仿真
        $finish;
    end

endmodule
