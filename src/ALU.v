module ALU 
#(
        parameter WIDTH = 32
)
(

input          [2:0]   select,
input          [WIDTH-1:0]  a,
input          [WIDTH-1:0]  b,
output					 zero,
output reg		[WIDTH-1:0]  y

);         // ARITHMETIC UNIT
reg z;
always @ (*)
begin
y = 32'b0;
case (select)
3'b001:	y = a + b;
3'b010:	y = a & b;
3'b011:	y = a | b;
3'b100: 	y = a ^ b;
3'b101:	y = a << 1;
3'b110:	y = a >> 1;			
3'b111:	y = a ~^ b;           
default:		y = 4'b0;
endcase
		z = (y == 32'h0) ? 1 : 0;
end
assign zero = z;
//reg z;
//always @ (*)
//begin
//y = 32'b0;
//    case (select)
// 
//        3'b000:   y = a | b;
//        3'b001:	y = a - b;
//        3'b010:	y = a + b;
//        3'b011:	y = a ^ b;
//        3'b100:	y = ~a;
//        3'b101:	y = a << 1;
//        3'b110:	y = a >> 1;         
//        3'b111:	y = 4'b0;           
//
//        default:        y = 4'b0;
//    endcase
//	 	z = (y == 32'h0) ? 1:0;  
//end
//assign zero = z;
endmodule
