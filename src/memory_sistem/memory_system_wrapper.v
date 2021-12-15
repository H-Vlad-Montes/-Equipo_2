module memory_system_wrapper
#(
	parameter MEMORY_DEPTH = 32,
	parameter DATA_WIDTH = 32
	)
	(
	input while_enable_i,
	input [(DATA_WIDTH-1):0] write_data,//escritura
	input [(DATA_WIDTH-1):0] address_i,	//localizacion
	input clk,
	output [(DATA_WIDTH-1):0] ReadData
	
	);
	memory_system conexion( 
	.while_enable_i(while_enable_i),
	.write_data(write_data), 
	.address_i(address_i), 
	.clk(clk),
	.instruction_o(ReadData)
	);
	
	endmodule
	