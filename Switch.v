module Switch(
	input arm_sw_n, reset,
	output ARMED
	);
	
	reg armed = 1'b0;
	wire arm_sw = ~arm_sw_n;
	SRLatch SR1(arm_sw, arm_sw_n, q);
	
	
	always@(posedge(q), posedge(reset))
		begin
			if (reset) armed = 0;
			else if (q) armed = ~armed;
		end

	assign ARMED = armed;
	
endmodule 