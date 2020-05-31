// -----------------------------------------------------------------------------
// FSM FOR MOD7
// -----------------------------------------------------------------------------
// File   : mod7.v
// Create : 2020-05-12 21:36:55
// Revise : 2020-05-12 21:36:55
// Editor : sublime text3, tab size (4)
// input  : clk, rst, data_in
// output : data_out
// -----------------------------------------------------------------------------


module mod7(clk, rst, data_in, data_out);


//--- port definition ---
input rst, clk, data_in;
output [2:0] data_out;

wire [2:0] data_out;
reg [15:0] divisor;

//---parameter definition---

parameter S0=3'b000; 
parameter S1=3'b001; 
parameter S2=3'b010; 
parameter S3=3'b011; 
parameter S4=3'b100; 
parameter S5=3'b101; 
parameter S6=3'b110;

reg [2:0] current_state, next_state;
reg [1:0] flag;




//--- Sequential logic: transition from the present state to the next state--
always @(posedge clk or negedge rst) begin
	if (!rst) begin
		// reset
		divisor <= 0;
		current_state <= S0;
	end

	else  begin
		divisor <= {divisor[14:0], data_in};
		current_state <= next_state;	
	end
end


//--- Combinatorial logic: Describe the conditions for state transition--
always @(*) begin
	//default value for nextstate
	next_state = 3'bx;
	flag = {divisor[15],divisor[0]};
	case(current_state)
	S0: 
		case(flag)
		2'b00:  next_state = S0 ;
		2'b01:  next_state = S1 ;
		2'b10:  next_state = S3 ;
		2'b11:  next_state = S4 ;
		endcase
	S1:
		case(flag)
		2'b00:  next_state = S2 ;
		2'b01:  next_state = S3 ;
		2'b10:  next_state = S5 ;
		2'b11:  next_state = S6 ;
		endcase
	S2: 
		case(flag)
		2'b00:  next_state = S4 ;
		2'b01:  next_state = S5 ;
		2'b10:  next_state = S0 ;
		2'b11:  next_state = S1 ;
		endcase
	S3:
		case(flag)
		2'b00:  next_state = S6 ;
		2'b01:  next_state = S0 ;
		2'b10:  next_state = S2 ;
		2'b11:  next_state = S3 ;
		endcase
	S4: 
		case(flag)
		2'b00:  next_state = S1 ;
		2'b01:  next_state = S2 ;
		2'b10:  next_state = S4 ;
		2'b11:  next_state = S5 ;
		endcase
	S5:
		case(flag)
		2'b00:  next_state = S3 ;
		2'b01:  next_state = S4 ;
		2'b10:  next_state = S6 ;
		2'b11:  next_state = S0 ;
		endcase
	S6:
		case(flag)
		2'b00:  next_state = S5 ;
		2'b01:  next_state = S6 ;
		2'b10:  next_state = S1 ;
		2'b11:  next_state = S2 ;
		endcase
	endcase
end


//---real time output Assignments---
assign  data_out = next_state ;


endmodule //mux41


