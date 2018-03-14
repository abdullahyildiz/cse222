`timescale 1ns / 1ps

module up_down_counter(clk, rst, enable, up_down, digit_1);

input clk, rst, enable, up_down;
output reg [3:0] digit_1;

always@(posedge clk) begin
	
	if(rst == 1'b1) begin // RESET
		
		digit_1 <= 4'b0000;
	
	end
	else if(up_down == 1'b1 && enable == 1'b1) begin // COUNT UP
		
		if(digit_1 == 4'b1001) begin
		
			digit_1 <= 4'b0000;

		end
		else begin
		
			digit_1 <= digit_1 + 1'b1;
		
		end
	
	end
	else if(up_down == 1'b0 && enable == 1'b1) begin // COUNT DOWN
		
		if(digit_1 == 4'b0000) begin
		
			digit_1 <= 4'b1001;

		end
		else begin
		
			digit_1 <= digit_1 - 1'b1;
		
		end
	
	end
	else begin
	
		digit_1 <= digit_1;
		
	end

end

endmodule
