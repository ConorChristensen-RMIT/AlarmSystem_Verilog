module TwentymsTimer(clock50, Mr, En, load_en, load_value, Tc);

	parameter width = 10;

	input clock50;
	input Mr;					//Master Reset
	input En;
	input load_en;
	input [width-1:0]load_value;
	output Tc;

wire tc1, tc2;

Tenbitcounter(clock50, Mr, En, load_en, load_value, tc1); 	//tc1 every 20.48us
Tenbitcounter(tc1, Mr, En, load_en, load_value, tc2);			//tc2 every 20.97ms
SRLatch(tc2, Mr, Tc);


endmodule 