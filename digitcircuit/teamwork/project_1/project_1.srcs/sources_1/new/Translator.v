`timescale 1ns / 1ps

module decoder(D,BCD);
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



module bin_BCD(
    input [31:0] bin,
    output [31:0] BCD
    );
    wire [31:0] t1, t2, t3, t4, t5, t6, t7;
    assign BCD[3:0] = bin % (4'd10);
    
    assign t1 = bin / (4'd10);
    assign BCD[7:4] = t1 % (4'd10);
    
    assign t2 = t1 / (4'd10);
    assign BCD[11:8] = t2 % (4'd10);
    
    assign t3 = t2 / (4'd10);
    assign BCD[15:12] = t3 % (4'd10);
    
    assign t4 = t3 / (4'd10);
    assign BCD[19:16] = t4 % (4'd10);
    
    assign t5 = t4 / (4'd10);
    assign BCD[23:20] = t5 % (4'd10);
    
    assign t6 = t5 / (4'd10);
    assign BCD[27:24] = t6 % (4'd10);
    
    assign t7 = t6 / (4'd10);
    assign BCD[31:28] = t7 % (4'd10);
endmodule


module shift_add3(bin,BCD);
    input [7:0] bin;
    output reg [7:0] BCD;

    reg [7:0] prev_bin;
    reg [15:0] tmp;
    integer i = 0;
    always@(*)begin
        if(prev_bin != bin)begin
            tmp = {8'b0,bin};
            prev_bin = bin;
            i = 0;        
            for(i = 0; i < 8; i = i + 1)begin
                if(tmp[15:12] > 4) tmp[15:12] = tmp[15:12] + 3;
                if(tmp[11:8] > 4) tmp[11:8] = tmp[11:8] + 3;
                tmp = tmp << 1;
            end
        end
        else begin
            BCD = tmp[15:8];
        end
    end
endmodule