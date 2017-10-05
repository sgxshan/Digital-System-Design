module baud_counter (clk, reset,  done_pulse, IR);
input clk;
input reset;
output done_pulse;
output IR;
//baud counter with clk, reset inputs 
//IR signal and done_pulse signal as outputs

//assign the variables to hold the two ouput signals
//assign the variables to hold the present and next count values
reg done_pulse;
reg IR;
reg [11:0] n_count, p_count;

parameter half_baud = 12'd651; //(1/2)(50M/38400)
parameter IR_baud = 12'd244;   //(3/16)(50M/38400)
parameter my_baud = 12'd1302;  //(50M/38400)


//The sequential code to synthesise the latches
always @(posedge clk)
	begin
		if (reset)
			//clear
			p_count <= 0;	
		else
			p_count <= n_count;
	end
	
//The combinational code to perform the baud counter it required
always @(p_count)
  begin
		//specify the defaults
		done_pulse = 1'b0;
		IR = 1'b0;
		n_count = p_count;
		
		//Condition for IR
		if((p_count>half_baud)&&p_count < (IR_baud + half_baud))
			IR = 1'b1;
		
		//Condition for baud
		if(p_count == my_baud)
			begin
				done_pulse = 1'b1;
				n_count = 1'b0;
			end
			
		else
				n_count=p_count+1'b1;
  end
endmodule
