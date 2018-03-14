
module testbench_up_down_counter;

	reg tb_clk, tb_rst, tb_enable, tb_up_down;
	wire [3:0] tb_digit_1;

	reg [3:0] digit_1_exp;
	  
  up_down_counter design_under_test(.clk(tb_clk), .rst(tb_rst), .enable(tb_enable), .up_down(tb_up_down), .digit_1(tb_digit_1));
	  
	integer i = 0;
	  
	// generate clock signal
	always begin
	    
		tb_clk = 0;
	    #5;
	    tb_clk = 1;
	    #5;
	    
	end
	  
	initial begin
	    
	    // Dump waves
	    $dumpfile("dump.vcd");
	    $dumpvars(1);
	    
	    // initialize inputs
	    tb_clk = 1'b0;
	    tb_rst = 1'b1;
      	tb_enable = 1'b1;
	    tb_up_down = 1'b0;

	    digit_1_exp = 4'b0000;
    
	    @(posedge tb_clk); // wait until positive edge of clock signal
	    
	    #2; // progress two units in time
	    
	    tb_rst = 1'b0; // set reset to 0
	    
	    for(i = 0; i < 20; i = i + 1) begin
	      
	    	@(negedge tb_clk); // wait until negative edge of clock signal
	      
	      	tb_up_down = $random; // set up_down randomly

          	if(tb_up_down == 1'b1) begin
            
              	if(digit_1_exp == 4'b1001) begin
                  
                  digit_1_exp = 4'b0000;

              	end
             	else begin
                  
                  digit_1_exp = digit_1_exp + 4'b0001;

              	end
          	
            end
          	else begin
            
              	if(digit_1_exp == 4'b0000) begin
                  
                  digit_1_exp = 4'b1001;

              	end
             	else begin
                  
                  digit_1_exp = digit_1_exp - 4'b0001;

              	end
          	
            end

	      	@(posedge tb_clk); // wait until positive edge of clock signal

	      	#2; // progress two units in time

	      	if(tb_digit_1 != digit_1_exp) begin

	      		$display("ERROR: Wrong output detected! actual/expected values of digit_1 is %d/%d", tb_digit_1, digit_1_exp);
	      		$finish;

	      	end


          $display("time: %0d enable = %b, up_down = %b, digit_1 = %d", $time, tb_enable, tb_up_down, tb_digit_1);
	      
	    end
	    
	    $display("SUCCESS: Congratulations. Your design works as expected.");

	    $finish;
	    
	end
  
endmodule