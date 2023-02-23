`timescale 1ns / 1ps


module decoder(in,out);
    input [15:0] in;
    output reg [15:0] out = 0;

    reg [15:0] prev_in = 0;
    
    reg [31:0] tmp = 0;
    integer i = 0;
    always@(*)begin
        if(prev_in[15:0] != in[15:0])begin
            if(in == 16'b1010101010101010 || in == 16'b1111111111111111)else begin  //阻塞或者不显示的时候不进行译码
			    out = in;
            end else begin
                out = in;
                tmp = {8'b0,in};
                prev_in = in;
                i = 0;        
                for(i = 0; i < 8; i = i + 1)begin
                    if(tmp[15:12] > 4) tmp[15:12] = tmp[15:12] + 3;
                    if(tmp[11:8] > 4) tmp[11:8] = tmp[11:8] + 3;
                    tmp = tmp << 1;
                end
                out = tmp[15:8];
            end
        end
    end
endmodule
