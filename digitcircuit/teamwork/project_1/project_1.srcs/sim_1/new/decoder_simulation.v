`timescale 1ns / 1ps
`include "../../sources_1/new/Translator.v"

module simulation_decoder();
    
    reg [7:0] bin;
    wire [7:0] ans;

    decoder utt(bin,ans);

    initial begin
        $display("start");                  // 打印开始标记
        $dumpfile("decoder_wave.vcd");              // 指定记录模拟波形的文件
        $dumpvars(0, simulation_decoder);
        bin = 0;
        #6000 $finish;                      // 6000个单位时间后结束模拟
    end

    always @(*)begin
        #20
        bin <= bin + 1;
    end
endmodule
