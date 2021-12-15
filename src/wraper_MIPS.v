module wraper_MIPS 
(
	input MAX10_CLK1_50,
	//////lED///////
	output[7:0] LEDR,
	
	//////SW ///////
	input [9:9] SW
);
wire c0_sig;
wire RCO;

Clock_Gen	Clock_Gen_inst (
	.inclk0 ( MAX10_CLK1_50 ),
	.c0 ( c0_sig )
	);
	
cont_1s_RCO
	(
	.mclk(c0_sig), 
	.reset(SW),
	.RCO(RCO)  // Ripple Carry Output
  	);

data_path 
(
.clk(RCO), 
.reset(SW),
.zero(),
.GPIO(LEDR)
); 

endmodule
