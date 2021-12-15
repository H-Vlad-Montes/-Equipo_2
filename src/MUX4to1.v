module MUX4to1 #(
parameter WIDTH = 32
)(
	input [WIDTH-1:0] a,
	input [WIDTH-1:0] b,
	input [WIDTH-1:0] c,
	input [WIDTH-1:0] d,
	input [1:0] selec,

   output reg [WIDTH-1:0] SrcB

);
reg [WIDTH-1:0] value = 32'b0000_0000_0000_0000_0000_0000_0000_0100;

	localparam S0 = 2'b00;
   localparam S1 = 2'b01;
   localparam S2 = 2'b10;
   localparam S3 = 2'b11;

always @ (*)
   begin
      case(selec)
			default:
				SrcB = a;
         S1: begin
            SrcB = value;
         end
         S2: begin
            SrcB = c;
         end
         S3: begin
            SrcB = d;
         end
			endcase
   end
endmodule
