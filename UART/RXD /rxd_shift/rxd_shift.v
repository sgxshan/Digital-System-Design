module rxd_shift (clk, load, serial_in, rshift,data, reset,data_out1,data_out2);
input clk;
input load;
input reset;
input rshift;
input serial_in;
//shift register with clk, reset, load, rshift, serial_in inputs 

//output the shifted data
output [9:0]data;

//assign to variables to load the data and separate in two parts for 7segments
output [3:0]data_out1;
output [3:0]data_out2;

//assign the variables to hold the present and next count values
reg[9:0] pshift, nshift;
reg [3:0]data_out1;
reg [3:0]data_out2;

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
		
		//if all the data are shifted then load the data to two registers to connected to 7segments
		if(load)
			begin
				data_out1=data[7:4];    //the first seven segment
				data_out2=data[3:0];    //the second seven segment
			end
		if (reset)
			nshift = 12'b0;
		if(rshift)
			begin
				//shift
				nshift = pshift >> 1;
				nshift[9] = serial_in;
			end
	end
endmodule

