module TB_data_path ;
	parameter WIDTH = 32;

	reg clk_tb = 0; 
	reg reset_tb;
		//inputs to control unit
	reg ALUSrcA_tb;
	reg [2:0]ALUControl_tb;
	reg [1:0]ALUSrcB_tb;
	reg PC_enable_tb;  //PCEn
	reg IorD_tb;		//instruccion tipe I or D
	reg MemWrite_tb;
	reg IRWrite_tb;
	reg RegDst_tb;
	reg MemtoReg_tb;
	reg RegWrite_tb;
	reg PCSrc_tb;
	
	wire zero_tb;
	
	wire [5:0] op_tb;  //opcode
	wire [5:0] Funct_tb;	//funct
	wire [7:0] GPIO_tb;
	
	// output displays
	
	wire [WIDTH-1:0] ffwd_disp_tb;
	wire [WIDTH-1:0] ffrd_disp_tb;
	wire [WIDTH-1:0] RD1_disp_tb;
	wire [WIDTH-1:0] RD2_disp_tb;
	wire [WIDTH-1:0] SrcB_disp_tb;


data_path #(
	 .WIDTH (32)
)
DUV
(
	.clk(clk_tb), 
	.reset(reset_tb),
		//inputs to control unit
	.ALUSrcA(ALUSrcA_tb),
	.ALUControl(ALUControl_tb),
	.ALUSrcB(ALUSrcB_tb),
	.PC_enable(PC_enable_tb),  //PCEn
	.IorD(IorD_tb),			//instruccion tipe I or D
	.MemWrite(MemWrite_tb),
	.IRWrite(IRWrite_tb),
	.RegDst(RegDst_tb),
	.MemtoReg(MemtoReg_tb),
	.RegWrite(RegWrite_tb),
	.PCSrc(PCSrc_tb),
	
	.op(op_tb), 		 //opcode
	.Funct(Funct_tb),	 //funct
	.GPIO(GPIO_tb),
	
	// output displays
	.zero(zero_tb),
	.ffwd_disp(ffwd_disp_tb),
	.ffrd_disp(ffrd_disp_tb),
	.RD1_disp(RD1_disp_tb),
	.RD2_disp(RD2_disp_tb),
	.SrcB_disp(SrcB_disp_tb)
);
/*********************************************************/
initial // Clock generator
  begin
    forever #2 clk_tb = !clk_tb;
  end
/*********************************************************/
initial begin // reset 
		#0 reset_tb = 1;
		#1 reset_tb = 0;
		#1 reset_tb = 1;
end

initial begin 
	 #1 PC_enable_tb = 1;
	    IorD_tb = 1; 	//MUX
	    MemWrite_tb = 0;
	    RegWrite_tb = 0;
	    IRWrite_tb = 1;
	 #4  PC_enable_tb = 0;
end
initial begin 
	 #11 IRWrite_tb = 0; 
	 #7 ALUSrcA_tb = 0;	//MUX
	    ALUSrcB_tb = 2'b01;	//MUX 4to1
	 #5 ALUControl_tb = 3'b000;
	 #2 RegWrite_tb = 1;
	    MemtoReg_tb = 1;    //MUx
	    RegDst_tb = 1;        //MUX

	 #6 RegWrite_tb = 0;        //MUX
	 #4 ALUSrcA_tb = 1;
	    ALUSrcB_tb = 2'b10;
	    ALUControl_tb = 3'b000;
	    PCSrc_tb = 0;	//MUX
	    MemtoReg_tb = 1'bx;
	    RegDst_tb = 1'bx;
end 
initial begin
	#36 PC_enable_tb = 1;
	   IorD_tb = 1; 	//MUX
	   MemWrite_tb = 0;
	   RegWrite_tb = 0;
	   IRWrite_tb = 1;
	#4 PC_enable_tb = 0;

	#6 PC_enable_tb = 0;
	#7  ALUSrcA_tb = 0;	//MUX
	    ALUSrcB_tb = 2'b01;	//MUX 4to1
	#5  ALUControl_tb = 3'b000;
	#2  RegWrite_tb = 1;	//MUX
	    MemtoReg_tb = 1;	//MUX
	    RegDst_tb = 1;		//MUX

	#4  RegWrite_tb = 0;
	#4  ALUSrcA_tb = 1;
	    ALUSrcB_tb = 2'b10;
	    ALUControl_tb = 3'b000;
	    PCSrc_tb = 1;	//MUX
	    MemtoReg_tb = 1'bx;
	    RegDst_tb = 1'bx;
end
initial begin
	#69 PC_enable_tb = 1;
	   IorD_tb = 1; 	//MUX
	   MemWrite_tb = 0;
	   RegWrite_tb = 0;
	   IRWrite_tb = 1;
	#4 PC_enable_tb = 0;

	#6 PC_enable_tb = 0;
	#7  ALUSrcA_tb = 0;	//MUX
	    ALUSrcB_tb = 2'b01;	//MUX 4to1
	#5  ALUControl_tb = 3'b000;
	#2  RegWrite_tb = 1;	//MUX
	    MemtoReg_tb = 1;	//MUX
	    RegDst_tb = 1;		//MUX

	#2  RegWrite_tb = 0;
	#4  ALUSrcA_tb = 1;
	    ALUSrcB_tb = 2'b10;
	    ALUControl_tb = 3'b000;
	    PCSrc_tb = 1;	//MUX
	    MemtoReg_tb = 1'bx;
	    RegDst_tb = 1'bx;
end
initial begin
	#102 PC_enable_tb = 1;
	   IorD_tb = 1; 	//MUX
	   MemWrite_tb = 0;
	   RegWrite_tb = 0;
	   IRWrite_tb = 1;
	#4 PC_enable_tb = 0;

	#6 PC_enable_tb = 0;
	#7  ALUSrcA_tb = 0;	//MUX
	    ALUSrcB_tb = 2'b01;	//MUX 4to1
	#5  ALUControl_tb = 3'b000;
	#2  RegWrite_tb = 1;	//MUX
	    MemtoReg_tb = 1;	//MUX
	    RegDst_tb = 1;		//MUX

	#2  RegWrite_tb = 0;
	#2  ALUSrcA_tb = 1;
	    ALUSrcB_tb = 2'b10;
	    ALUControl_tb = 3'b000;
	    PCSrc_tb = 1;	//MUX
	    MemtoReg_tb = 1'bx;
	    RegDst_tb = 1'bx;
end
initial begin
	#132 PC_enable_tb = 1;
	   IorD_tb = 1; 	//MUX
	   MemWrite_tb = 0;
	   RegWrite_tb = 0;
	   IRWrite_tb = 1;
	#4 PC_enable_tb = 0;

	#6 PC_enable_tb = 0;
	#7  ALUSrcA_tb = 0;	//MUX
	    ALUSrcB_tb = 2'b01;	//MUX 4to1
	#5  ALUControl_tb = 3'b000;
	#2  RegWrite_tb = 1;	//MUX
	    MemtoReg_tb = 1;	//MUX
	    RegDst_tb = 1;		//MUX

	#4  RegWrite_tb = 0;
	#2  ALUSrcA_tb = 1;
	    ALUSrcB_tb = 2'b10;
	    ALUControl_tb = 3'b000;
	    PCSrc_tb = 1;	//MUX
	    MemtoReg_tb = 1'bx;
	    RegDst_tb = 1'bx;
end
initial begin 
	#165 PC_enable_tb = 1;
	   IorD_tb = 1;
	   MemWrite_tb = 0;
	   RegWrite_tb = 0;
	   IRWrite_tb = 1;
	#4 PC_enable_tb = 0;

	#6 PC_enable_tb = 0;
	#7  ALUSrcA_tb = 0;	//MUX
	    ALUSrcB_tb = 2'b01;	//MUX 4to1
	#5  ALUControl_tb = 3'b000;
	#2  RegWrite_tb = 1;	//MUX
	    MemtoReg_tb = 1;	//MUX
	    RegDst_tb = 1;		//MUX

end
endmodule 