module shift (input clk, input load, input shift, input [11:0]dat, input reset,output lastbit);
//shift register with clk, reset, load, rshift, 12 bits data as inputs 
//with lastbit as output

//assign the variables to hold the present and next count values
reg[11:0] pshift, nshift;

//set the lastbit
assign lastbit=pshift[0];

//the sequential code to synthesise the latches
always@(posedge clk)
begin 
   if (clk)
   pshift<=nshift;
end

//The combinational code to perform the baud counter it required
always@(pshift,load,shift,dat, reset)
	begin 
		// specify the defaults
		nshift=pshift;
		if (reset)
			nshift = 12'b1;
		else if (load)
			//load
			nshift=dat;
		else if(shift)
			begin
				//shift
				nshift = pshift >> 1;
				nshift[11] = 1'b1;
			end
	end
endmodule




