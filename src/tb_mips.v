module tb_mips;
	reg clk_tb = 0;
	reg reset_tb = 0;
	reg [7:0]GPIO_i_tb;
	wire [7:0]GPIO_o_tb;
data_path #(
	.WIDTH (32)
)DUT(
	.clk(clk_tb), 
	.reset(reset_tb),		
	.GPIO_i(GPIO_i_tb),
	.GPIO_o(GPIO_o_tb)
);
initial begin 
	forever #1 clk_tb = !clk_tb;
end
initial begin 
	#0 reset_tb = 0;
	#2 reset_tb = 1;
	GPIO_i_tb = 8'b00000010;
end 
endmodule
