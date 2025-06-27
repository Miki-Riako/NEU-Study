`timescale 1ns / 1ps
//*************************************************************************
//   > 文件名: data_mem.v
//   > 描述  ：异步数据存储器模块，采用寄存器搭建而成，类似寄存器堆
//   >         同步写，异步读
//   > 作者  : LOONGSON
//   > 日期  : 2016-04-14
//*************************************************************************
module data_ram(
    input         clk,         // 时钟
    input  [3:0]  wen,         // 字节写使能
    input  [4:0] addr,        // 地址
    input  [31:0] wdata,       // 写数据
    output reg [31:0] rdata,       // 读数据
    
    //调试端口，用于读出数据显示
    input  [4 :0] test_addr,
    output reg [31:0] test_data
);
    reg [31:0] DM[31:0];  //数据存储器，字节地址7'b000_0000~7'b111_1111

    //补充完成RAM异步读写
    // 异步读操作
    always @(*) begin
        rdata = DM[addr];  // 根据地址读出数据
        test_data = DM[test_addr]; // 从指定的调试地址读取数据
    end
    // 同步写操作
    always @(posedge clk) begin
        if (wen[0]) DM[addr][7:0]   <= wdata[7:0];   // 写入最低字节
        if (wen[1]) DM[addr][15:8]  <= wdata[15:8];  // 写入第二字节
        if (wen[2]) DM[addr][23:16] <= wdata[23:16]; // 写入第三字节
        if (wen[3]) DM[addr][31:24] <= wdata[31:24]; // 写入最高字节
    end
endmodule
