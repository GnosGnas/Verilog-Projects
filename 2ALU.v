//cout logic may not be perfect. Gives one when number is more than 8 and not supposed to be negative. Gives 0 in a case where it might have assumed the number to be negative before adding.
//Also output in tb is in decimal form and doesn't identify negative numbers
module ALU(in1,in2,sel,cin,M,out,cout,comparator,P,G);
input [3:0] in1,in2,sel;
input cin,M;
output [3:0] out;
output cout,comparator,P,G;

wire [3:0] a[7:0];
wire [2:0] p,q;
wire M_a; //Mode of addition
wire [3:0] i1,i2;
wire [3:0] t1,t2;
wire co_t1,co_t2,co_t3;
wire [3:0] out_t;

assign comparator=&(in1^~in2);
assign P=in1[3]^in2[3];
assign G=in1[3]&in2[3];

assign cout= sel==4'd6? ~M&(co_t1|co_t2|co_t3): ~M&(co_t2|co_t3);

ADD_4 A1(in1,in2,1'b1,M,t1,co_t1);

assign a[0]=in1;
assign a[1]=in1|in2;
assign a[2]=in1|~in2;
assign a[3]=4'b0; 
assign a[4]=in1&in2;
assign a[5]=in1&~in2;
assign a[6]=t1;
assign a[7]=4'b1;

assign p[0]=(~sel[3]&sel[0])|(sel[3]&sel[2]&~sel[1]&sel[0]);
assign p[1]=(sel[1]&~sel[0])|(~sel[3]&~sel[2]&sel[1]);
assign p[2]=(~sel[3]&sel[2]&sel[1])|(sel[3]&~sel[2]&sel[1]&sel[0]);

assign i1=a[p];

assign q[0]=~sel[3]|(sel[1]&sel[0]);
assign q[1]=(~sel[3]&~sel[2])|(~sel[3]&sel[1])|(sel[1]&sel[0]);
assign q[2]=(sel[3]^sel[2])|(sel[1]&sel[0]);

assign i2= sel==4'd9? in2:a[q];

assign M_a= sel[1:0]==2'd3? 1: sel==4'd6? ~M : 0;

ADD_4 A2(i1,i2,M_a,M,out_t,co_t2);

ADD_4 A3(out_t,{3'b0,cin},1'b0,M,out,co_t3);

endmodule


module ADD_4(in1,in2,M_a,D_c,out,cout);  //M_a - mode of addition, D_c - disable carry
input [3:0] in1,in2;
input M_a,D_c;
output [3:0] out;
output cout;

wire [4:1] c;

assign cout=c[3]^c[4];

FA f0(in1[0],M_a^in2[0],M_a,out[0],c[1]);  

FA f1(in1[1],M_a^in2[1],~D_c&c[1],out[1],c[2]);

FA f2(in1[2],M_a^in2[2],~D_c&c[2],out[2],c[3]);

FA f3(in1[3],M_a^in2[3],~D_c&c[3],out[3],c[4]);

endmodule


module FA(input in1,in2,cin, output out,cout);

assign {cout,out}=in1+in2+cin;

endmodule


module tb;
reg [3:0] in1,in2,sel;
reg cin,M;
wire [3:0] out;
wire cout,comp,p,g;

ALU A(in1,in2,sel,cin,M,out,cout,comp,p,g);

initial
begin
$monitor($time," A-%d  B-%d  Cout-%d  O/P-%d  Sel-%d",in1,in2,cout,out,sel);
#1 in1=5; in2 =3; cin=1;M=0;
#1 sel=0;


#76 $finish;
end

always
#5 sel=sel+1;

endmodule

