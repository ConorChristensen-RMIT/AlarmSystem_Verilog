module Lab4(
	input R1, R2, R3, arm_sw_n, panic_sw_n, RESET, clock50,
	output DISARM_LED, ARM_TRIG_LED, SIREN, STROBE, R1_LED, R2_LED, R3_LED
);


wire AT, ST, armed, panic;		//Alarm timer and Set timer wires
reg FiveSecMr = 0;
reg FiveSecEn = 0;
reg FiveSecLoad_en = 0;
reg TwentySecMr = 0;
reg TwentySecEn = 0;
reg TwentySecload_en = 0;
reg sir = 0, str = 0;
reg Strload_en =0;
reg StrMr=0;
reg arm_reset =0;
reg panic_reset =1;

assign DISARM_LED = ~armed;
assign ARM_TRIG_LED = armed;
assign R1_LED = R1;
assign R2_LED = R2;
assign R3_LED = R3;

reg SD_Load =0;
reg SD_En =1;
reg [9:0]SD_LoadV = 0;
reg [9:0]qout11;
reg [9:0]qout12;
reg SD_Mr = 0;


wire first_step_down, new_clock;
Tenbitcounter SD1 (clock50, SD_Mr, SD_En, SD_Load, SD_LoadV, Qout11, first_step_down);
Tenbitcounter SD2 (first_step_down, SD_Mr, SD_En, SD_Load, SD_LoadV, Qout11, new_clock);

Switch SW1(arm_sw_n, RESET, armed);
Switch SW2(panic_sw_n, RESET, panic);
FiveSecondTimer TS1(clock50, FiveSecMr, FiveSecEn, FiveSecLoad_en, ST);
TwentySecondTimer TWS1(clock50, TwentySecMr, TwentySecEn, TwentySecload_en, AT);

FiveHzBlink FHZ(clock50, StrMr, str, Strload_en, STROBE);
assign SIREN = sir;


always@(posedge(new_clock))
begin
	TwentySecMr = 0;
	FiveSecMr = 0;
	
	if(RESET)				//Reset handler
	begin
	FiveSecMr = 1;
	TwentySecMr = 1;
	sir = 0;
	str = 0;
	end
	
	else if (armed | panic ==1)				//ASM first condition
	begin
		TwentySecEn = 1;
		FiveSecEn = 1;
	
		if (AT == 0 | panic==1)					//ASM second condition
		begin
			
			if ((R1 == 1'b1) | (R2 == 1'b1) | (R3 == 1'b1) | panic==1) //ASM third condition
			begin
				TwentySecMr = 1;
				if (ST == 1 | panic ==1)		//ASM fourth condition. If met alarm =>triggered
				begin
					sir = 1;
					str = 1;
					
				end
			end	
		end

		else
		begin
			sir =0;
			str =0;
			TwentySecMr = 1;
		end
	end
	else if (~armed | AT)						//Disarm register set.
	begin
		TwentySecMr = 1;
		FiveSecMr = 1;
		sir = 0;
		str = 0;
		TwentySecEn = 0;
		FiveSecEn = 0;
	end	
end



endmodule
