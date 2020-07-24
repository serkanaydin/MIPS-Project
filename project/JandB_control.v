module JandBcon(status,jmsub,balrn,bneal,beq,jrs,out);
reg[1:0] temp;
output [1:0]out;

input [1:0]status;
input  balrn,bneal,beq,jrs,jmsub;
wire zero,Negative;
assign zero=status[1];
assign Negative=status[0];
assign memoryAdressed=jrs|jmsub;
always @* 
begin
	if((bneal & (~zero)) | (zero & beq))
	begin
	 temp=2'b01; //(PC-Relative)
	end
	else if(memoryAdressed )
	begin
	 temp=2'b10;
	end
        else if(balrn&Negative)
        begin
        temp = 2'b11;
        end
	else 
	begin
	temp=2'b00;
        end
      
end
assign out=temp;
endmodule
