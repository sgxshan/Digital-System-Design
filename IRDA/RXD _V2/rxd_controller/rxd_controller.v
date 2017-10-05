module rxd_controller (data_in, reset, clk, delay_pulse, done_pulse, bit_done, rxd_shift, rxd_count, reset_baud, clear_bit, parity_check);
input data_in;
input reset;
input clk;
input delay_pulse;
input done_pulse;
input bit_done;
//receiver controller with clk, reset, done_pulse, data_in, bit_done as inputs 

output rxd_shift;
output rxd_count;
output reset_baud;
output clear_bit;
output parity_check;
//with shift, count, reset_baud, clear_bit,  parity_check as outputs

//assign the variables to hold the present and next states
reg [1:0]p_state, n_state;
reg rxd_shift;
reg in_data;
reg rxd_count;
reg reset_baud;
reg clear_bit;
reg parity_check;

//set the parameter for each state
parameter S_1=2'b00, S_2=2'b01, S_3=2'b10, S_4=2'b11;

//The sequential code to synthesise the latches
always @ (posedge clk)
 begin
	if (reset)
		p_state <= S_1;
	else 
		p_state <= n_state;
end

//The combinational code to perform the baud counter it required
always @ (p_state,data_in,delay_pulse, delay_pulse, bit_done,done_pulse)
	begin 
		reset_baud=1'b0;
		clear_bit=1'b0; 
		rxd_count=1'b0;
		rxd_shift=1'b0;
		parity_check=1'b0;
		n_state=p_state;
		case (p_state)
			S_1: 
				begin
					//judge whether the start bit or not
					if(data_in==1'b0)
						begin 
							//clear bit counter and baud counter and move to next state
							clear_bit=1'b1;
							reset_baud=1'b1;
							n_state=S_2;
						end
					else 
						n_state=S_1;
				end
			S_2: 
				begin
					//the middle of bit can be obtained with half baud pulse
					if(delay_pulse)
						begin
							//reset baud and move next state
							reset_baud=1'b1;
							n_state=S_3;
						end
					else
						n_state=S_2;
				end
			S_3: 
				begin
					if(done_pulse)
						begin
							if(bit_done)
								//if baud done and bit done then move next state
								n_state=S_4;
							else
								begin
									//count and shift
									rxd_count=1'b1;
									rxd_shift=1'b1;
								end
						end
					else
						n_state=S_3;
				end
			S_4: 
				begin
						parity_check=1'b1;
						if(data_in==1'b0)
							n_state=S_1;
						else
							n_state=S_4;
				end
		endcase 
	end
endmodule

