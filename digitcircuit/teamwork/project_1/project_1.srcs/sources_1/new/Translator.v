`timescale 1ns / 1ps

module decoder_brute(D,BCD);
    input wire [7:0]D;
    output reg [7:0]BCD;
    reg [3:0]high;
    reg [3:0]low;
    
    always@(*)begin
        high = D / 10;
        low = D % 10;
        BCD = {high,low};
    end
endmodule

module decoder(bin,BCD);
    input [7:0] bin;
    output reg [7:0] BCD = 0;

    reg [7:0] prev_bin = 0;
    
    reg [15:0] tmp = 0;
    integer i = 0;
    always@(*)begin
        if(prev_bin[7:0] != bin[7:0])begin
            tmp = {8'b0,bin};
            prev_bin <= bin;
            i = 0;        
            for(i = 0; i < 8; i = i + 1)begin
                if(tmp[15:12] > 4) tmp[15:12] = tmp[15:12] + 3;
                if(tmp[11:8] > 4) tmp[11:8] = tmp[11:8] + 3;
                tmp = tmp << 1;
            end
            BCD = tmp[15:8];
        end
    end
endmodule
