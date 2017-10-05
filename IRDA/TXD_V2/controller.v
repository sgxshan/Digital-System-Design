module controller (send, reset, clk, baud_done, bit_done, shift, count, reset_baud, clear_bit,load_shift);
//transmitter controller with clk, reset, baud_done, bit_done, as inputs 
input send;
input reset;
input clk;
input baud_done;
input bit_done;

//with shift, count, reset baud, clear bit and load shift as outputs
output shift;
output count;
output reset_baud;
output clear_bit;
output load_shift;

reg shift;
reg count;
reg reset_baud;
reg clear_bit;
reg load_shift;

//assign the variables to hold the present and next states
reg [1:0]p_state, n_state;

//set the parameter for each state
parameter S_1=2'b00, S_2=2'b01, S_3=2'b10;

//The sequential code to synthesise the latches
always @ (posedge clk)
 begin
	if (reset)
		p_state <= S_1;
	else 
		p_state <= n_state;
end

//The combinational code to perform the baud counter it required
always @ (send, p_state,send,baud_done, bit_done)
	begin 
		//specify the defaults
		reset_baud=1'b0;
		clear_bit=1'b0; 
		load_shift=1'b0;
		count=1'b0;
		shift=1'b0;
		n_state=p_state;
		case (p_state)
			S_1: 
				begin
					//judge whether the the data send or not
					if(send)
						begin 
							//reset
							clear_bit=1'b1;
							load_shift=1'b1;
							reset_baud=1'b1;
							n_state=S_2;
						end
					else 
						n_state=S_1;
				end
			S_2: 
				begin
					if(baud_done)
						begin
							if(bit_done)
								//if baud done and bit done then move next state
								n_state=S_3;
							else
								begin
									//count and shift
									count=1'b1;
									shift=1'b1;
								end
						end
					else
						n_state=S_2;
				end
			S_3: 
				begin
					if(!send)
						n_state=S_1;
					else
						n_state=S_3;
				end
		endcase 
	end
endmodule

