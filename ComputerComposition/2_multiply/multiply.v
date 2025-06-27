`timescale 1ns / 1ps
//*************************************************************************
//   > 文件名: multiply.v
//   > 描述  ：乘法器模块，低效率的迭代乘法算法，使用两个乘数绝对值参与运算
//   > 作者  : LOONGSON
//   > 日期  : 2016-04-14
//*************************************************************************
module multiply(              // 乘法器
    input         clk,        // 时钟
    input         mult_begin, // 乘法开始信号
    input  [31:0] mult_op1,   // 乘法源操作数1
    input  [31:0] mult_op2,   // 乘法源操作数2
    output [63:0] product,    // 乘积
    output        mult_end    // 乘法结束信号
);

 //补充完成乘法器模块的实现过程
    reg [31:0] abs_op1;         // 绝对值操作数1
    reg [31:0] abs_op2;         // 绝对值操作数2
    reg [63:0] partial_product; // 中间乘积
    reg [63:0] result;          // 最终乘积结果（带符号）
    reg [5:0]  count;           // 计数器，用于控制32次迭代
    reg        result_sign;     // 结果符号
    reg        done;            // 乘法结束信号
    assign product = result;
    assign mult_end = done;

    always @(posedge clk) begin
        if (mult_begin) begin // 初始化操作数的绝对值和符号
            abs_op1 <= mult_op1[31] ? (~mult_op1 + 1'b1) : mult_op1;
            abs_op2 <= mult_op2[31] ? (~mult_op2 + 1'b1) : mult_op2;
            result_sign <= mult_op1[31] ^ mult_op2[31];
            done            <= 1'b0;
            partial_product <= 1'b0;
            count           <= 1'b0;
        end else if (count < 6'd32) begin // 迭代乘法算法：检查最低位并累加
            if (abs_op2[0] == 1'b1) begin
                partial_product <= partial_product + (abs_op1 << count);
            end
            abs_op2 <= abs_op2 >> 1'b1;
            count <= count + 1'b1;
        end else begin // 乘法完成，将符号校正后的结果存储到result
            result <= result_sign ? ~partial_product + 1'b1 : partial_product;
            done <= 1'b1;
        end
    end
endmodule
