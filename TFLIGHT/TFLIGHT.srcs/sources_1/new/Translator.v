`timescale 1ns / 1ps

module decoder(in,out);
    input [7:0] in;
    output reg [7:0] out = 0;

    reg [7:0] prev_in = 0;
    
    reg [15:0] tmp = 0;
    integer i = 0;
    always@(*)begin
        if(prev_in[7:0] != in[7:0])begin
            if(in == 8'b10101010 || 8 == 8'hff)else begin  //阻塞或者不显示的时候不进行译码
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
