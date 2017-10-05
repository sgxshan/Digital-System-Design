module baud_done (clk, reset, delay_pulse, done_pulse);
input clk;
input reset;
output delay_pulse;
output done_pulse;
//baud counter with clk, reset inputs 
//two pulses half_pulse and done_pulse signal as outputs

//assign the variables to hold the two ouput signals
//assign the variables to hold the present and next count values
reg delay_pulse;
reg done_pulse;
reg [11:0] n_count, p_count;

//Set the parameter 50M/Baud_rate(38400) to count to
parameter delay_baud = 12'd60;
parameter my_baud = 12'd1302;

//The sequential code to synthesise the latches
always @(posedge clk)
	begin
		if (reset)
			//clear
			p_count <= 1'b0;	
		else
			p_count <= n_count;
	end
	
//The combinational code to perform the baud counter it required
always @(p_count)
  begin
		//specify the defaults
		delay_pulse = 1'b0;
		done_pulse = 1'b0;
		n_count = p_count;
		
		//Condition for delay_pulse
		if(p_count == delay_baud)
				delay_pulse = 1'b1;
				
		//Condition for baud
		if(p_count == my_baud)
			begin
				done_pulse = 1'b1;
				n_count = 12'b0;
			end
		else
			n_count=p_count+1'b1;
  end
endmodule

