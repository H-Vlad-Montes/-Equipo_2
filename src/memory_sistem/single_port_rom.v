module single_port_rom #(
	parameter DATA_WIDTH = 32,
	parameter ADDR_WIDTH = 64
)
(
	input [(DATA_WIDTH-1):0] addr,
	output reg [(DATA_WIDTH-1):0] q
);
	reg [DATA_WIDTH-1:0] rom [ADDR_WIDTH-1:0];
	reg [(DATA_WIDTH-1):0]x = 32'h400000;
		//initialize the rom with $readmemh
	
	initial 
	begin 
		$readmemh("C:/Users/endgels/Documents/GitHub/Equipo_2/assembly_code/T8.dat",rom);
	end
	
	always @ (addr,x)
	begin
		q = rom[(addr-x)>>2];
	end
endmodule 