`timescale 1ns / 1ps

module WORK25(clk,clr,start,stopa,stopb,pause,r1,g1,y1,r2,g2,y2,AN,Seg);
	input clk,clr,start,stopa,stopb,pause;
	output r1,g1,y1,r2,g2,y2;
	output [3:0] AN;
	output [7:0] Seg;
	wire lclk;		
	wire [15:0] Data;
	wire [15:0] Data_out;
	clock times(clr,clk,lclk);
	Light light(lclk,clr,start,stopa,stopb,pause,r1,g1,y1,r2,g2,y2,Data);
	decoder bin_bcd(Data,Data_out);
	scan_data show (reset,Data_out,clk,AN,Seg);
endmodule




module Light(clk,clr,start,stopa,stopb,pause,r1,g1,y1,r2,g2,y2,Data);
	input clk,clr,start,stopa,stopb,pause;
	output reg r1,g1,y1,r2,g2,y2;
	output reg [15:0] Data;
	reg [7:0] clock;			
	initial
	begin
		Data<=16'b1010101010101010;//----
		clock<=8'd70;
		r1<=0;g1<=0;y1<=0;r2<=0;g2<=0;y2<=0;
	end
	always@(posedge clr or posedge clk or posedge stopa or posedge stopb or posedge pause)
	begin
		if(clr)	//复位
			begin
				Data<=16'b1010101010101010;//----
				clock<=8'd70;
				r1<=1;g1<=0;y1<=0;
				r2<=1;g2<=0;y2<=0;
			end
		else if(stopa)  //主干道堵塞
			begin
				Data<=16'b1011101110111011;
				clock<=8'd70;
				r1<=1;g1<=0;y1<=0;
				r2<=0;g2<=1;y2<=0;
			end
		else if(stopb)  //次干道堵塞
			begin
				Data<=16'b1011101110111011;
				clock<=8'd70;
				r1<=0;g1<=1;y1<=0;
				r2<=1;g2<=0;y2<=0;
			end
		else if(pause)
			begin
				Data<=Data;
				clock<=clock;
			end
		else if(start) //正常启动
			begin
				if(clock==70)//四个状态加起来70s
					begin
						clock<=clock-1'd1;
						r1<=0;y1<=0;g1<=1;
						r2<=1;y2<=0;g2<=0;
						Data[15:8]<=35;	//g1亮35s
						Data[7:0]<=40;		//r2亮40s
					end
				else if(clock==35)
					begin
						clock<=clock-1'd1;
						r1<=0;y1<=1;g1<=0;
						r2<=1;y2<=0;g2<=0;
						Data[15:8]<=5;		//y1亮5s
						Data[7:0]<=Data[7:0]-8'd1;  //r2还剩5s
					end
				else if(clock==30)
					begin
						clock<=clock-1'd1;
						r1<=1;y1<=0;g1<=0;
						r2<=0;y2<=0;g2<=1;
						Data[15:8]<=30;		//r1亮30s
						Data[7:0]<=25;			//g2亮25s
					end
				else if(clock==5)
					begin
						clock<=clock-1'd1;
						r1<=1;y1<=0;g1<=0;
						r2<=0;y2<=1;g2<=0;
						Data[15:8]<=Data[15:8]-1'd1;	//r1还剩5s
						Data[7:0]<=5;			//y2亮5s
					end
				else if(clock==1)//一次循环结束
					begin
						clock<=70;
						Data[15:8]<=Data[15:8]-1'd1;//归零
						Data[7:0]<=Data[7:0]-1'd1;//归零
					end
				else
					begin
						clock<=clock-1'd1;
						Data[15:8]<=Data[15:8]-1'd1;
						Data[7:0]<=Data[7:0]-1'd1;
					end
			end
		end
endmodule

// module Zuan(in,out);
// 	input [15:0] in;
// 	output reg [15:0] out;
// 	reg [15:0] temp;
// 	always@(*)
// 	begin
// 		if(in==16'b10101010-10101010)
// 			out=in;
// 		else if(in==16'b10111011-10111011)
// 			out=in;
// 		else
// 			begin
// 				temp = in;
// 				out[3:0] = temp[7:0]%10;//个位
// 				out[7:4] = temp[7:0]/10;//十位
// 				out[11:8] = temp[15:8]%10;
// 				out[15:12] = temp[15:8]/10;
// 			end
// 	end
// endmodule

// module Show(clk,AN,Seg,Data);
// 	input clk;
// 	input [15:0] Data;
// 	output reg [3:0] AN;
// 	output reg [7:0] Seg;
// 	reg [3:0] Data_4;
// 	reg [1:0] select;
// 	integer counter;
// 	initial
// 	begin
// 		select<=0;
// 		counter=0;
// 		Data_4<=4'd0;
// 	end
// 	always@(*)
// 	begin
// 		case(Data_4)
// 		0: Seg=8'b00000011;
// 		1: Seg=8'b10011111;
// 		2: Seg=8'b00100101;
// 		3: Seg=8'b00001101;
// 		4: Seg=8'b10011001;
// 		5: Seg=8'b01001001;
// 		6: Seg=8'b01000001;
// 		7: Seg=8'b00011111;
// 		8: Seg=8'b00000001;
// 		9: Seg=8'b00001001;
// 		10: Seg=8'b11111101;//A ----
// 		default: Seg=8'b11111111;//B
// 		endcase
// 	end
// 	always@(posedge clk)
// 	begin
// 		if(counter==125000)
// 		begin
// 			counter=0;
// 			if(select==3)
// 				select<=0;
// 			else
// 				select<=select+2'd1;
// 		end
// 		else
// 			counter=counter+1;
// 	end
// 	always@(select)
// 	begin
// 		case(select)
// 			0: begin
// 				Data_4<=Data[15:12];
// 				AN<=4'b1000;
// 				end
// 			1: begin
// 				Data_4<=Data[11:8];
// 				AN<=4'b1001;
// 				end
// 			2: begin
// 				Data_4<=Data[7:4];
// 				AN<=4'b1010;
// 				end
// 			3: begin
// 				Data_4<=Data[3:0];
// 				AN<=4'b1011;
// 				end
// 		endcase
// 	end
// endmodule//分频
// module clock(clr,clk_in,clk_out);
// 	input clr,clk_in;
// 	output reg clk_out;
// 	integer count;
// 	initial
// 	begin
// 		count=0;
// 		clk_out=0;
// 	end
// 	always@(posedge clr or posedge clk_in)
// 	begin
// 		if(clr)
// 			begin
// 				count=0;
// 				clk_out<=0;
// 			end
// 		else
// 			begin//25mhz
// 				if(count==12500000)//0.5s
// 					begin
// 						count=0;
// 						clk_out<=~clk_out;
// 					end
// 				else
// 					count=count+1;
// 			end
// 	end
// endmodule