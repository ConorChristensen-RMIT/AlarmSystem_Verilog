module FiveHzBlink(clock50, Mr, En, load_en, Qout);

	parameter width = 10;

	input clock50;
	input Mr;					//Master Reset
	input En;
	input load_en;
	output Qout;

wire tc1, tc2, tc3;
wire [9:0]qout1;
wire [9:0]qout2;
wire [2:0]qout3;
reg tc = 1'b0;
reg TH_Mr =0;

reg [9:0]load_value1 = 0;
reg [2:0]load_value2 = 0;
 
Tenbitcounter TB1(clock50, Mr, En, load_en, load_value1, qout1, tc1); 	//tc1 every 20.48us
Tenbitcounter TB2(tc1, Mr, En, load_en, load_value1, qout2, tc2);		//tc2 every 20.97ms
Threebitcounter THB1(tc2, TH_Mr, En, load_en, load_value2, qout3, tc3);		//qout3 == 5 every 0.104s

always@(posedge(tc2))
begin
	if (~En) tc=0;
	else if (qout3 == 5) 
	begin
		tc = ~tc;
		TH_Mr = 1;
	end
	else TH_Mr = 0;
end


assign Qout = tc;

endmodule 