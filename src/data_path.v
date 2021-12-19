//last
module data_path #(
	parameter WIDTH = 32
)(
	input clk, 
	input reset,
		//inputs to control unit
	input [7:0] GPIO_i,
	output [7:0]GPIO_o
); 

	wire [WIDTH-1:0] in_PC;
	wire [WIDTH-1:0] ffpc_o;
	wire [WIDTH-1:0] ffrd_o;
	wire [WIDTH-1:0] ffwd_o;
	wire [WIDTH-1:0] MUX2X1_1_o;
	wire [WIDTH-1:0] WD3_i;
	wire [WIDTH-1:0] ReadData_o;
	wire [4:0] A3_o;					
	wire zero_1;
    	wire selector_zero;
	wire [WIDTH-1:0] ALUResult;
	wire [WIDTH-1:0] ALU_o;
	wire [WIDTH-1:0] RD1_i;
	wire [WIDTH-1:0] RD2_i;
	wire [WIDTH-1:0] RD1_o;
	wire [WIDTH-1:0] RD2_o;
	wire	[WIDTH-1:0] SrcA;
	wire	[WIDTH-1:0] SrcB;
	wire	[WIDTH-1:0] sign_extend_o;
    wire    [WIDTH-1:0] Zero_Extend_o;
    wire [WIDTH-1:0] Mux_SZ_Ext_o;
    wire [WIDTH-1:0] PC_source_o;
	
	//input / outputs SFM
	wire ALUSrcA;		
	wire [2:0]ALUControl;
	wire [1:0]ALUSrcB;
	wire PC_enable;  //PC
	wire IorD;			
	wire MemWrite;	
	wire IRWrite;		
	wire RegDst;		
	wire MemtoReg;	
	wire RegWrite;	
	wire PCSrc;
   wire PC_Write;
   wire branch;
   wire AND_o;
	wire jump_select;



	registro_pc PC (
	.d(PC_source_o), 					//input
	.clk(clk),
	.reset(reset),
	.enable(PC_enable),
	.q(ffpc_o)					//output
	);
	
	mux2to1 first( 
	.x(ALU_o), //ffpc_o
	.y(ffpc_o), 	//ALU_o
	.Sel(IorD),
	.Data_out(MUX2X1_1_o)
	);
	
	memory_system data_memory(
	.while_enable_i(MemWrite),		//enable
	.write_data(RD2_o), 				//escritura
	.address_i(MUX2X1_1_o),			//Address
	.clk(clk),							//clk
	.instruction_o(ReadData_o)			//output
	);
	
	ff RD (								//Instr****** primer registro del rd
	.d(ReadData_o), 					//input
	.clk(clk),
	.reset(reset),
	.enable(IRWrite),
	.q(ffrd_o)							//output
	);
	
	ff RD_WD3 (					//Data******* segundo registro del rd 
	.d(ReadData_o), 					//input
	.clk(clk),
	.reset(reset),
	.enable(1'b1),
	.q(ffwd_o)							//output
	);
	
	mux2to1 RD_WD3_1( 
	.x(ffwd_o), //ALU_o
	.y(ALU_o), //ffwd_o
	.Sel(MemtoReg),
	.Data_out(WD3_i)
	);
	
	mux2to1
	#(.DATA_WIDTH(5)) A3( 
	.x(ffrd_o [15:11]), //rt_A2
	.y(ffrd_o [20:16]), //rd_A3
	.Sel(RegDst),
	.Data_out(A3_o)
	);
	
	reg_file reg_file(
	.clk(clk),
	.reset(reset),
	.reg_write_i(RegWrite), 		//enable
	.read_register_1_i(ffrd_o [25:21]), 	//rs
	.read_register_2_i(ffrd_o [20:16]), 	//rt
	.write_register_i(A3_o),	// rd
	.write_data_i(WD3_i),		// R[rd]
   .read_data_1_o(RD1_i),		//R[rs]
	.read_data_2_o(RD2_i) 		//R[rt]

);
	ff RD1_A (
	.d(RD1_i), 					//input
	.clk(clk),
	.reset(reset),
	.enable(1'b1),
	.q(RD1_o)					//output ***********salida a monitor 
	);
	
	mux2to1 RD1_A_1( 
	.x(RD1_o), //ffpc_o
	.y(ffpc_o), //RD1_o
	.Sel(ALUSrcA),
	.Data_out(SrcA)					//SrcA input to ALU
	);
	
	ff RD2_B (
	.d(RD2_i), 					//input
	.clk(clk),
	.reset(reset),
	.enable(1'b1),
	.q(RD2_o)					//output SrcB input to MUX4to1_00************salida a monitor
	);
	
	MUX4to1 Src(
	.a(RD2_o),   
	.b(32'h4),						
	.c(Mux_SZ_Ext_o),
	.d(Mux_SZ_Ext_o << 2),
	.selec(ALUSrcB),
   .SrcB(SrcB)					//output to monitor 
	);
	
	 ALU ALUC(
	.select(ALUControl),
	.a(SrcA),
	.b(SrcB),
	.zero(zero_1),
	.y(ALUResult)
	);
	
	ff ALUR (
	.d(ALUResult), 			//input
	.clk(clk),
	.reset(reset),
	.enable(1'b1),
	.q(ALU_o)					//output SrcB input to MUX4to1_00
	);
	
	mux2to1 ALU_result( 
	.x(ALU_o), //ALUResult
	.y(ALUResult), 	//ALU_o
	.Sel(PCSrc),
	.Data_out(in_PC)					//SrcA input to ALU
	);

    mux2to1 PC_J( 
	.x(in_PC), 
	.y({ ffpc_o[31:28], ffrd_o[25:0], {2{1'b0}} }), 	
	.Sel(jump_select),
	.Data_out(PC_source_o)					
	);

	//signo extendido
   	sign_extend Signlmm(
	.sign_ext_i(ffrd_o [15:0]),
	.sign_ext_o(sign_extend_o)
	);

    //ZERO EXTEND
    Zero_extend 		ZE_EXT(
    .GPIO_i(GPIO_i), 
    .Zero_Ext(Zero_Extend_o));

    //MUX TO DECIDE IF GPIO OR SIGN EXTEND
	mux2to1 GPIO_SIGN( 
	.x(Zero_Extend_o), 
	.y(sign_extend_o), 	
	.Sel(selector_zero),
	.Data_out(Mux_SZ_Ext_o)					
	);

	//state machin
	unit_control FSM 
	(
	.clk(clk),
 	.reset(reset),
	.Op(ffrd_o [31:26]),  		//opcode 
	.funct(ffrd_o [5:0]),		//funct	
	.IorD(IorD),	
	.MemWrite(MemWrite),	
	.IRWrite(IRWrite),	
	.RegDest(RegDst),	
	.Mem_to_Reg(MemtoReg),	
	.RegWrite(RegWrite),	
	.ALUSrcA(ALUSrcA),	
	.PCSrc(PCSrc),	
	.select_ori(selector_zero),
	.jump_select(jump_select),
	.PCWrite(PC_Write),
	.branch(branch),
	.ALUSrcB(ALUSrcB),
	.ALUControl(ALUControl) 
	);
and Comp1 (AND_o, branch, zero_1);
or Comp2 (PC_enable, PC_Write, AND_o);

//datapath output to gpio

assign GPIO_o = ALU_o[7:0];
endmodule
