`timescale 1ns / 1ps

module scan_data(reset,data,clk,an,seg);
    output [7:0]an;
    output [7:0]seg;
    input reset;
    input clk;
    input [31:0]data;
    wire clk_5ms;
    reg [2:0]select;
    Fdiv utt(reset,32'd50000,clk,clk_5ms);

    always @(posedge clk_5ms or posedge reset) begin
        if(!reset)begin
            select <= 3'd0;
        end
        else begin
            select <= select + 3'd1;
        end
    end

    reg [3:0]data_in;
    show(data_in,select,EN,an,seg);
    always @(*) begin
        case (select)
            7: data_in = data[31:28];
            6: data_in = data[27:24];
            5: data_in = data[23:20];
            4: data_in = data[19:16];
            3: data_in = data[15:12];
            2: data_in = data[11:8];
            1: data_in = data[7:4];
            0: data_in = data[3:0];
        endcase
    end
endmodule


module show(data,seletct,AN,seg);
    input [3:0]data;
    input [2:0]seletct;
    output reg[7:0]AN;
    output reg [7:0]seg;
    reg [7:0]an;

    always @(*) begin
        case(seletct) 
            0:an = 8'b11111110;
            1:an = 8'b11111101;
            2:an = 8'b11111011;
            3:an = 8'b11110111;
            4:an = 8'b11101111;
            5:an = 8'b11011111;
            6:an = 8'b10111111;
            7:an = 8'b01111111;
            default: an = 8'Hff;
        endcase
    end

    always @(*) begin
        case  (data)
            0:seg = 8'b00000011;
			1:seg = 8'b10011111;
			2:seg = 8'b00100101;
			3:seg = 8'b00001101;
			4:seg = 8'b10011001;
			5:seg = 8'b01001001;
			6:seg = 8'b01000001;
			7:seg = 8'b00011111;
			8:seg = 8'b00000001;
			9:seg = 8'b00001001;
            10:seg = 8'b11111101;
            // 11:seg = 8'b11000001;
            // 12:seg = 8'b01100011; 
            // 13:seg = 8'b10000101;
            // 14:seg = 8'b01100001;
            // 15:seg = 8'b01110001;
            default:seg = 8'Hff;
        endcase
    end
endmodule