module Inverter (IR, lastbit, txd);
//Inverter block with IR, lastbit ad input and txd as output

input IR;
input lastbit;
output txd;

reg txd;

//the sequential code to synthesise the latches	
always@(lastbit, IR)
begin
	//In 3/16 baud-rate condition
	if(IR == 1'b1)
		begin
			if(lastbit==1'b1)
				txd=1'b0;
			else
				txd=1'b1;
		end
		
	//if IR-0, set the default value to be 0
	else
				txd=1'b0;
end
endmodule
