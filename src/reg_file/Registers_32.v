module Registers_32
#(
	parameter WIDTH = 32
)
(
	input [WIDTH-1:0] Rd,
	input clk, reset,
	input reg_write_i,
	input [WIDTH-1:0] CP_o,
	output [WIDTH-1:0] Q, Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14, Q15,
	output [WIDTH-1:0] Q16, Q17, Q18, Q19, Q20, Q21, Q22, Q23, Q24, Q25, Q26, Q27, Q28, Q29, Q30, Q31
	);
	wire [WIDTH-1 : 0] Enable_dec;
	
generate
	genvar i;
		for (i = 0; i < WIDTH; i = i+1)
		begin: Reg
			and dec (Enable_dec[i], reg_write_i, CP_o[i]);
	end
endgenerate 
	
	ff Reg0 (.d(Rd), .clk(clk), .reset(reset), .enable(Enable_dec[0]), .q(Q));
	ff Reg1 (.d(Rd), .clk(clk), .reset(reset), .enable(Enable_dec[1]), .q(Q1));
	ff Reg2 (.d(Rd), .clk(clk), .reset(reset), .enable(Enable_dec[2]), .q(Q2));
	ff Reg3 (.d(Rd), .clk(clk), .reset(reset), .enable(Enable_dec[3]), .q(Q3));
	ff Reg4 (.d(Rd), .clk(clk), .reset(reset), .enable(Enable_dec[4]), .q(Q4));
	ff Reg5 (.d(Rd), .clk(clk), .reset(reset), .enable(Enable_dec[5]), .q(Q5));
	ff Reg6 (.d(Rd), .clk(clk), .reset(reset), .enable(Enable_dec[6]), .q(Q6));
	ff Reg7 (.d(Rd), .clk(clk), .reset(reset), .enable(Enable_dec[7]), .q(Q7));
	ff Reg8 (.d(Rd), .clk(clk), .reset(reset), .enable(Enable_dec[8]), .q(Q8));
	ff Reg9 (.d(Rd), .clk(clk), .reset(reset), .enable(Enable_dec[9]), .q(Q9));
	ff Reg10 (.d(Rd), .clk(clk), .reset(reset), .enable(Enable_dec[10]), .q(Q10));
	ff Reg11 (.d(Rd), .clk(clk), .reset(reset), .enable(Enable_dec[11]), .q(Q11));
	ff Reg12 (.d(Rd), .clk(clk), .reset(reset), .enable(Enable_dec[12]), .q(Q12));
	ff Reg13 (.d(Rd), .clk(clk), .reset(reset), .enable(Enable_dec[13]), .q(Q13));
	ff Reg14 (.d(Rd), .clk(clk), .reset(reset), .enable(Enable_dec[14]), .q(Q14));
	ff Reg15 (.d(Rd), .clk(clk), .reset(reset), .enable(Enable_dec[15]), .q(Q15));
	ff Reg16 (.d(Rd), .clk(clk), .reset(reset), .enable(Enable_dec[16]), .q(Q16));
	ff Reg17 (.d(Rd), .clk(clk), .reset(reset), .enable(Enable_dec[17]), .q(Q17));
	ff Reg18 (.d(Rd), .clk(clk), .reset(reset), .enable(Enable_dec[18]), .q(Q18));
	ff Reg19 (.d(Rd), .clk(clk), .reset(reset), .enable(Enable_dec[19]), .q(Q19));
	ff Reg20 (.d(Rd), .clk(clk), .reset(reset), .enable(Enable_dec[20]), .q(Q20));
	ff Reg21 (.d(Rd), .clk(clk), .reset(reset), .enable(Enable_dec[21]), .q(Q21));
	ff Reg22 (.d(Rd), .clk(clk), .reset(reset), .enable(Enable_dec[22]), .q(Q22));
	ff Reg23 (.d(Rd), .clk(clk), .reset(reset), .enable(Enable_dec[23]), .q(Q23));
	ff Reg24 (.d(Rd), .clk(clk), .reset(reset), .enable(Enable_dec[24]), .q(Q24));
	ff Reg25 (.d(Rd), .clk(clk), .reset(reset), .enable(Enable_dec[25]), .q(Q25));
	ff Reg26 (.d(Rd), .clk(clk), .reset(reset), .enable(Enable_dec[26]), .q(Q26));
	ff Reg27 (.d(Rd), .clk(clk), .reset(reset), .enable(Enable_dec[27]), .q(Q27));
	ff Reg28 (.d(Rd), .clk(clk), .reset(reset), .enable(Enable_dec[28]), .q(Q28));
	ff Reg29 (.d(Rd), .clk(clk), .reset(reset), .enable(Enable_dec[29]), .q(Q29));
	ff Reg30 (.d(Rd), .clk(clk), .reset(reset), .enable(Enable_dec[30]), .q(Q30));
	ff Reg31 (.d(Rd), .clk(clk), .reset(reset), .enable(Enable_dec[31]), .q(Q31));



endmodule 