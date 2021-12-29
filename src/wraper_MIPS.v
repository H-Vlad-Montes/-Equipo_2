module wraper_MIPS 
(
	input MAX10_CLK1_50,
	//////lED///////
	output[7:0] LEDR,
	//////SW ///////
	input [9:0] SW
);
wire clk;
wire clk_hz;

Clock_Gen	Clock_Gen_inst (			//PLL
	.inclk0 ( MAX10_CLK1_50 ),
	.c0 ( clk )
	);
	
cont_1s_RCO
	(
	.mclk(clk), 
	.reset(SW[9]),
	.RCO(clk_hz)  								// Ripple Carry Output
  	);

data_path 
(
	.clk(clk_hz), 
	.reset(SW[9]),
	.GPIO_i(SW[7:0]),
	.GPIO_o(LEDR[7:0])
); 

endmodule
