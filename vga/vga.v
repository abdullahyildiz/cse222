`timescale 1ns / 1ps

`define PAL 640		//--Pixels/Active Line (pixels)
`define LAF 480		//--Lines/Active Frame (lines)
`define PLD 800	   //--Pixel/Line Divider
`define LFD 521	   //--Line/Frame Divider
`define HPW 96		   //--Horizontal synchro Pulse Width (pixels)
`define HFP 16		   //--Horizontal synchro Front Porch (pixels)
//`define HBP 48		--Horizontal synchro Back Porch (pixels)
`define VPW 2   		//--Vertical synchro Pulse Width (lines)
`define VFP 10		   //--Vertical synchro Front Porch (lines)
//`define VBP 29     //--Vertical synchro Back Porch (lines)

module vga(ck, Hcnt, Vcnt, HS, VS, outRed, outGreen, outBlue);
	input ck;
	output reg HS, VS;
	output reg [2:0] outRed, outGreen;
	output reg [1:0] outBlue;

	output reg [9:0] Hcnt, Vcnt;	
	reg ck25MHz;
	
	// -- divide 50MHz clock to 25MHz

	always @ (posedge ck)
		ck25MHz<= ~ck25MHz;
		
	always @ (posedge ck25MHz) begin
		if (Hcnt == `PLD-1) begin
			Hcnt<= 10'h0;
			if (Vcnt == `LFD-1) 
				Vcnt <= 10'h0;
			else 
				Vcnt <= Vcnt + 10'h1;
		end
		else 
			Hcnt<= Hcnt +10'h1;
	end
			
	
//-- Generates HS - active low
	always @(posedge ck25MHz) begin
		if (Hcnt == `PAL-1 +`HFP)
			HS<=1'b0;
		else if (Hcnt == `PAL-1+`HFP+`HPW)
			HS<=1'b1;
	end

//-- Generates VS - active low
	always @(posedge ck25MHz) begin
		if (Vcnt ==`LAF-1+`VFP)
			VS <= 1'b0;
		else if (Vcnt== `LAF-1+`VFP+`VPW)
			VS <= 1'b1;	
	end 



	always @ (posedge ck25MHz) begin
		
		if ((Hcnt <`PAL) && (Vcnt < `LAF)) begin
			if (Vcnt[7:6] == 2'b01) begin
				 outRed <= Vcnt[5:3]; 
				 outGreen <= 3'b000; 
				 outBlue <= 2'b00; 
			end
			else if (Vcnt[7:6] == 2'b00) begin
				 outRed <= 3'b000; 
				 outGreen <= Vcnt[5:3]; 
				 outBlue <= 2'b00; 
			end
			else if (Vcnt[7:6] == 2'b10) begin
				 outRed <= 3'b000; 
				 outGreen <= 3'b000; 
				 outBlue <= Vcnt[5:4]; 
			end
			else begin
				outRed[2:1] <= Vcnt[5:4]; 
				outGreen[2:1] <= Vcnt[5:4]; 
				outBlue <= Vcnt[5:4]; 
			end
		end
		else begin
			outRed <= 3'b000;
			outGreen <= 3'b000;
			outBlue <= 2'b00;
		end
	end
			
endmodule
