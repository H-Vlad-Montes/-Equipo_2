module ff #(
parameter WHIDT = 32
)
(
		input		[WHIDT-1 : 0] d, 
		input 	clk, 
		input		reset, 
		input		enable,
		output 	[WHIDT-1 : 0] q
);
		reg 		[WHIDT-1 : 0] q6;
		
   always @(posedge clk or negedge reset) begin
      if (!reset)
         q6 <= 0;
      else if(enable)
         q6 <= d;
   end
  assign q = q6;
endmodule
