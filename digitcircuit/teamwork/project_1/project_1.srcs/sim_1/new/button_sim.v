`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/02/19 14:52:14
// Design Name: 
// Module Name: button_sim
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module button_sim;

reg		CP	;
reg		IN	;
reg	[7:0] cnt;

wire	OUT;
parameter M = 249;
initial begin
	CP = 1'd0;
	forever #10 CP = ~CP;
end

initial begin
    CP = 1'b1;
    IN=1'b0;   
    cnt=8'd0;
    end 
    always #10 CP = ~CP;

always@(posedge CP)begin
	if(cnt == M)
		cnt <= 8'd0;
	else
		cnt <= cnt + 8'd1;
end

always@(posedge CP)begin
	if(((cnt>8'd19) && (cnt<=8'd69)) || ((cnt>8'd149) && (cnt<=8'd199)) )
		IN<= {$random} % 2 ;
	else if((cnt>8'd69)&& (cnt<=8'd149))
		IN <= 1'd0;
	else
		IN<= 1'd1;
end

button
#(
	.CNT_MAX (20'd24)
)
button_inst
(
	.CP(CP),
	.IN(IN),        
	.OUT(OUT)
);
endmodule
