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
assign syncFront	=	(!syncReg[2] & syncReg[1]);

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
wire	[15:0]	w00	=	{frmNum[8:0],	strNum[5:0],	1'b1	};
wire	[15:0]	w01	=	{OK1[11:0],		corr[7:4]				};
wire	[15:0]	w02	=	{OK2[11:0],		pel[7:4]					};
wire	[15:0]	w03	=	{OK3[11:0],		XD[7:4]					};
wire	[15:0]	w04	=	{VK1[11:0],		YD[7:4]					};
wire	[15:0]	w05	=	{VK2[11:0],		RM[7:4]					};
wire	[15:0]	w06	=	{VK3[11:0],		POS[7:4]					};
wire	[15:0]	w07	=	{UF1[11:0],		ARU[7:4]					};
wire	[15:0]	w08	=	{UF2[11:0],							4'd0	};
wire	[15:0]	w09	=	{UF3[11:0],							4'd0	};
wire	[15:0]	w10	=	{frmNum[8:0],	strNum[5:0],	1'b0	};
wire	[15:0]	w11	=	{OK1[11:0],		corr[3:0]				};
wire	[15:0]	w12	=	{OK2[11:0],		pel[3:0]					};
wire	[15:0]	w13	=	{OK3[11:0],		XD[3:0]					};
wire	[15:0]	w14	=	{VK1[11:0],		YD[3:0]					};
wire	[15:0]	w15	=	{VK2[11:0],		RM[3:0]					};
wire	[15:0]	w16	=	{VK3[11:0],		POS[3:0]					};
wire	[15:0]	w17	=	{UF1[11:0],		ARU[3:0]					};
wire	[15:0]	w18	=	{UF2[11:0],							4'd0	};
wire	[15:0]	w19	=	{UF3[11:0],							4'd0	};

always@(posedge clk or negedge reset) begin
	if (~reset) begin
		frmNum <= 9'd0;
		strNum <= 6'd0;
	end else begin
		if(syncFront)
			frmNum <= frmNum + 1'b1;
	end
end
endmodule
