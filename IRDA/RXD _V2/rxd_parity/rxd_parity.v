module rxd_parity(parity_check,in_data, parity_error, framing_error);
input [9:0]in_data; 
input parity_check;
output parity_error;
output framing_error;
//Parity with in_data and parity_check as inputs
//parity with parity_error and framing_error

//assign the variables to hold the parity bit
wire parity_bit;

//assign variable to hold the input data(exclude start bit, parity bit and stop bit)
wire [7:0]temp_data;
reg parity_error;
reg framing_error;

//parity bit equal to the 9th bit
assign parity_bit= in_data[8];

//hold the input data(exclude start bit, parity bit and stop bit)
assign temp_data= in_data[7:0];

always@(in_data, parity_bit, temp_data,parity_check)
begin
	//if enable parity_check, then do commands
	if(parity_check==1)
		begin
			//framing error condition
			if(in_data[9]==1'b0)
				framing_error=1'b1;
			else
				framing_error=1'b0;
				
			//parity_error condition
			if(parity_bit==^temp_data)
				parity_error=1'b0;
			else
				parity_error=1'b1;
		end
	else
		begin
			//if not enable,then clear
			framing_error=1'b0;
			parity_error=1'b0;
		end
end
endmodule

