module unit_control 
(
	input	clk, 	reset,
	input [5:0]Op,  		//opcode 
	input	[5:0]funct,		//funct
			
	output reg PCWrite,
	output reg IorD,	
	output reg MemWrite,	
	output reg IRWrite,	
	output reg RegDest,	
	output reg Mem_to_Reg,	
	output reg RegWrite,	
	output reg ALUSrcA,	
	output reg PCSrc,	
					
	output reg [1:0] ALUSrcB ,
	output reg [2:0] ALUControl
					
);
	localparam 	fetch 			= 4'b0000, 	//IF
					decode 			= 4'b0001, 	//ID
					execution		= 4'b0010,	//EX
					wb 				= 4'b0011,	//WB
					load_store		= 4'b0100;
					
	// Declare state register
		reg		[3:0]	c_state; //current state 
		reg		[3:0]	n_state; //next state
			
		// Determine the next state
	always @ (posedge clk or negedge reset ) 
	begin
		if (!reset)
			c_state <= fetch;
		else c_state <= n_state;
	end

	always @ (c_state or Op or funct) begin 
				n_state		= 4'b0000;
				PCWrite 		= 1'b0;	
				IorD 			= 1'b0;	
				MemWrite 	= 1'b0;	
				IRWrite 		= 1'b0;
				RegDest 		= 1'b0;
				Mem_to_Reg 	= 1'b0;
				RegWrite 	= 1'b0;	
				ALUSrcA 		= 1'b0;
				ALUSrcB		= 2'b00;	
				ALUControl	= 3'b000;			
				PCSrc 		= 1'b0;	

		case (c_state)
		
			fetch	:begin 		//IF
				PCWrite 		= 1'b1;	
				IorD 			= 1'b0;	
				MemWrite 	= 1'b0;	
				IRWrite 		= 1'b1;
				RegDest 		= 1'b0;
				Mem_to_Reg 	= 1'b0;
				RegWrite 	= 1'b0;	
				ALUSrcA 		= 1'b0;
				ALUSrcB		= 2'b01;	
				ALUControl	= 3'b010;			
				PCSrc 		= 1'b0;	
				n_state 		<= decode;
			end
			
			decode:begin		//ID
				PCWrite 		= 1'b0;	
				IorD 			= 1'b0;	
				MemWrite 	= 1'b0;	
				IRWrite 		= 1'b0;
				RegDest 		= 1'b0;
				Mem_to_Reg 	= 1'b1;//1'b0
				RegWrite 	= 1'b0;	
				ALUSrcA 		= 1'b1;
				ALUSrcB		= 2'b00;//10	
				ALUControl	= 3'b111;//010			
				PCSrc 		= 1'b0;
				n_state		<= execution;
			end
				
			execution:			//IE
			begin 
				if(Op == 6'h8 )// tipe I
			begin 
				PCWrite 		= 1'b0;	
				IorD 			= 1'b0;	
				MemWrite 	= 1'b0;	
				IRWrite 		= 1'b0;
				RegDest 		= 1'b0;
				Mem_to_Reg 	= 1'b0;
				RegWrite 	= 1'b0;	
				ALUSrcA 		= 1'b1;
				ALUSrcB		= 2'b10;	
				ALUControl	= 3'b010;			
				PCSrc 		= 1'b0;
				n_state		<= wb;
			end
			
				else if (Op == 6'h0 && funct == 6'h20)// tipe R
			begin
				PCWrite 		= 1'b0;	
				IorD 			= 1'b0;	
				MemWrite 	= 1'b0;	
				IRWrite 		= 1'b0;
				RegDest 		= 1'b1;//0
				Mem_to_Reg 	= 1'b0;
				RegWrite 	= 1'b0;	
				ALUSrcA 		= 1'b1;
				ALUSrcB		= 2'b00;	
				ALUControl	= 3'b010;			
				PCSrc 		= 1'b0;
				n_state		<= wb;
			end
			end
			
			wb:begin				//WB
				if(Op == 6'h8 )// tipe I
			begin 
				PCWrite 		= 1'b0;	
				IorD 			= 1'b0;	
				MemWrite 	= 1'b0;	
				IRWrite 		= 1'b0;
				RegDest 		= 1'b0;
				Mem_to_Reg 	= 1'b0;
				RegWrite 	= 1'b1;	
				ALUSrcA 		= 1'b1;
				ALUSrcB		= 2'b10;	
				ALUControl	= 3'b010;			
				PCSrc 		= 1'b1;//0
				n_state		<= fetch;
			end
			
				else if (Op == 6'h0 && funct == 6'h20)// tipe R
			begin
				PCWrite 		= 1'b0;	
				IorD 			= 1'b0;	
				MemWrite 	= 1'b0;	
				IRWrite 		= 1'b0;
				RegDest 		= 1'b1;
				Mem_to_Reg 	= 1'b0;
				RegWrite 	= 1'b1;	
				ALUSrcA 		= 1'b1;
				ALUSrcB		= 2'b00;	
				ALUControl	= 3'b010;			
				PCSrc 		= 1'b1;//0
				n_state		<= fetch;
			end
			end
			default n_state = fetch;
		endcase
	end



endmodule
