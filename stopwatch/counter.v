
// -----------------------------------------------------------------------------
// A 60:00 ms counter
// -----------------------------------------------------------------------------
// File   : counter.v
// Create : 2020-05-25 15:25:31
// Revise : 2020-05-25 15:25:31
// Editor : sublime text3, tab size (4)
// -----------------------------------------------------------------------------

module counter(clk_1, rst, clear, sw_en, time_sec_h, time_sec_l, time_msec_h, time_msec_l);

//--- port definition ---
input clk_1, rst, clear, sw_en;
output [2:0] time_sec_h;
output [3:0] time_sec_l, time_msec_l, time_msec_h;

reg [2:0] time_sec_h;
reg [3:0] time_sec_l, time_msec_l, time_msec_h;


//counter for mini second low bits
always @(posedge clk_1 or negedge rst) begin
	if (!rst) begin
		// reset
		time_msec_l <= 0;
	end
	else if (clear) begin
		time_msec_l <= 0;
	end
	else begin
		if (sw_en) begin
			if (time_msec_l == 9)
			time_msec_l <= 0;
			else
			time_msec_l <= time_msec_l+1;
		end
		else 
			time_msec_l <= time_msec_l;

	end

end

//counter for mini second high bits
always @(posedge clk_1 or negedge rst) begin
	if (!rst) begin
		// reset
		time_msec_h <= 0;
	end
	else if (clear) begin
		time_msec_h <= 0;
	end
	else begin
		if (sw_en) begin
			if (time_msec_l == 9) begin
				if (time_msec_h == 9)
					time_msec_h <= 0;
				else
					time_msec_h <= time_msec_h+1;
			end
			else begin
				time_msec_h <= time_msec_h;
			end
		end
	end

end

//counter for second low bits
always @(posedge clk_1 or negedge rst) begin
	if (!rst) begin
		// reset
		time_sec_l <= 0;
	end
	else if (clear) begin
		time_sec_l <= 0;
	end
	else begin
		if (sw_en) begin
			if (time_msec_h == 9 && time_msec_l == 9) begin
				if (time_sec_l == 9)
					time_sec_l <= 0;
				else
					time_sec_l <= time_sec_l+1;
			end
			
			else
			time_sec_l <= time_sec_l;
		end
	end

end

//counter for second high bits
always @(posedge clk_1 or negedge rst) begin
	if (!rst) begin
		// reset
		time_sec_h <= 0;
	end
	else if (clear) begin
		time_sec_h <= 0;
	end
	else begin
		if (sw_en) begin
			if (time_msec_h == 9 && time_msec_l == 9 && time_sec_l == 9)
				if (time_sec_h == 5)
					time_sec_h <= 0;
				else
					time_sec_h <= time_sec_h+1;
			else
			time_sec_h <= time_sec_h;
		end
	end

end

endmodule