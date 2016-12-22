module LOMO_imitator (
	input clk,			//80 mhz
	output oMK,			//yellow wire, 128
	output oCLK,		//brown wire, 127
	output oSRL			//red wire, 126
);

assign oMK = clk;
assign oCLK = clk;
assign oSRL = clk;

endmodule
