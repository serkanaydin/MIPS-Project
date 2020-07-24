module mult3_32_1(output0, i0, i1, i2, i3, i4, i5, select);
output [31:0] output0;
input [31:0]i0,i1, i2, i3, i4, i5;
input [2:0] select;
reg [31:0] temp;
always @*
begin
  if(select == 3'b000)  temp = i0;     //select for normal writedata input
  if(select == 3'b001)  temp = i1;     //select for sll instruction
  if(select == 3'b010)  temp = i2;     //select for ori instruction
  if(select == 3'b011)  temp = i3;     //select for jmsub instruction
  if(select == 3'b100)  temp = i4;     //select for bneal instruction
  if(select == 3'b101)  temp = i5;     //select for balrn instruction
end
  assign output0 = temp;
endmodule
