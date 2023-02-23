`timescale 1ns / 1ps

module SSS;

	// Inputs
	reg clk;
	reg clr;
	reg start;
	reg stopa;
	reg stopb;
	reg pause;

	// Outputs
	wire r1;
	wire g1;
	wire y1;
	wire r2;
	wire g2;
	wire y2;
	wire [3:0] AN;
	wire [7:0] Seg;

	// Instantiate the Unit Under Test (UUT)
	WORK25 uut (
		.clk(clk), 
		.clr(clr), 
		.start(start), 
		.stopa(stopa), 
		.stopb(stopb), 
		.pause(pause), 
		.r1(r1), 
		.g1(g1), 
		.y1(y1), 
		.r2(r2), 
		.g2(g2), 
		.y2(y2), 
		.AN(AN), 
		.Seg(Seg)
	);

	initial begin
		// Initialize Inputs
		clk = 0;//��ʼ
		clr = 0;
		start = 1;
		stopa = 0;
		stopb = 0;
		pause = 0;

		// Wait 100 ns for global reset to finish
		#600000000;
			clk = 1;//���ɵ�����
		clr = 0;
		start = 1;
		stopa = 1;
		stopb = 0;
		pause = 0;

		// Wait 100 ns for global reset to finish
		#200000000;
			clk = 1;//�θɵ�����
		clr = 0;
		start = 1;
		stopa = 0;
		stopb = 1;
		pause = 0;

		// Wait 100 ns for global reset to finish
		#200000000;  //����
			clk = 1;
		clr = 0;
		start = 1;
		stopa = 0;
		stopb = 0;
		pause = 0;
		#1000000000;
		
		clk = 1;     //��ͣ
		clr = 0;
		start = 1;
		stopa = 0;
		stopb = 0;
		pause = 1;
		#500000000;

		// Wait 100 ns for global reset to finish
	clk = 1;     
		clr = 0;
		start = 1;
		stopa = 0;
		stopb = 0;
		pause = 0;
		// Add stimulus here
	end
	always #20 clk=~clk;  //20ns��ת

endmodule

