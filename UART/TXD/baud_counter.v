module baud_counter (input clk,input reset, output reg baud_done);
//baud counter with clk, reset inputs 
//a pulse baud_done signal as output

//assign the variables to hold the present count values and next values
reg [11:0] n_count, p_count;

//Set the parameter 50M/Baud_rate(38400) to count to
parameter my_baud = 12'd1302;

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
		baud_done = 1'b0;
		n_count = p_count;
		if(p_count == my_baud)
			begin
				baud_done = 1'b1;
				n_count = 12'b0;
			end
		else
		//count
			n_count=p_count+1'b1;
  end
endmodule
