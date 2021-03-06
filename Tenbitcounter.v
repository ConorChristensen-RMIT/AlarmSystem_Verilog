module Tenbitcounter(clock50, Mr, En, load_en, load_value, Qout, Tc);

	parameter width = 10;

	input clock50;
	input Mr;					//Master Reset
	input En;
	input load_en;
	input [width-1:0]load_value;
	output [width-1:0]Qout;
	output Tc;
	

	
	reg [width-1:0]counter=0;
	reg counter_finished=0;
	
	
	always@(posedge(clock50))
		begin
			if (Mr) counter = 0;
			else if (load_en) counter[width-1:0] = load_value[width-1:0];
			else if (En)
				begin
					if (counter == ((2**width)-1)) 
						begin
							counter = 0;
							counter_finished = 1;
						end
					else if (counter == 0)
						begin
							counter_finished = 0;
							counter = counter + 1;
						end
					else counter = counter + 1'b1;
				end
		end

	assign Qout = counter;
	assign Tc = counter_finished;
	
	
endmodule
	