module alu_32(result,a,b,status,gin,out5,out6,sll,ori,balrn);//ALU operation according to the ALU control line values
output [31:0] result;
input [31:0] a,b,out5,out6; 
input [2:0] gin;
reg [31:0] result;
reg [31:0] less;
input sll,ori,balrn;
output[1:0] status;
reg zout,Nout;
always @( gin)
begin
	case(gin)
	3'b010: result=a+b; 		//ALU control line=010, ADD
	3'b110: result=a+1+(~b);	//ALU control line=110, SUB
	3'b111: begin less=a+1+(~b);	//ALU control line=111, set on less than
			if (less[31]) result=1;	
			else result=0;
		  end
	3'b000: result=a & b;	//ALU control line=000, AND
	3'b001: result=a|b;		//ALU control line=001, OR

			
  3'b101: result=result;
	default: result=31'bx;	
	endcase

zout=~(|result);
if(~balrn)
assign Nout=result[31];
if(sll&out5[31])
assign Nout=1;
if(ori&out6[31])
assign Nout=1;

end
assign status={zout,Nout};
endmodule
