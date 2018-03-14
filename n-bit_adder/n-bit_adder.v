module adder(sum, p, q);

parameter N = 2;

input [N-1:0] p, q;
output reg [N:0] sum;

always@(*) begin
	sum = p + q;
end

endmodule