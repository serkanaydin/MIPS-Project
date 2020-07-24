module ori_instruction(out0, dataa, inst15_0);

input[15:0] inst15_0;
input[31:0] dataa;
output[31:0] out0;
genvar i;

wire[31:0] result_wire;     //holding the result
wire[31:0] zero_Extend;     //will hold the zero extended input


for(i=31; i>15; i=i-1)      //extend with zero for 31:16
begin
  assign zero_Extend[i] = 1'b0;
end
for(i=15; i>-1; i=i-1)      //copy the input 15:0
begin
  assign zero_Extend[i] = inst15_0[i];
end

  assign result_wire = (zero_Extend|dataa);    // OR result of DataA[i]|zero_Extand[i]


assign out0 = result_wire;  //assign the final result as output

endmodule