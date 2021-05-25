module FiveSecondTimer(clock50, Mr, En, load_en, Tc);


	input clock50;
	input Mr;					//Master Reset
	input En;
	input load_en;
	output Tc;

	wire tc1, tc2, tc3;
	wire [9:0]qout1;
	wire [9:0]qout2;
	wire [8:0]qout3;
	reg tc =0;
	reg [9:0]load_value1 = 0;
	reg [8:0]load_value2 = 0;

	Tenbitcounter TB1(clock50, Mr, En, load_en, load_value1, qout1, tc1); 	//tc1 every 20.48us
	Tenbitcounter TB2(tc1, Mr, En, load_en, load_value1, qout2, tc2);			//tc2 every 20.97ms
	Ninebitcounter NB1(tc2, Mr, En, load_en, load_value2, qout3, tc3);		//tc3 every 10.7s	


	always @(posedge(clock50))
	begin
		if (qout3 == 238) tc = 1;			//This will count tc2 238 times, giving 4.99 seconds
		else tc =0;
	end
	
	SRLatch SR1(tc, Mr, Tc);

	
endmodule 