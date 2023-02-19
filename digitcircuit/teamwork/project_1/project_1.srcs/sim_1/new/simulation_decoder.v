`timescale 1ns / 1ps
`include "../../sources_1/new/Translator.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/02/16 13:42:39
// Design Name: 
// Module Name: simulation_decoder
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module simulation_decoder();
    
    reg [7:0] bin;
    wire [7:0] ans;

    decoder utt(bin,ans);

    initial begin
        $display("start a clock pulse");    // 打印开始标记
        $dumpfile("wave.vcd");              // 指定记录模拟波形的文件
        $dumpvars(0, simulation_decoder);          // 指定记录的模块层级
        bin = 0;
        #6000 $finish;                      // 6000个单位时间后结束模拟
    end

    always @(*)begin
        #20
        bin <= bin + 1;
    end
endmodule
