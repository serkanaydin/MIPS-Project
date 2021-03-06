module sll_instruction(out0, inst31_26, inst5_0, datab, inst10_6);


input[4:0] inst10_6;
input[5:0] inst31_26, inst5_0;
input[31:0] datab;
output[31:0] out0; 
reg[31:0] data_sll;
always @*
begin

  if (inst31_26 == 6'b000000)             //Instruction is Rtype
    begin
      if(inst5_0 == 6'b000000)             //Instruction is SLL
        begin
       
        assign data_sll = datab << inst10_6;     //Shift the data corresponding to this shamt value      
        end
    end

end
assign out0 = data_sll;



endmodule
