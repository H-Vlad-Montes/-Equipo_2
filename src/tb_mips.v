module tb_mips;
	reg clk_tb = 0;
	reg reset_tb ;
	wire zero_tb;
	wire [7:0]GPIO_tb;
data_path #(
	.WIDTH (32)
)DUT(
	.clk(clk_tb), 
	.reset(reset_tb),		
	.zero(zero_tb),
	.GPIO(GPIO_tb)
);
initial begin 
	forever #1 clk_tb = !clk_tb;
end
initial begin 
	#0 reset_tb = 0;
	#2 reset_tb = 1;
end 
endmodule
