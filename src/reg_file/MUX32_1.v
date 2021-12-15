module MUX32_1
#(
	parameter WIDTH = 32,
	parameter SIZE = 5
	)
   (
	input [WIDTH-1:0] data_0, data_1, data_2, data_3, data_4, data_5,
	input [WIDTH-1:0] data_6, data_7, data_8, data_9, data_10, data_11,
	input [WIDTH-1:0] data_12, data_13, data_14, data_15, data_16, data_17,
	input [WIDTH-1:0] data_18, data_19, data_20, data_21, data_22, data_23,
	input [WIDTH-1:0] data_24, data_25, data_26, data_27, data_28, data_29,
	input [WIDTH-1:0] data_30, data_31,
	
   input [SIZE-1:0]selec,
   output reg [WIDTH-1:0] data_out
	);
always @(*)
begin
case (selec) 
	1: begin
		data_out = data_1;
	end
	2: begin
		data_out = data_2;
	end
	3: begin
		data_out = data_3;
	end
	4: begin
		data_out = data_4;
	end
	5: begin
		data_out = data_5;
	end
	6: begin
		data_out = data_6;
	end
	7: begin
		data_out = data_7;
	end
	8: begin
		data_out = data_8;
	end
	9: begin
		data_out = data_9;
	end
	10: begin
		data_out = data_10;
	end
	11: begin
		data_out = data_11;
	end
	12: begin
		data_out = data_12;
	end
	13: begin
		data_out = data_13;
	end
	14: begin
		data_out = data_14;
	end
	15: begin
		data_out = data_15;
	end
	16: begin
		data_out = data_16;
	end
	17: begin
		data_out = data_17;
	end
	18: begin
		data_out = data_18;
	end
	19: begin
		data_out = data_19;
	end
	20: begin
		data_out = data_20;
	end
	21: begin
		data_out = data_21;
	end
	22: begin
		data_out = data_22;
	end
	23: begin
		data_out = data_23;
	end	
	24: begin
		data_out = data_24;
	end	
	25: begin
		data_out = data_25;
	end	
	26: begin
		data_out = data_26;
	end	
	27: begin
		data_out = data_27;
	end	
	28: begin
		data_out = data_28;
	end	
	29: begin
		data_out = data_29;
	end	
	30: begin
		data_out = data_30;
	end	
	31: begin
		data_out = data_31;
	end
	default: 
	begin 
		data_out = data_0;
	end
endcase	
end
endmodule
