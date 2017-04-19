module LOMO_imitator (
	input clk,			//80 mhz
	output oMK,			//Frame Marker,		pin_128
	output oCLK,		//Clock Signal,		pin_127
	output oSRL			//Serial Data,		pin_126
);
wire rst; 
wire clk2;		// 2MHz Clock

globalReset aCLR ( .clk(clk), .rst(rst) );
	defparam aCLR.clockFreq = 1;
	defparam aCLR.delayInSec = 20;
clkDividers clkDiv ( .reset(rst), .clk80(clk),.clk2(clk2) );	//80MHz to 2MHz clock

TheFrame former(
	.clk(clk),
	.sync(clk2),
	.reset(rst),
	.MK(oMK),
	.CLK(oCLK),
	.DAT(oSRL)
);

endmodule
