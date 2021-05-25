module TwentySecondTimer(clock50, Mr, En, load_en, Tc);


	input clock50;
	input Mr;					//Master Reset
	input En;
	input load_en;
	output Tc;
	
	wire tc1;
	
TenSecondTimer TS1(clock50, Mr, En, load_en, tc1);

TenSecondTimer TS2(clock50, Mr, tc1, load_en, Tc);


endmodule 