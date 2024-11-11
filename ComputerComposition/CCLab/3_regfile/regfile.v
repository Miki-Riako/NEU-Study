`timescale 1ns / 1ps
//*************************************************************************
//   > 文件名: regfile.v
//   > 描述  ：寄存器堆模块，同步写，异步读
//   > 作者  : LOONGSON
//   > 日期  : 2016-04-14
//*************************************************************************
module regfile(
    input             clk,
    input             wen,
    input      [4 :0] raddr1,
    input      [4 :0] raddr2,
    input      [4 :0] waddr,
    input      [31:0] wdata,
    output reg [31:0] rdata1,
    output reg [31:0] rdata2,
    input      [4 :0] test_addr,
    output reg [31:0] test_data
    );
    reg [31:0] rf[31:0];
     
    // three ported register file
    // read two ports combinationally
    // write third port on rising edge of clock
    // register 0 hardwired to 0

//补充完成异步读同步写寄存器堆的代码

    // 异步读：组合逻辑读取寄存器
    always @(*) begin
        rdata1 = (raddr1 == 5'b0) ? 32'b0 : rf[raddr1];
        rdata2 = (raddr2 == 5'b0) ? 32'b0 : rf[raddr2];
        test_data = (test_addr == 5'b0) ? 32'b0 : rf[test_addr];
    end
    // 同步写：时钟上升沿触发写操作
    always @(posedge clk) begin
        if (wen && waddr != 5'b0) begin
            rf[waddr] <= wdata;
        end
    end

endmodule
