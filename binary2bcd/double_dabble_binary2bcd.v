`timescale 1ns / 1ps

module binary2bcd(clk, rst, binary, bcd);

input clk, rst;
input [7:0] binary;
output reg [11:0] bcd;

reg [1:0] state;
reg [3:0] numberOfBits;
reg [7:0] binary_temp;
reg [11:0] bcd_temp; 

always@(posedge clk) begin
	if(rst) begin
		numberOfBits <= 0;
		binary_temp <= 0;
		bcd_temp <= 0;
		bcd <= 0;
		state <= 0;
	end
	else begin
		case(state)
		2'b00: begin
			numberOfBits <= 7;
			binary_temp <= binary;
			bcd_temp <= 0;
			state <= 2'b01;
		end
		2'b01: begin
			if(bcd_temp[3:0] > 4'b0100)
				bcd_temp[3:0] <= bcd_temp[3:0] + 4'b0011;

			if(bcd_temp[7:4] > 4'b0100)
				bcd_temp[7:4] <= bcd_temp[7:4] + 4'b0011;

			if(bcd_temp[11:8] > 4'b0100)
				bcd_temp[11:8] <= bcd_temp[11:8] + 4'b0011;
			
			state <= 2'b10;
		end		
		2'b10: begin
			numberOfBits <= numberOfBits - 1'b1;
			
			bcd_temp[11:1] <= bcd_temp[10:0];
			bcd_temp[0] <= binary_temp[7];
			binary_temp[7:1] <= binary_temp[6:0];
			binary_temp[0] <= 1'b0;
			
			if(numberOfBits == 0)
				state <= 2'b11;
			else
				state <= 2'b01;
		end
		2'b11: begin
			bcd <= bcd_temp;
			state <= 2'b00;
		end
		endcase
	end
end

endmodule
