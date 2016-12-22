module clkDividers(
	input	reset,				// aclr
	input	clk80,				// 80.640.000		---
	output	reg	clk2		// 2.000.000		50%
);

reg	[5:0]	cnt2;			// 40

always@(posedge clk80 or negedge reset) begin
	if(~reset)begin
		clk2	<=	1'b0;
		cnt2	<=	6'b0; 
	end else begin
		// 1MHz clock
		cnt2 <= cnt2 + 1'b1;
		if (cnt2 > 20) begin
			clk2 <= 1'b1; 
		end 
		if (cnt2 == 39) begin
			cnt2 <= 6'b0; 
			clk2 <= 1'b0;
		end
		
	end
end
endmodule
