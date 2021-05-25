module SRLatch (
	input s, r,
	output Q
	);
	

reg out;

always @(*)
	begin 
		if (s & ~r) out = 1'b1;
		else if (r & ~s) out = 1'b0;
		else if (r & s) out = 1'b0;
	end

assign Q = out;


endmodule

