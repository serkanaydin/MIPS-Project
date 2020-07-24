module control(in,in2,regdest,alusrc,memtoreg,regwrite,memread,memwrite,branch,aluop1,aluop2,bneal,balrn,jrs,ori,jmsub, sll, WD_Mux_Signal,status,beq);
input [5:0] in;
input [1:0] status;
input [5:0] in2;
output [2:0] WD_Mux_Signal;
reg [2:0] WD_temp_Mux;
output [1:0] regdest;
output alusrc,memtoreg,regwrite,memread,memwrite,branch,aluop1,aluop2,beq;
wire rformat,lw,sw,beq;
assign rformat=~|in;
assign lw=in[5]& (~in[4])&(~in[3])&(~in[2])&in[1]&in[0];
assign sw=in[5]& (~in[4])&in[3]&(~in[2])&in[1]&in[0];
assign beq=~in[5]& (~in[4])&(~in[3])&in[2]&(~in[1])&(~in[0]);

//
output bneal,balrn,jrs,ori, jmsub, sll;
assign bneal=((in[5]) & (~in[4]) & (in[3]) & (in[2]) & (~in[1]) & (in[0]));       // bneal (101101)
assign balrn= (rformat) & (~in2[5]) & (in2[4]) & (~in2[3]) & (in2[2]) & (in2[1]) & (in2[0]);      // balrn function code = (010111)
assign jrs =((~in[5]) & in[4] & (~in[3]) & (~in[2]) & in[1] & (~in[0]));                          // jrs(010010)
assign ori = (~in[5]) & (~in[4]) & (in[3]) & (in[2]) & (~in[1]) & (in[0]);                        // ori (001101)
assign jmsub = (rformat) & (in2[5]) & (~in2[4]) & (~in2[3]) & (~in2[2]) & (in2[1]) & (~in2[0]);  // jmsub function code = (100010)
assign sll = (rformat) & (~in2[5]) & (~in2[4]) & (~in2[3]) & (~in2[2]) & (~in2[1]) & (~in2[0]);  // sll function code = (000000)
assign linkadress= bneal|balrn|jmsub;//~ if bneal or balrn or jrs writeregister will be r31
assign regdest={linkadress,rformat};//~
//

//assign regdest=rformat;
assign alusrc=lw|sw;
assign memtoreg=lw;
assign regwrite=(rformat&(~balrn))|lw|ori|(bneal&(~status[1]))|jmsub|(balrn&status[0]);
assign memread=lw|jrs|jmsub;
assign memwrite=sw;
assign branch=beq;
assign aluop1=rformat;
assign aluop2=beq|bneal;

always @*
begin
  assign WD_temp_Mux = 3'b000;
  if(sll)
     assign WD_temp_Mux = 3'b001;
  if(ori)
     assign WD_temp_Mux = 3'b010;
  if(jmsub)
    assign WD_temp_Mux = 3'b011;
  if(bneal)
    assign WD_temp_Mux = 3'b100;
  if(balrn)
    assign WD_temp_Mux = 3'b101;
end

assign WD_Mux_Signal = WD_temp_Mux;

endmodule
