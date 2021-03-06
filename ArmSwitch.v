module ArmSwitch(
	input arm_sw_n,
	output ARMED
	);
	
	reg armed = 1'b0;
	wire arm_sw = ~arm_sw_n;
	SRLatch(arm_sw, arm_sw_n, q);
	
	
	always@(posedge(q))
		begin
			if (armed == 1'b0) armed = 1'b1;
			else armed = 1'b0;
		end

	assign ARMED = armed;
	
endmodule 