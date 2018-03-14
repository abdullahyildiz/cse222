`timescale 1ns / 1ps

module tb_part_a;

parameter BITSIZE = 4;

	// Inputs
	reg clk;
	
	// Ten numbers
	reg [BITSIZE-1:0] a, b, c, d, e, f, g, h, i, j;

	// Outputs
	wire [BITSIZE+4-1:0] x;

	// Instantiate the Unit Under Test (UUT)
	top #(BITSIZE) uut (
		.clk(clk), 
		.x(x), 
		.a(a), 
		.b(b), 
		.c(c), 
		.d(d), 
		.e(e), 
		.f(f), 
		.g(g), 
		.h(h), 
		.i(i), 
		.j(j)
	);

	// Generate clock with a period of 10 units
	always begin
		clk <= 0;
		#5;
		clk <= 1;
		#5;
	end

   integer counter;
 
	initial begin
		// Dump waves
		$dumpfile("dump.vcd");
		$dumpvars(1);
	
		// Initialize Inputs
		a = 0;
		b = 0;
		c = 0;
		d = 0;
		e = 0;
		f = 0;
		g = 0;
		h = 0;
		i = 0;
		j = 0;

		// Add stimulus here
		for(counter = 0; counter < 100; counter = counter + 1) begin
			@(posedge clk);
			#5		a <= $random;
					b <= $random;
					c <= $random;
					d <= $random;
					e <= $random;
					f <= $random;
					g <= $random;
					h <= $random;
					i <= $random;
					j <= $random;
		end
		
		$finish;
	end
      
endmodule
