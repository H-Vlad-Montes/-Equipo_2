module reg_file #(

parameter WIDTH = 32,
parameter SIZE = 5
)(
input clk,
input reset,
input	reg_write_i, 		//enable
input [SIZE-1:0] read_register_1_i, //rs
input [SIZE-1:0] read_register_2_i, //rt
input [SIZE-1:0] write_register_i,  //rd
input [WIDTH-1:0] write_data_i,		// R[rd]

output [WIDTH-1:0] read_data_1_o,//R[rs]
output [WIDTH-1:0] read_data_2_o //R[rt]

);
wire [WIDTH-1:0] Q [0:31];
wire [WIDTH-1:0] cp_o;

cp5x32 rd (.entrada(write_register_i), .salida(cp_o));

Registers_32 R32(
.Rd(write_data_i),
.clk(clk), 
.reset(reset),
.reg_write_i(reg_write_i),
.CP_o(cp_o),
.Q(Q[0]), .Q1(Q[1]), .Q2(Q[2]), .Q3(Q[3]), .Q4(Q[4]), .Q5(Q[5]), .Q6(Q[6]), .Q7(Q[7]), .Q8(Q[8]),
.Q9(Q[9]), .Q10(Q[10]), .Q11(Q[11]), .Q12(Q[12]), .Q13(Q[13]), .Q14(Q[14]), .Q15(Q[15]),
.Q16(Q[16]), .Q17(Q[17]), .Q18(Q[18]), .Q19(Q[19]), .Q20(Q[20]), .Q21(Q[21]), .Q22(Q[22]), .Q23(Q[23]),
.Q24(Q[24]), .Q25(Q[25]), .Q26(Q[26]), .Q27(Q[27]), .Q28(Q[28]), .Q29(Q[29]), .Q30(Q[30]), .Q31(Q[31])
	);
	
MUX32_1 MUX1 (
	.data_0(Q[0]), .data_1(Q[1]), .data_2(Q[2]), .data_3(Q[3]), .data_4(Q[4]), .data_5(Q[5]),
	.data_6(Q[6]), .data_7(Q[7]), .data_8(Q[8]), .data_9(Q[9]), .data_10(Q[10]), .data_11(Q[11]),
	.data_12(Q[12]), .data_13(Q[13]), .data_14(Q[14]), .data_15(Q[15]), .data_16(Q[16]), .data_17(Q[17]),
	.data_18(Q[18]), .data_19(Q[19]), .data_20(Q[20]), .data_21(Q[21]), .data_22(Q[22]), .data_23(Q[23]),
	.data_24(Q[24]), .data_25(Q[25]), .data_26(Q[26]), .data_27(Q[27]), .data_28(Q[28]), .data_29(Q[29]),
	.data_30(Q[30]), .data_31(Q[31]), .selec(read_register_1_i), .data_out(read_data_1_o)
	);
MUX32_1 MUX2 (
	.data_0(Q[0]), .data_1(Q[1]), .data_2(Q[2]), .data_3(Q[3]), .data_4(Q[4]), .data_5(Q[5]),
	.data_6(Q[6]), .data_7(Q[7]), .data_8(Q[8]), .data_9(Q[9]), .data_10(Q[10]), .data_11(Q[11]),
	.data_12(Q[12]), .data_13(Q[13]), .data_14(Q[14]), .data_15(Q[15]), .data_16(Q[16]), .data_17(Q[17]),
	.data_18(Q[18]), .data_19(Q[19]), .data_20(Q[20]), .data_21(Q[21]), .data_22(Q[22]), .data_23(Q[23]),
	.data_24(Q[24]), .data_25(Q[25]), .data_26(Q[26]), .data_27(Q[27]), .data_28(Q[28]), .data_29(Q[29]),
	.data_30(Q[30]), .data_31(Q[31]), .selec(read_register_2_i), .data_out(read_data_2_o)
	);

endmodule

