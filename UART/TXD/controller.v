module controller (input send, input reset, input clk, input baud_done, input bit_done, output reg shift,output reg count,output reg reset_baud, output reg clear_bit,output reg load_shift);
//transmitter controller with clk, reset, baud_done, bit_done, as inputs 
//with shift, count, reset baud, clear bit and load shift as outputs

//assign the variables to hold the present and next states
reg [1:0]p_state, n_state;

//set the parameter for each state
parameter P=2'b00, Q=2'b01, S=2'b11;

//The sequential code to synthesise the latches
always @ (posedge clk)
 begin
	if (reset)
		p_state <= P;
	else 
		p_state <= n_state;
end

//The combinational code to perform the baud counter it required
always @ (send, p_state,send,baud_done, bit_done)
	begin 
		//specify the defaults
		reset_baud=0;
		clear_bit=0; 
		load_shift=0;
		count=0;
		shift=0;
		n_state=p_state;
		case (p_state)
			P: 
				begin
					//judge whether the the data send or not
					if(send)
						begin 
							//reset
							clear_bit=1;
							load_shift=1;
							reset_baud=1;
							n_state=Q;
						end
					else 
						n_state=P;
				end
			Q: 
				begin
					if(baud_done)
						begin
							if(bit_done)
								//if baud done and bit done then move next state
								n_state=S;
							else
								begin
									//count and shift
									count=1;
									shift=1;
								end
						end
					else
						n_state=Q;
				end
			S: 
				begin
					if(!send)
						n_state=P;
					else
						n_state=S;
				end
		endcase 
	end
endmodule

