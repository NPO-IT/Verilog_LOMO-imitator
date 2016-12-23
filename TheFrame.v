module TheFrame (
	input				clk,
	input				sync,
	input				reset,
	output	reg	MK,
	output	reg	CLK,
	output	reg	DAT
);
reg	[2:0]		syncReg;
wire				syncFront;			
always@(posedge clk) syncReg <= { syncReg[1:0],  sync };
assign	syncFront	=	(!syncReg[2] & syncReg[1]);

// Common
reg	[8:0]		frmNum;
reg	[5:0]		strNum;
// Static
reg	[11:0]	OK1	=	12'd1101;
reg	[11:0]	OK2	=	12'd1202;
reg	[11:0]	OK3	=	12'd1303;
reg	[11:0]	VK1	=	12'd0;
reg	[11:0]	VK2	=	12'd240;
reg	[11:0]	VK3	=	12'd3855;
reg	[11:0]	UF1	=	12'd1365;
reg	[11:0]	UF2	=	12'd2730;
reg	[11:0]	UF3	=	12'd4095;
reg	[7:0]		corr	=	8'd101;
reg	[7:0]		pel	=	8'd111;
reg	[7:0]		XD		=	8'd121;
reg	[7:0]		YD		=	8'd131;
reg	[7:0]		RM		=	8'd141;
reg	[7:0]		POS	=	8'd151;
reg	[7:0]		ARU	=	8'd161;
// Structure
wire	[15:0]	w[0:19];
assign			w[0]	=	{frmNum[8:0],	strNum[5:0],	1'b1	};
assign			w[1]	=	{OK1[11:0],		corr[7:4]				};
assign			w[2]	=	{OK2[11:0],		pel[7:4]					};
assign			w[3]	=	{OK3[11:0],		XD[7:4]					};
assign			w[4]	=	{VK1[11:0],		YD[7:4]					};
assign			w[5]	=	{VK2[11:0],		RM[7:4]					};
assign			w[6]	=	{VK3[11:0],		POS[7:4]					};
assign			w[7]	=	{UF1[11:0],		ARU[7:4]					};
assign			w[8]	=	{UF2[11:0],							4'd0	};
assign			w[9]	=	{UF3[11:0],							4'd0	};
assign			w[10]	=	{frmNum[8:0],	strNum[5:0],	1'b0	};
assign			w[11]	=	{OK1[11:0],		corr[3:0]				};
assign			w[12]	=	{OK2[11:0],		pel[3:0]					};
assign			w[13]	=	{OK3[11:0],		XD[3:0]					};
assign			w[14]	=	{VK1[11:0],		YD[3:0]					};
assign			w[15]	=	{VK2[11:0],		RM[3:0]					};
assign			w[16]	=	{VK3[11:0],		POS[3:0]					};
assign			w[17]	=	{UF1[11:0],		ARU[3:0]					};
assign			w[18]	=	{UF2[11:0],							4'd0	};
assign			w[19]	=	{UF3[11:0],							4'd0	};

reg				sequence;
reg	[3:0]		bitCnt;
reg	[4:0]		wrdCnt;

always@(posedge clk or negedge reset) begin
	if (~reset) begin
		frmNum <= 9'd1023;
		strNum <= 6'd63;
		CLK <= 1'b0;
		bitCnt <= 4'd0;
		wrdCnt <= 5'd19;
		sequence <= 1'b0;
		DAT <= 1'b0;
		MK <= 1'b0;
	end else begin
		if(syncFront)begin
			CLK <= ~CLK;
			sequence <= sequence + 1'b1;
			case (sequence)
				0: begin
					MK <= 1'b0;
					DAT <= w[wrdCnt][bitCnt];
					bitCnt <= bitCnt - 1'b1;
					if(bitCnt == 4'd0) begin
						wrdCnt <= wrdCnt + 1'b1;
						if(wrdCnt == 5'd9) begin
							strNum <= strNum + 1'b1;
						end else
						if(wrdCnt == 5'd19) begin
							strNum <= strNum + 1'b1;
							if (strNum == 6'd63) begin
								frmNum <= frmNum + 1'b1;
								if (frmNum == 9'd511)
									MK <= 1'b1;
							end
							wrdCnt <= 5'b0;
						end
					
					end
				end
			endcase
		end
	end
end
endmodule
