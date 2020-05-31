// -----------------------------------------------------------------------------
// This is testbench for MOD7.
// -----------------------------------------------------------------------------

`timescale 1ns/1ps

module mod7_tb();

//--- port definition ---
reg rst, clk, data_in;
wire [2:0] data_out;

// -----------------------------------------------------------------------------
//---Module instantiation---
// -----------------------------------------------------------------------------

mod7 test(
		.clk(clk),
		.rst(rst),
		.data_in(data_in),
		.data_out(data_out));

//--- generate  100M clock  ---
initial begin

	clk = 0;

end

always #5 clk = ~ clk;

// setting rst signal
initial begin
	rst = 1;
	#5 rst =0;
	#15 rst =1;
end

//generate 1 bit data_in 
always @(posedge clk)
  data_in<=($random)%2;


////--- dump file  ---
//initial begin
//	$dumpfile ("wave.vcd");
//	$dumpvars(0,test);
//end



endmodule //testbench
