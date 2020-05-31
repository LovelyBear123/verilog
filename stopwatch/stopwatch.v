// -----------------------------------------------------------------------------
// stopwatch
// -----------------------------------------------------------------------------
// File   : stopwatch.v
// Create : 2020-05-25 16:41:24
// Revise : 2020-05-25 16:41:24
// Editor : sublime text3, tab size (4)
// -----------------------------------------------------------------------------
`include "./counter.v"
`include "./divider_s.v"

module stopwatch(clk, rst, sw_en, pause, clear, clk_out, time_sec_h, time_sec_l, time_msec_h, time_msec_l, time_out);

//--- port definition ---
input clk, rst, clear, sw_en, pause;
output clk_out, time_out;
output [2:0] time_sec_h;
output [3:0] time_sec_l, time_msec_l, time_msec_h;

reg [2:0] time_sec_h;
reg [3:0] time_sec_l, time_msec_l, time_msec_h;
wire clk_1, clk_2;

//notice: time_sec_h_in is an inside sigbal while time_sec_h is output
wire [2:0] time_sec_h_in;
wire [3:0] time_sec_l_in, time_msec_l_in, time_msec_h_in;
reg time_out;

//the set time is 10:00
parameter time_set = 16'h1000;

//instantiate divider to do frequency division
//module divider_s (clk, rst, clk_1, clk_2);
divider_s divider_s (.clk(clk), 
					.rst(rst),
					.clk_1(clk_1),
					.clk_2(clk_2));

assign clk_out = clk_2;

//instantiate counter to do time counting
//module counter(clk_1, rst, clear, sw_en, time_sec_h, time_sec_l, time_msec_h, time_msec_l);
counter counter(.clk_1(clk_1),
				.rst(rst),
				.clear(clear),
				.sw_en(sw_en),
				.time_sec_h(time_sec_h_in),
				.time_sec_l(time_sec_l_in),
				.time_msec_h(time_msec_h_in),
				.time_msec_l(time_msec_l_in));

// generate the pasuse-controled output
always @(posedge clk or negedge rst) begin
	if (!rst) begin
		// reset
		time_sec_h  <=0;
		time_sec_l  <=0;
		time_msec_h <=0;
		time_msec_l <=0; 
	end
	else if (!pause) begin
		time_sec_h  <=time_sec_h_in ;
		time_sec_l  <=time_sec_l_in ;
		time_msec_h <=time_msec_h_in;
		time_msec_l <=time_msec_l_in; 
	end

	else begin
		time_sec_h  <=time_sec_h ;
		time_sec_l  <=time_sec_l ;
		time_msec_h <=time_msec_h;
		time_msec_l <=time_msec_l; 
	end
end

//generate time_out signal
always @(posedge clk or negedge rst) begin
	if (!rst)
		time_out <= 0;
	else  begin
		if ({time_sec_h, time_sec_l, time_msec_h, time_msec_l} == time_set)
			time_out = 1;
		else if ({time_sec_h, time_sec_l, time_msec_h, time_msec_l} == 16'h5999)
			time_out = 0;
	end
end

endmodule