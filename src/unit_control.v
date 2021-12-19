module unit_control 
(
	input	clk, 	reset,
	input [5:0]Op,  		//opcode 
	input [5:0]funct,		//funct
	output reg IorD,	
	output reg MemWrite,	
	output reg IRWrite,	
	output reg RegDest,	
	output reg Mem_to_Reg,	
	output reg RegWrite,	
	output reg ALUSrcA,	
	output reg PCSrc,
	output reg select_ori,
	output reg jump_select,
	output reg PCWrite,
	output reg branch,	
	output reg [1:0] ALUSrcB ,
	output reg [2:0] ALUControl
					
);
	localparam 	fetch 			= 4'b0000, 	//IF
					decode 			= 4'b0001, 	//ID
					execution		= 4'b0010,	//EX
					wb 				= 4'b0011,	//WB
					beq     			= 4'b0100,  //BEQ
					jump				= 4'b0101;	//J
					
		reg		[3:0]	c_state; //current state 
		reg		[3:0]	n_state; //next state

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
				select_ori	= 1'b0;
				jump_select = 1'b0;
				branch		= 1'b0;
				
		case (c_state)
		
	fetch	:begin 
				PCWrite 		= 1'b1;	
				IorD 			= 1'b0;
				MemWrite 	= 1'b0;	
				IRWrite 		= 1'b1;
				RegDest 		= 1'b0;
				Mem_to_Reg 	= 1'b0;
				RegWrite 	= 1'b0;	
				ALUSrcA 		= 1'b0;
				ALUSrcB		= 2'b01;	
				ALUControl	= 3'b001;			
				PCSrc 		= 1'b0;
				
				select_ori	= 1'b0;
				branch		= 1'b0;
				jump_select = 1'b1;
				n_state 	<= decode;
			end
			
	decode:
			begin				
				PCWrite 		= 1'b0;	
				IorD 			= 1'b0;	
				MemWrite 	= 1'b0;	
				IRWrite 		= 1'b0;
				RegDest 		= 1'b0;
				Mem_to_Reg 	= 1'b0;
				RegWrite 	= 1'b0;	
				ALUSrcA 		= 1'b0;
				ALUSrcB		= 2'b11;
				ALUControl	= 3'b001;
				PCSrc 		= 1'b0;
            select_ori	= 1'b0;//zero_ext
				branch		= 1'b0;
				jump_select = 1'b1;//PC_J
				if(Op == 6'h4 )begin
					n_state		<= beq;
				end
				else if(Op == 6'h2 )begin
					n_state		<= jump;
				end
            else begin 
               n_state     <= execution;
            end

			end
    jump:begin//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~JUMP
				PCWrite 		= 1'b1;
				IorD 			= 1'b0;	
				MemWrite 	= 1'b0;	
				IRWrite 		= 1'b0;
				RegDest 		= 1'b0;
				Mem_to_Reg 	= 1'b0;
				RegWrite 	= 1'b0;	
				ALUSrcA 		= 1'b0;
				ALUSrcB		= 2'b11;	
				ALUControl	= 3'b000;			
				PCSrc 		= 1'b1;
				select_ori	= 1'b0;
				branch		= 1'b1;
				jump_select = 1'b0;
				n_state		<= fetch;
			end

    beq:begin
				PCWrite 		= 1'b0;
				IorD 			= 1'b0;
				MemWrite 	= 1'b0;
				IRWrite 		= 1'b0;
				RegDest 		= 1'b0;
				Mem_to_Reg 	= 1'b0;
				RegWrite 	= 1'b0;	
				ALUSrcA 		= 1'b1;
				ALUSrcB		= 2'b00;	
				ALUControl	= 3'b000;
				PCSrc 		= 1'b1;
				select_ori	= 1'b0;
				branch		= 1'b1;
				jump_select = 1'b1;			
				n_state		<= fetch;
			end	
	execution:
			begin 
            PCWrite 		= 1'b0;	
				IorD 			= 1'b0;	
				MemWrite 	= 1'b0;	
				IRWrite 		= 1'b0;
				RegWrite 	= 1'b0;	
            branch		= 1'b0;
				jump_select = 1'b1;//PC_J
            PCSrc 		= 1'b0;
                //n_state     <= wb;

				 if(Op == 6'h8 )// addi
			begin 
				RegDest 		= 1'b0;
				Mem_to_Reg 	= 1'b0;
				ALUSrcA 		= 1'b1;
				ALUSrcB		= 2'b10;	
				ALUControl	= 3'b001;			
				select_ori	= 1'b0;//zero_ext
				n_state		<= wb;
			end

				else if(Op == 6'hd )	///ori~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			begin
				RegDest 		= 1'b0;
				Mem_to_Reg 	= 1'b0;
				ALUSrcA 		= 1'b1;
				ALUSrcB		= 2'b10;	
				ALUControl	= 3'b011;		
				select_ori	= 1'b1;
				n_state		<= wb;
			end
			
				else if (Op == 6'h0 && funct == 6'h20)// add
			begin
				Mem_to_Reg 	= 1'b0;
				RegDest 		= 1'b1;
				ALUSrcA 		= 1'b1;
				ALUSrcB		= 2'b00;	
				ALUControl	= 3'b001;			
				select_ori	= 1'b0;
				n_state		<= wb;
			end
			end
			
	wb:begin	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~WB
				PCWrite 		= 1'b0;	
				IorD 			= 1'b0;	
				MemWrite 	= 1'b0;	
        		IRWrite 		= 1'b0;
				PCSrc 		= 1'b0;
            jump_select = 1'b1;
				branch		= 1'b0;
  				Mem_to_Reg 	= 1'b0;
				RegWrite 	= 1'b1;	

                if(Op == 6'h8 )// addi
			begin 
				RegDest 		= 1'b0;
				ALUSrcA 		= 1'b1;
				ALUSrcB		= 2'b10;
				ALUControl	= 3'b001;			
				select_ori	= 1'b0;
				n_state		<= fetch;
			end
			
				else if(Op == 6'hd )///ori
			begin
				RegDest 		= 1'b0;
				ALUSrcA 		= 1'b1;
				ALUSrcB		= 2'b10;
				ALUControl	= 3'b011;		
				select_ori	= 1'b1;
				n_state		<= fetch;
			end
			
				else if (Op == 6'h0 && funct == 6'h20)// add
			begin
				RegDest 		= 1'b1;
				ALUSrcA 		= 1'b1;
				ALUSrcB		= 2'b00;	
				ALUControl	= 3'b001;			
				select_ori	= 1'b0;
				n_state		<= fetch;
			end
			end
			
			
			default n_state = 3'b000;
		endcase
	end
	always @ (posedge clk or negedge reset ) 
	begin
		if (!reset)
			c_state <= fetch;
		else c_state <= n_state;
	end


endmodule