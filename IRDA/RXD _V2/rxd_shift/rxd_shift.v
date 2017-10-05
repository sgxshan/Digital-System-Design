module rxd_shift (clk, serial_in, rshift,data, reset);
input clk;
input reset;
input rshift;
input serial_in;
//shift register with clk, reset, load, rshift, serial_in inputs 

//output the shifted data
output [9:0]data;

//assign the variables to hold the present and next count values
reg[9:0] pshift, nshift;

//set the parallel out to be the present value
assign data=pshift;

//the sequential code to synthesise the latches
always@(posedge clk)
begin 
   if (clk)
   pshift<=nshift;
end

//The combinational code to perform the baud counter it required
always@(pshift,reset,rshift,serial_in)
	begin 
		// specify the defaults
		nshift=pshift;
		if (reset)
			nshift = 10'b0;
		if(rshift)
			begin
				//shift
				nshift = pshift >> 1;
				nshift[9] = serial_in;
			end
	end
endmodule

