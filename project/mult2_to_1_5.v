module mult2_to_1_5(out, i0,i1,r31,s0);
output [4:0] out;
input [4:0]i0,i1,r31;
input [1:0] s0;

reg [4:0] out;
wire [4:0] i0,i1,r31;
wire [1:0] s0;
always @( s0 or i0 or i1 or r31 )
begin
   case( s0 )
       0 : out = i0;
       1 : out = i1;
       2 : out = r31;
       3 : out = r31;
   endcase
end
endmodule