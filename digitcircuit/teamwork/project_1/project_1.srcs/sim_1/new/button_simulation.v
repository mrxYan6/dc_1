`timescale 1ns / 1ps
`include "/Users/mrx/Library/CloudStorage/OneDrive-个人/programing/digitcircuit/tmpt/dc_1/digitcircuit/teamwork/project_1/project_1.srcs/sources_1/new/ajxd.v"
module button_sim;
	reg	CP,IN;
	wire OUT;
	// parameter M = 249;
	
	initial begin

		$display("start simu");    // 打印开始标记
        $dumpfile("button_wave.vcd");              // 指定记录模拟波形的文件
        $dumpvars(0, button_sim);          // 指定记录的模块层级
		CP = 1;
		IN = 0;   
        #6000
		$display("end simu");    // 打印开始标记
		$finish;      
	end 

	always #3 CP = ~CP;

	// always@(posedge CP)begin
	// 	if(cnt == M)
	// 		cnt <= 8'd0;
	// 	else
	// 		cnt <= cnt + 8'd1;
	// end

	// always@(posedge CP)begin
	// 	if(((cnt>8'd19) && (cnt<=8'd69)) || ((cnt>8'd149) && (cnt<=8'd199)) )
	// 		IN<= {$random} % 2 ;
	// 	else if((cnt>8'd69)&& (cnt<=8'd149))
	// 		IN <= 1'd0;
	// 	else
	// 		IN<= 1'd1;
	// end

	always 
	begin
		#100;
		#10;IN=~IN;
		#10;IN=~IN;
		#10;IN=~IN;
		#10;IN=~IN;
		#10;IN=~IN;
		#10;IN=~IN;
		#10;IN=~IN;
		#10;IN=~IN;
		#10;IN=~IN; 
		#500;
	end
	// button #(.CNT_MAIN (20'd24)) button_inst(.CP(CP),.IN(IN),.OUT(OUT));
	button u1(CP,IN,OUT);
endmodule
