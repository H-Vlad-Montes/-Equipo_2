module unit_control 
(
	input	clk, 	reset,
	input [5:0]Op,
	input [5:0]funct,		
	output reg IorD,	
	output reg MemWrite,	
	output reg IRWrite,		
	output reg Mem_to_Reg,	
	output reg RegWrite,	
	output reg ALUSrcA,	
	output reg PCSrc,
	output reg jump_select,
	output reg PCWrite,
	output reg branch,	
	output reg [1:0] ALUSrcB, select_ori, RegDest,
	output reg [2:0] ALUControl,
	output reg GPIO_o
					
);
	localparam 	fetch 			= 4'b0000, 	
					decode 			= 4'b0001, 	
					execution		= 4'b0010,	
					MemAdr			= 4'b0011,
					wb 				= 4'b0100,	
					beq     			= 4'b0101,  
					jump				= 4'b0110,	
					jal				= 4'b0111,	
					sw					= 4'b1000,
					lw					= 4'b1001;
					
		reg		[3:0]	c_state; //current state 
		reg		[3:0]	n_state; //next state

	always @ (c_state or Op or funct) begin 
				n_state		= 4'b0000;
				PCWrite 		= 1'b0;	
				IorD 			= 1'b0;	
				MemWrite 	= 1'b0;	
				IRWrite 		= 1'b0;
				RegDest 		= 2'b00;
				Mem_to_Reg 	= 1'b0;
				RegWrite 	= 1'b0;	
				ALUSrcA 		= 1'b0;
				ALUSrcB		= 2'b00;	
				ALUControl	= 3'b000;			
				PCSrc 		= 1'b0;
				select_ori	= 2'b00;
				jump_select = 1'b0;
				branch		= 1'b0;
				GPIO_o		= 1'b0;
				
		case (c_state)
		
	fetch	:begin 
				PCWrite 		= 1'b1;	
				IorD 			= 1'b0;
				MemWrite 	= 1'b0;	
				IRWrite 		= 1'b1;
				RegDest 		= 2'b00;
				Mem_to_Reg 	= 1'b0;
				RegWrite 	= 1'b0;	
				ALUSrcA 		= 1'b0;
				ALUSrcB		= 2'b01;	
				ALUControl	= 3'b001;			
				PCSrc 		= 1'b0;
				select_ori	= 2'b00;
				branch		= 1'b0;
				jump_select = 1'b1;
				GPIO_o		= 1'b0;
				n_state 	<= decode;
			end
			
	decode:
			begin				
				PCWrite 		= 1'b0;	
				IorD 			= 1'b0;	
				MemWrite 	= 1'b0;	
				IRWrite 		= 1'b0;
				RegDest 		= 2'b00;
				Mem_to_Reg 	= 1'b0;
				RegWrite 	= 1'b0;	
				ALUSrcA 		= 1'b0;
				ALUSrcB		= 2'b11;
				ALUControl	= 3'b001;
				PCSrc 		= 1'b0;
            select_ori	= 2'b00;
				branch		= 1'b0;
				jump_select = 1'b1;
				GPIO_o		= 1'b0;
				if(Op == 6'h4 )begin
					n_state		<= beq;
				end
				else if(Op == 6'h2 )begin
					n_state		<= jump;
				end
				else if(Op == 6'h3 )begin
					n_state		<= execution;
				end
				else if(Op == 6'h23 || Op == 6'h2b)begin
				n_state <= MemAdr;
				end
            else begin 
               n_state     <= execution;
            end

			end
    beq:begin
				PCWrite 		= 1'b0;
				IorD 			= 1'b0;
				MemWrite 	= 1'b0;
				IRWrite 		= 1'b0;
				RegDest 		= 2'b00;
				Mem_to_Reg 	= 1'b0;
				RegWrite 	= 1'b0;	
				ALUSrcA 		= 1'b1;
				ALUSrcB		= 2'b00;	
				ALUControl	= 3'b100;
				PCSrc 		= 1'b1;
				select_ori	= 2'b00;
				branch		= 1'b1;
				jump_select = 1'b1;
				GPIO_o		= 1'b0;		
				n_state		<= fetch;
			end	
			
    jump:begin
				PCWrite 		= 1'b1;
				IorD 			= 1'b0;	
				MemWrite 	= 1'b0;	
				IRWrite 		= 1'b0;
				RegDest 		= 2'b00;
				Mem_to_Reg 	= 1'b0;
				RegWrite 	= 1'b0;	
				ALUSrcA 		= 1'b0;
				ALUSrcB		= 2'b11;	
				ALUControl	= 3'b000;			
				PCSrc 		= 1'b1;
				select_ori	= 2'b00;
				branch		= 1'b0;
				jump_select = 1'b0;
				GPIO_o		= 1'b0;
				
				if (Op == 6'h3) begin
				n_state		<= fetch;
				end
				else begin
				n_state		<= fetch;
				end
			end
			
	jal:begin
				PCWrite 		= 1'b0;
				IorD 			= 1'b0;	
				MemWrite 	= 1'b0;	
				IRWrite 		= 1'b0;
				RegDest 		= 2'b10;
				Mem_to_Reg 	= 1'b0;
				RegWrite 	= 1'b1;	
				ALUSrcA 		= 1'b0;
				ALUSrcB		= 2'b01;	
				ALUControl	= 3'b111;			
				PCSrc 		= 1'b0;
				select_ori	= 2'b00;
				branch		= 1'b0;
				jump_select = 1'b1;
				GPIO_o		= 1'b0;
				n_state		<= jump;
			end
			
	execution:
			begin 
            PCWrite 		= 1'b0;	
				IorD 			= 1'b0;	
				MemWrite 	= 1'b0;	
				IRWrite 		= 1'b0;
				RegWrite 	= 1'b0;	
            branch		= 1'b0;
				jump_select = 1'b1;
            PCSrc 		= 1'b0;
				GPIO_o		= 1'b0;
            n_state     <= wb;
			if (Op == 6'h0 && funct == 6'h20)// add 
			begin
				Mem_to_Reg 	= 1'b0;
				RegDest 		= 2'b01;
				ALUSrcA 		= 1'b1;
				ALUSrcB		= 2'b00;	
				ALUControl	= 3'b001;			
				select_ori	= 2'b00;
				n_state		<= wb;
			end
			else if(Op == 6'h8) // addi 
			begin 
				RegDest 		= 2'b00;
				Mem_to_Reg 	= 1'b0;
				ALUSrcA 		= 1'b1;
				ALUSrcB		= 2'b10;
				ALUControl	= 3'b001;			
				select_ori	= 2'b00;
				n_state		<= wb;
			end
			else if(Op == 6'h9 )	///addiu
			begin
				RegDest 		= 2'b00;
				Mem_to_Reg 	= 1'b0;
				ALUSrcA 		= 1'b1;
				ALUSrcB		= 2'b10;	
				ALUControl	= 3'b001;		
				select_ori	= 2'b11;
				n_state		<= wb;
			end
			else if(Op == 6'hd) // ori
			begin 
				RegDest 		= 2'b00;
				Mem_to_Reg 	= 1'b0;
				ALUSrcA 		= 1'b1;
				ALUSrcB		= 2'b10;
				ALUControl	= 3'b011;			
				select_ori	= 2'b01;
				n_state		<= wb;
			end	
			else if (Op == 6'hf) //LUI
			begin
				RegDest 		= 2'b00;
				Mem_to_Reg 	= 1'b0;
				ALUSrcA 		= 1'b1;
				ALUSrcB		= 2'b10;	
				ALUControl	= 3'b001;		
				select_ori	= 2'b10;
				n_state		<= wb;
			end
			else if (Op == 6'hc) //ANDI
			begin
				RegDest 		= 2'b00;
				Mem_to_Reg 	= 1'b0;
				ALUSrcA 		= 1'b1;
				ALUSrcB		= 2'b10;
				ALUControl	= 3'b010;
				select_ori	= 2'b01;
				n_state		<= wb;
			end
			else if (Op == 6'ha) //STLI
			begin
				RegDest 		= 2'b00;
				Mem_to_Reg 	= 1'b0;
				ALUSrcA 		= 1'b1;
				ALUSrcB		= 2'b10;	
				ALUControl	= 3'b101;		
				select_ori	= 2'b00;
				n_state		<= wb;
			end
			else if (Op == 6'h3) //JAL
			begin
				RegDest 		= 2'b00;
				Mem_to_Reg 	= 1'b0;
				ALUSrcA 		= 1'b0;
				ALUSrcB		= 2'b10;	
				ALUControl	= 3'b111;		
				select_ori	= 2'b00;
				n_state		<= jal;
			end
			else if (Op == 6'h0 && funct == 6'h8)// JR
			begin
				Mem_to_Reg 	= 1'b0;
				RegDest 		= 2'b00;
				ALUSrcA 		= 1'b1;
				ALUSrcB		= 2'b00;	
				ALUControl	= 3'b111;			
				select_ori	= 2'b01;
				n_state		<= wb;
			end
			
			else if (Op == 6'h1c) //MUL
			begin
				RegDest 		= 2'b01;
				Mem_to_Reg 	= 1'b0;
				ALUSrcA 		= 1'b1;
				ALUSrcB		= 2'b00;	
				ALUControl	= 3'b110;		
				select_ori	= 2'b01;
				n_state		<= wb;
			end	
		end
			
		MemAdr:begin
				PCWrite 		= 1'b0;	
				IorD 			= 1'b1;	
				MemWrite 	= 1'b0;	
				IRWrite 		= 1'b0;
				RegDest 		= 2'b00;
				Mem_to_Reg 	= 1'b0;
				RegWrite 	= 1'b0;
				ALUSrcA 		= 1'b1;
				ALUSrcB		= 2'b10;
				ALUControl	= 3'b001;			
				PCSrc 		= 1'b0;
				select_ori	= 2'b00;	
				jump_select = 1'b0;	
				branch		= 1'b0;
				GPIO_o		= 1'b0;
				
				if(Op == 6'h2b)begin//sw
				n_state <= sw;
				end
				
				else if(Op == 6'h23)begin//lw
				n_state <= lw;
				end
		end
	sw:begin
				PCWrite 		= 1'b0;	
				IorD 			= 1'b1;	
				MemWrite 	= 1'b1;	
				IRWrite 		= 1'b0;
				RegDest 		= 2'b00;
				Mem_to_Reg 	= 1'b1;
				RegWrite 	= 1'b0;	
				ALUSrcA 		= 1'b1;
				ALUSrcB		= 2'b10;	
				ALUControl	= 3'b001;			
				PCSrc 		= 1'b0;
				select_ori	= 2'b00;	
				jump_select = 1'b1;	
				branch		= 1'b0;
				GPIO_o		= 1'b0;
				n_state		<= fetch;
		end
	lw:begin
				PCWrite 		= 1'b0;	
				IorD 			= 1'b1;	
				MemWrite 	= 1'b0;	
				IRWrite 		= 1'b0;
				RegDest 		= 2'b00;
				Mem_to_Reg 	= 1'b1;
				RegWrite 	= 1'b0;	
				ALUSrcA 		= 1'b1;
				ALUSrcB		= 2'b10;	
				ALUControl	= 3'b001;			
				PCSrc 		= 1'b0;
				select_ori	= 2'b00;	
				jump_select = 1'b1;	
				branch		= 1'b0;
				GPIO_o		= 1'b0;
				n_state		<= wb;
	end
	wb:begin	
				PCWrite 		= 1'b0;	
				IorD 			= 1'b0;	
				MemWrite 	= 1'b0;	
        		IRWrite 		= 1'b0;
				PCSrc 		= 1'b0;
            jump_select = 1'b1;
				branch		= 1'b0;
  				Mem_to_Reg 	= 1'b0;
				RegWrite 	= 1'b1;
				GPIO_o		= 1'b0;
				
			if(Op == 6'h0 && funct == 6'h20 ) // add
			begin 
				RegDest 		= 2'b01;
				ALUSrcA 		= 1'b1;
				ALUSrcB		= 2'b00;
				ALUControl	= 3'b001;			
				select_ori	= 2'b00;
				n_state		<= fetch;
			end
			else if(Op == 6'h9 )///addiu
			begin
				RegDest 		= 2'b00;
				ALUSrcA 		= 1'b1;
				ALUSrcB		= 2'b10;
				ALUControl	= 3'b001;		
				select_ori	= 2'b11;
				n_state		<= fetch;
			end
			else if(Op == 6'hd) // ori
			begin 
				RegDest 		= 2'b00;
				ALUSrcA 		= 1'b1;
				ALUSrcB		= 2'b10;
				ALUControl	= 3'b011;			
				select_ori	= 2'b01;
				n_state		<= fetch;
			end
			else if (Op == 6'hf) //LUI
			begin
				RegDest 		= 2'b00;
				ALUSrcA 		= 1'b1;
				ALUSrcB		= 2'b10;	
				ALUControl	= 3'b001;		
				select_ori	= 2'b10;
				n_state		<= fetch;
			end
			else if (Op == 6'hc) //ANDI
			begin
				RegDest 		= 2'b00;
				ALUSrcA 		= 1'b1;
				ALUSrcB		= 2'b10;	
				ALUControl	= 3'b010;		
				select_ori	= 2'b01;
				n_state		<= fetch;
			end
			else if (Op == 6'h0 && funct == 6'h8) // JR
			begin
				RegDest 		= 2'b00;
				ALUSrcA 		= 1'b1;
				ALUSrcB		= 2'b00;	
				ALUControl	= 3'b111;			
				select_ori	= 2'b01;
				PCWrite 		= 1'b1;
				PCSrc 		= 1'b1;
            jump_select = 1'b1;
  				Mem_to_Reg 	= 1'b0;
				RegWrite 	= 1'b0;
				n_state		<= fetch;
			end
			else if (Op == 6'h3) //JAL
			begin
				RegDest 		= 2'b10;
				ALUSrcA 		= 1'b0;
				ALUSrcB		= 2'b11;	
				ALUControl	= 3'b111;		
				select_ori	= 2'b00;
				n_state		<= fetch;
			end
			else if (Op == 6'ha) //STLI
			begin
				RegDest 		= 2'b00;
				Mem_to_Reg 	= 1'b0;
				ALUSrcA 		= 1'b1;
				ALUSrcB		= 2'b10;	
				ALUControl	= 3'b101;		
				select_ori	= 2'b00;
				n_state		<= fetch;
			end
			else if(Op == 6'h23 )///LW
			begin
				RegDest 		= 2'b00;
				ALUSrcA 		= 1'b1;
				Mem_to_Reg 	= 1'b1;
				ALUSrcB		= 2'b10;
				ALUControl	= 3'b001;		
				select_ori	= 2'b00;
				n_state		<= fetch;
			end
			else if (Op == 6'h1c) //MUL
			begin
				RegDest 		= 2'b01;
				ALUSrcA 		= 1'b1;
				ALUSrcB		= 2'b00;	
				ALUControl	= 3'b110;		
  				Mem_to_Reg 	= 1'b0;
				select_ori	= 2'b01;
				GPIO_o		= 1'b1;
				n_state		<= fetch;
			end
				
		end
			
			
			default n_state = 4'b0000;
		endcase
	end
	always @ (posedge clk or negedge reset ) 
	begin
		if (!reset)
			c_state <= fetch;
		else c_state <= n_state;
	end


endmodule