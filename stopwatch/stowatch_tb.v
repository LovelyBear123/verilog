
// -----------------------------------------------------------------------------
// Copyright (c) 2014-2020 All rights reserved
// -----------------------------------------------------------------------------
// File   : stopwatch_tb.v
// Create : 2020-05-25 17:40:53
// Revise : 2020-05-25 17:40:53
// Editor : sublime text3, tab size (4)
// -----------------------------------------------------------------------------

`timescale 1ns/1ps

module stopwatch_tb();

wire [2:0] time_sec_h;
wire [3:0] time_sec_l, time_msec_l, time_msec_h;
wire time_out;
wire clk_out;

reg clk, rst, sw_en, pause, clear;

integer i;
integer out_file;

stopwatch stopwatch (.clk(clk), 
					.rst(rst), 
					.sw_en(sw_en),
					.pause(pause),
					.clear(clear), 
					.clk_out(clk_out),
					.time_sec_h(time_sec_h),
					.time_sec_l(time_sec_l),
					.time_msec_h(time_msec_h),
					.time_msec_l(time_msec_l),
					.time_out(time_out));


//--- generate  100M clock  ---
initial begin

	clk = 0;

end

always #5 clk = ~ clk;

// setting rst signal
initial begin
	rst = 1;
	pause = 0;
	sw_en = 1;
	clear = 0;
	#5 rst =0;
	#5 rst =1;

	$display("current time is %d %d : %d %d\n",time_sec_h,time_sec_l,time_msec_h, time_msec_l);

	for (i=0;i<120;i=i+1) begin
		#1000 @(posedge clk) begin
		$display("current time is %d %d : %d %d\n",time_sec_h,time_sec_l,time_msec_h, time_msec_l);
		end
	end


	#2000

	pause = 1;
	for (i=0;i<10;i=i+1) begin
		#1000
		@(posedge clk) begin
		$display("when pause=1, time is %d %d : %d %d\n",time_sec_h,time_sec_l,time_msec_h, time_msec_l);
		end
	end
	pause =0;

	for (i=0;i<10;i=i+1) begin
		#1000
		@(posedge clk) begin
		$display("when pause=0, time is %d %d : %d %d\n",time_sec_h,time_sec_l,time_msec_h, time_msec_l);
		end
	end

	sw_en =0;
	for (i=0;i<10;i=i+1) begin
		#1000
		@(posedge clk) begin
		$display("when pause=1, time is %d %d : %d %d\n",time_sec_h,time_sec_l,time_msec_h, time_msec_l);
		end
	end
	sw_en = 1;


	clear =1;
	for (i=0;i<10;i=i+1) begin
		#1000
		@(posedge clk) begin
		$display("when clear=1, time is %d %d : %d %d\n",time_sec_h,time_sec_l,time_msec_h, time_msec_l);
		if ({time_sec_h, time_sec_l, time_msec_h, time_msec_l}!= 16'h0000) begin
			$display("\nerror at time %0t:",$time);
			$stop;
		end
		end
	end
	clear = 0;

    out_file = $fopen("./clk_out.log","w");

	while (1) begin
		#1000
		@(posedge clk) begin
		$fwrite(out_file, "when clear=1, time is %d %d : %d %d\n",time_sec_h,time_sec_l,time_msec_h, time_msec_l);
		//$fwrite(out_file,"%d",$signed(reg_data))​​;
		end
	end


end

endmodule