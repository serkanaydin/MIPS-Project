module mult2_to_32(out, i0,i1,i2,s0,i3);
output [31:0] out;
input [31:0]i0,i1,i2,i3;
input [1:0]s0;

reg  [31:0]  out;
wire[1:0] s0;
wire[31:0] i0,i1,i2,i3;

always @( s0 or i0 or i1 or i2)
begin
   case( s0 )
       2'b00 : out = i0;
       2'b01 : out = i1;
       2'b10 : out = i2;
       2'b11 : out = i3;
     
   endcase
end

endmodule
