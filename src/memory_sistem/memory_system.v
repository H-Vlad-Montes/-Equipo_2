module memory_system
#(
	parameter DATA_WIDTH = 32
	)
	(
	input while_enable_i,clk,
	input [(DATA_WIDTH-1):0] write_data,//escritura
	input [(DATA_WIDTH-1):0] address_i,	//localizacion
	output [(DATA_WIDTH-1):0] instruction_o
	
	);
	wire [DATA_WIDTH-1:0] rom_o;	//salida de rom
	wire [DATA_WIDTH-1:0] ram_o;	//salida de ram
	
	wire addrs;
	reg [(DATA_WIDTH-1):0] x = 32'h10000000 ;
	
	assign addrs = (address_i < x) ? 1 : 0;
	
	single_port_rom romx (	
	.addr(address_i),
	.q(rom_o)
	);
	
	single_port_ram ramx(
	.write_enable(while_enable_i),
	.clk(clk),
	.WriteData(write_data),
	.address(address_i),
	.ReadData(ram_o)
	);
	
	mux2to1 mux(
	.x(rom_o), 
	.y(ram_o), 
	.Sel(addrs), 
	.Data_out(instruction_o));

endmodule
