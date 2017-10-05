module bit_counter (input clk,input clear, input count, output reg bit_done);
//bit counter with clk, clear, count inputs 
//a bit_done signal as output

//assign the variables to hold the present count values and next values
reg [4:0] p_cnt, n_cnt;

//Set the parameter total 11 bits to count to
parameter no_bit=12;

//The sequential code to synthesise the latches
always @(posedge clk)
	begin
		if (clear)
			//clear
			p_cnt <=4'b0;	
		else
			p_cnt <= n_cnt;
	end
 
 //The combinational code to perform the bit counter it required
always @ (p_cnt, count)  
	begin
		//specify the defaults
		bit_done = 1'b0;
		n_cnt = p_cnt;
		
		//if it counts 12, the bit_done signal will be generated
		if (p_cnt == no_bit)
			bit_done = 1'b1;
		if(count)
			begin
				if(p_cnt == no_bit)
					begin
						//the bit_done signal has been generated then clear
						n_cnt = 1'b0;
					end
				else
					begin
						//count
						n_cnt = p_cnt+1'b1;
					end
			end
	end
endmodule
