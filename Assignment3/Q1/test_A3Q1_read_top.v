module A3Q1_top;

	reg clk, input_valid;
	reg[3:0] row_num;
	wire[15:0] row_data;
	wire output_valid;
	
	// INSTANTIATE THE MODULE, CHECK THE ORDER OF ARGS
	read READ (clk, row_num, input_valid, output_valid,row_data);

	always @(output_valid) begin
		if(output_valid == 1) begin
			$display("time=%d row_num=%d row_data=%d", $time, row_num, row_data);
		end
	end

	reg[32:0] count=0;

	always @(posedge clk) begin
		if (count  == 30) begin
			$finish;
		end
		else begin
			count <= count+1;
		end
	end

	initial begin
		forever begin
			clk=0;
			#5
			clk=1;
			#5
			clk=0;
		end
	end
	
	// reset input_valid before every pos edge
	initial begin
		#3
		input_valid=0;
		forever begin
			input_valid=0;
			#10
			input_valid=0;
		end
	end
	
	// set input_valid at every third pos edge
	initial begin
		#5
		input_valid=1;
		forever begin
			input_valid=1;
			#30
			input_valid=1;
		end
	end

	initial begin
		#3 // time = 3, next pos edge @ time = 5, op @ time = 15 (after one cycle)
		row_num=1;
		
		#20 // time = 23 , next pos edge @ time = 25, NO op should be shown since input_valid = 0
		row_num = 1;

		#10 // time = 33, next pos edge @ time = 35, op @ time = 35 (same cycle)
		row_num=1;
		
		#30 // time = 63, next pos edge @ time = 65, op @ time = 65 (same cycle)
		row_num=1;

		#30 // time = 93, next pos edge @ time = 95, op @ time = 115 (after two cycles)
		row_num=2;
		
		#30 // time = 123, next pos edge @ time = 125, op @ time = 145 (after two cycles)
		row_num=7;

		#30 // time = 153, next pos edge @ time = 155, op @ time = 155 (same cycle)
		row_num=7;

		#30 // time = 183, next pos edge @ time = 185, op @ time = 205 (after two cycles)
		row_num=13;
		
		#30 // time = 213, next pos edge @ time = 215, op @ time = 235 (after two cycles)
		row_num=14;
		
		#30 // time = 243, next pos edge @ time = 245, op @ time = 265 (after two cycles)
		row_num=15;
		
		#30 // time = 273, next pos edge @ time = 275, op @ time = 295 (after two cycles)
		row_num=0;
		
		// time = 305, same op as previous
	end
    
	
endmodule
