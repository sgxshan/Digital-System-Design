module parity(data_in, Data_out);
input [7:0]data_in; 
output [11:0]Data_out;
//Parity with data_in inputs and data_out outputs

//assign the variables to hold the parity bit
wire parity_bit;

//Dat_out has stop bit, start bit, data_in, parity bit and stop bit
assign parity_bit =^data_in;
assign Data_out = {1'b1,parity_bit,data_in,1'b0,1'b1};
endmodule
