`timescale 1ns / 1ps

module scan_data(reset,data,clk,an,seg);
    output [3:0]an;
    output [7:0]seg;
    input reset;
    input clk;
    input [15:0]data;
    wire clk_5ms;
    reg [1:0]select;
    Fdiv utt(reset,32'd50000,clk,clk_5ms);

    always @(posedge clk_5ms or posedge reset) begin
        if(!reset)begin
            select <= 2'd0;
        end
        else begin
            select <= select + 2'd1;
        end
    end

    reg [3:0]data_in;
    show sh(data_in,select,an,seg);
    always @(*) begin
        case (select)
            3: data_in = data[15:12];
            2: data_in = data[11:8];
            1: data_in = data[7:4];
            0: data_in = data[3:0];
        endcase
    end
endmodule


module show(data,seletct,AN,seg);
    input [3:0]data;
    input [1:0]seletct;
    output reg[3:0]AN;
    output reg [7:0]seg;

    always @(*) begin
        case(seletct) 
            0:AN = 4'b1110;
            1:AN = 4'b1101;
            2:AN = 4'b1011;
            3:AN = 4'b0111;
            default: AN = 4'hf;
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
            10:seg = 8'b11111101;   //-
            default:seg = 8'Hff;    //empty
        endcase
    end
endmodule