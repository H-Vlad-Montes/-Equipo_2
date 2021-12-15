module sign_extend (
	input [15:0] sign_ext_i,
	output wire [31:0] sign_ext_o
);

assign sign_ext_o = {{16{sign_ext_i[15]}},sign_ext_i};
endmodule
