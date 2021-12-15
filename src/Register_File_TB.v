module Register_File_TB;

reg clk_tb = 0;
reg reset_tb;
reg Reg_Write_i_tb;
reg [4:0] Write_Register_i_tb;
reg [4:0] Read_Register_1_i_tb;
reg [4:0] Read_Register_2_i_tb;
reg [31:0] Write_Data_i_tb;
wire [31:0] Read_Data_1_tb;
wire [31:0] Read_Data_2_tb;
  
  
wrapper_register_file
#(
	.WIDTH(32),
	.SIZE(5)
)UT
(
	.clk(clk_tb),
	.reset(reset_tb),
	.reg_write_WE3_i(Reg_Write_i_tb),
	.write_register_A3_i(Write_Register_i_tb),
	.read_register_A1_i(Read_Register_1_i_tb),
	.read_register_A2_i(Read_Register_2_i_tb),
	.write_data_WD3_i(Write_Data_i_tb),
	.read_data_RD1_o(Read_Data_1_tb),
	.read_data_RD2_o(Read_Data_2_tb)

);
/*********************************************************/
initial // Clock generator
  begin
    forever #2 clk_tb = !clk_tb;
  end
/*********************************************************/
initial begin // reset generator
	#0 reset_tb = 0;
	#5 reset_tb = 1;
end

initial begin
	#0 Reg_Write_i_tb = 0;
	#5 Reg_Write_i_tb = 1;
	#50 Reg_Write_i_tb = 0;
	#1 Reg_Write_i_tb = 1;
end


initial begin
	#0 Read_Register_1_i_tb = 0;
	#4 Read_Register_1_i_tb = 0;
	#70 Read_Register_1_i_tb = 2;
	#10 Read_Register_1_i_tb = 4;
	#10 Read_Register_1_i_tb = 25;
	#10 Read_Register_1_i_tb = 31;

end


initial begin
	#0 Read_Register_2_i_tb = 0;
	#4 Read_Register_2_i_tb = 0;
	#70 Read_Register_2_i_tb = 1;
	#10 Read_Register_2_i_tb = 2;
	#10 Read_Register_2_i_tb = 20;
	#10 Read_Register_2_i_tb = 19;

end

initial begin // ~~~~~~~~rd initial
	#0 Write_Register_i_tb = 0;
	#4 Write_Register_i_tb = 0;
	#70 Write_Register_i_tb = 2;
	#10 Write_Register_i_tb = 4;
	#10 Write_Register_i_tb = 31;
	#10 Write_Register_i_tb = 19;

end


/*********************************************************/
initial begin // reset generator
	#0 Write_Data_i_tb = 3;
	#4 Write_Data_i_tb = 3;
	#70 Write_Data_i_tb = 7;
	#10 Write_Data_i_tb = 20;
	#10 Write_Data_i_tb = 6;
	#10 Write_Data_i_tb = 78;
end


/*********************************************************/

endmodule