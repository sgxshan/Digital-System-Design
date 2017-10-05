module rxd_controller (data_in, reset, clk, half_pulse, done_pulse, bit_done, rxd_shift, rxd_count, reset_baud, clear_bit, load_shift,parity_check);
input data_in;
input reset;
input clk;
input half_pulse;
input done_pulse;
input bit_done;
//receiver controller with clk, reset, half_baud, done_pulse, data_in, bit_done as inputs 

output rxd_shift;
output rxd_count;
output reset_baud;
output clear_bit;
output load_shift;
output parity_check;
//with shift, count, reset_baud, clear_bit, load_shift, parity_check as outputs

//assign the variables to hold the present and next states
reg [1:0]p_state, n_state;
reg rxd_shift;
reg in_data;
reg rxd_count;
reg reset_baud;
reg clear_bit;
reg load_shift;
reg parity_check;

//set the parameter for each state
parameter P=2'b00, Q=2'b01, R=2'b10, S=2'b11;

//The sequential code to synthesise the latches
always @ (posedge clk)
 begin
	if (reset)
		p_state <= P;
	else 
		p_state <= n_state;
end

//The combinational code to perform the baud counter it required
always @ (p_state,done_pulse, half_pulse, bit_done)
	begin 
		reset_baud=0;
		clear_bit=0; 
		rxd_count=0;
		rxd_shift=0;
		load_shift=0;
		parity_check=0;
		n_state=p_state;
		case (p_state)
			P: 
				begin
					//judge whether the start bit or not
					if(data_in==0)
						begin 
							//clear bit counter and baud counter and move to next state
							clear_bit=1;
							reset_baud=1;
							n_state=Q;
						end
					else 
						n_state=P;
				end
			Q: 
				begin
					//the middle of bit can be obtained with half baud pulse
					if(half_pulse)
						begin
							//reset baud and move next state
							reset_baud=1;
							n_state=R;
						end
					else
						n_state=Q;
				end
			R: 
				begin
					if(done_pulse)
						begin
							if(bit_done)
								//if baud done and bit done then move next state
								n_state=S;
							else
								begin
									//count and shift
									rxd_count=1;
									rxd_shift=1;
								end
						end
					else
						n_state=R;
				end
			S: 
				begin
				if(data_in==0)
					begin
						//All the data are shifted so load the whole data to shift register
						//and enable the parity check
						load_shift=1;
						parity_check=1;
					end
				else 
				     n_state=P;
				end
		endcase 
	end
endmodule
