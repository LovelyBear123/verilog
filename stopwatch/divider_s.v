
// -----------------------------------------------------------------------------
// frequency divider
// -----------------------------------------------------------------------------
// File   : divider_s.v
// Create : 2020-05-25 16:04:26
// Revise : 2020-05-25 16:04:26
// Editor : sublime text3, tab size (4)
// -----------------------------------------------------------------------------

//clk_1: 1hz clk_2: 25Mhz
module divider_s (clk, rst, clk_1, clk_2);
input clk, rst;
output clk_1, clk_2;

reg clk_1, clk_2;

//flag for counter
reg [19:0] flag_1;
reg [1:0] flag_2;


//divider for clk_2: 25Mhz
always @(posedge clk or negedge rst) begin
	if (!rst) begin
		// reset
		flag_2 <= 0;
		clk_2 <= 0;
	end
	else if (flag_2 == 2'd1) begin
		clk_2 = ~clk_2;
		flag_2 <= 0;
	end
	else
		flag_2 <= flag_2 +1;
end

//divider for clk_1: 1Mhz
always @(posedge clk or negedge rst) begin
	if (!rst) begin
		// reset
		flag_1 <= 0;
		clk_1 <= 0;
	end
	else if (flag_1 == 20'd49) begin  //if you want a secondwatch, change to 49999
		clk_1 = ~clk_1;
		flag_1 <= 0;
	end
	else
		flag_1 <= flag_1 +1;
end

endmodule
