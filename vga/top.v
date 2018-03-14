`timescale 1ns / 1ps

module top(mclk, OutBlue, OutGreen, OutRed, HS, VS);
	input mclk;
	output [2:0] OutRed;
	output [2:0] OutGreen;
	output [1:0] OutBlue;
	output HS, VS;
	
	vga vgainst(.ck(mclk), .HS(HS), .VS(VS), .outRed(OutRed), .outGreen(OutGreen), .outBlue(OutBlue));

endmodule
