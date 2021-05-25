module Fourbitcounter(
	input clk,
	output Tc
);


	reg [3:0]counter;
	reg counter_finished;

	always@(posedge(clk))
		begin
			case (counter)
				4'b0000:
					begin
						counter_finished <= 0;
						counter = counter + 1'b1;
					end
				4'b0001: counter = counter + 1'b1;
				4'b0010: counter = counter + 1'b1;
				4'b0011: counter = counter + 1'b1;
				4'b0100: counter = counter + 1'b1;
				4'b0101: counter = counter + 1'b1;
				4'b0110: counter = counter + 1'b1;
				4'b0111: counter = counter + 1'b1;
				4'b1000: counter = counter + 1'b1;
				4'b1001: counter = counter + 1'b1;
				4'b1010: counter = counter + 1'b1;
				4'b1011: counter = counter + 1'b1;
				4'b1100: counter = counter + 1'b1;
				4'b1101: counter = counter + 1'b1;
				4'b1110: counter = counter + 1'b1;
				4'b1111: 
					begin
						counter = 4'b0000;
						counter_finished <= 1;
					end
			endcase
		end

	assign Tc = counter_finished;
	
	
endmodule
	