`timescale 1ns / 1ps
//`include "/Users/mrx/Library/CloudStorage/OneDrive-个人/programing/digitcircuit/tmpt/dc_1/TFLIGHT/TFLIGHT.srcs/sources_1/new/Translator.v"

module decoder_simu();
    
    reg [7:0] bin;
    wire [7:0] ans;

    decoder utt(bin,ans);
    integer i;

    initial begin
        $display("start");                  
        $dumpfile("decoder_wave.vcd");              
        $dumpvars(0, decoder_simu);

        bin = 8'hff;
        #20
        bin = 8'b10101010;
        #20
        bin = 8'd0;
        for(i = 0;i < 300; i = i + 1) begin
            #20
            bin = i;
        end
        $finish;                      // 6000个单位时间后结束模拟
    end

    
endmodule
