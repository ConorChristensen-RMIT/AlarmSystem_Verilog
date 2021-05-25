module HundredmsTimer(clock50, Mr, En, load_en, Tc);

	parameter width = 10;

	input clock50;
	input Mr;					//Master Reset
	input En;
	input load_en;
	output Tc;

wire tc1, tc2;

Tenbitcounter(clock50, Mr, En, load_en, load_value, tc1); 	//tc1 every 20.48us
Ninebitcounter(tc1, Mr, En, load_en, load_value, tc2);			//tc2 every 20.97ms
SRLatch(tc2, Mr, Tc);


endmodule 