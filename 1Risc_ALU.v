module RISC_ALU(x1,x2,instr,cin,opcode_4,y,cout);
input [31:0] x1,x2;
input [31:12] instr;  ///instruction [31:12]
input cin, opcode_4;
output [31:0] y;
output cout;

wire [31:0] in1,in2;
wire [2:0] func3;
wire [11:0] imm12;
wire [19:0] sign;
wire [4:0] shamt;
wire func7_5;  //defines mode of operation
wire [31:0] yt[7:0];

assign sign = imm12[11]==1? -1:0;
assign in1 = x1;
assign in2 = opcode_4==1? x2:{sign,imm12};
assign func3 = instr[14:12];
assign imm12 = instr[31:20];
assign shamt = opcode_4==1? x2[4:0]:instr[24:20];
assign func7_5 = instr[30];

ADD A1(in1,in2,cin,func7_5,yt[0],cout);
assign yt[1] = in1 << shamt;
SLT SLT1(in1,in2,1'b1,yt[2]);
SLT SLT2(in1,in2,1'b0,yt[3]);
assign yt[4]=in1^in2;  //in2 and imm relation??
assign yt[5] = in1 >> shamt;
assign yt[6] = in1|in2;  ///""
assign yt[7] = in1&in2;  ///""

assign y = yt[func3];

endmodule


primitive COUT(cout,a,b,s);
input a,b,s;
output cout;
table
0 0 0 : 0;
0 0 1 : 1;
0 1 ? : 0;
1 0 ? : 0;
1 1 0 : 1;
1 1 1 : 0;
endtable
endprimitive


module ADD(in1,in2,cin,m,out,cout);

input [31:0] in1,in2;
input cin,m;
output [31:0] out;
output cout;

wire [31:0] t;

assign t = m==1? in1+in2 : in1-in2;
assign out = t+cin;

COUT(cout,in1[31],in2[31],t[31]);

endmodule


module SLT(in1,in2,s,out);
input [31:0] in1,in2;
input s;  //signed (1) or unsigned (0)
output [31:0] out;

wire [31:0] t;
wire c1,c2; //temp variables

ADD A3(in1,in2,1'b0,1'b1,t,c1);

assign c2 = s&in1[31]&~in2[31] | ~s&~in1[31]&in2[31] | t[31]&(~in1[31]^in2[31]);
assign out = {30'b0,c2}; 

endmodule











