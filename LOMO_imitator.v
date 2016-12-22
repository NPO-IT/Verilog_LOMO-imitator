module LOMO_imitator (
	input clk,			//80 mhz
	output oMK,			//yellow wire, 128
	output oCLK,		//brown wire, 127
	output oSRL			//red wire, 126
);
wire rst, clk2;

globalReset aCLR ( .clk(clk), .rst(rst) );
	defparam aCLR.clockFreq = 1;
	defparam aCLR.delayInSec = 20;
clkDividers clkDiv ( .reset(rst), .clk80(clk),.clk2(clk2) );

assign oMK = clk2;
assign oCLK = ~clk2;
assign oSRL = ~clk;

endmodule
