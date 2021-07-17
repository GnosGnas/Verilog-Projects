module opr(p,q,o);
	input [1:0] p,q;
	output [1:0] o;

	assign #3 o[0] = p[1] | q[0]&p[0];
	assign #3 o[1] = p[1] | q[1]&p[0];
endmodule

module CLA(a,b,sum,cout);
	input [7:0] a,b;
	output [7:0] sum;
	output cout;

	wire [8:0][1:0] c0;
	wire [7:0] t0,t1;

	assign #3 t0 = a|b;
	assign #3 t1 = a&b;

	assign c0[0] = 2'b0;
	assign c0[1] = {t1[0],t0[0]};
	assign c0[2] = {t1[1],t0[1]};
	assign c0[3] = {t1[2],t0[2]};
	assign c0[4] = {t1[3],t0[3]};
	assign c0[5] = {t1[4],t0[4]};
	assign c0[6] = {t1[5],t0[5]};
	assign c0[7] = {t1[6],t0[6]};
	assign c0[8] = {t1[7],t0[7]};

	wire [8:0][1:0] c1, c2, c3, c4;

	opr op1_8(c0[8],c0[7],c1[8]);
	opr op1_7(c0[7],c0[6],c1[7]);
	opr op1_6(c0[6],c0[5],c1[6]);
	opr op1_5(c0[5],c0[4],c1[5]);
	opr op1_4(c0[4],c0[3],c1[4]);
	opr op1_3(c0[3],c0[2],c1[3]);
	opr op1_2(c0[2],c0[1],c1[2]);
	opr op1_1(c0[1],c0[0],c1[1]);
	assign c1[0] = c0[0];

	opr op2_8(c1[8],c1[6],c2[8]);
	opr op2_7(c1[7],c1[5],c2[7]);
	opr op2_6(c1[6],c1[4],c2[6]);
	opr op2_5(c1[5],c1[3],c2[5]);
	opr op2_4(c1[4],c1[2],c2[4]);
	opr op2_3(c1[3],c1[1],c2[3]);
	opr op2_2(c1[2],c1[0],c2[2]);
	assign c2[1] = c1[1];
	assign c2[0] = c1[0];

	opr op3_8(c2[8],c2[4],c3[8]);
	opr op3_7(c2[7],c2[3],c3[7]);
	opr op3_6(c2[6],c2[2],c3[6]);
	opr op3_5(c2[5],c2[1],c3[5]);
	opr op3_4(c2[4],c2[0],c3[4]);
	assign c3[3] = c2[3];
	assign c3[2] = c2[2];
	assign c3[1] = c2[1];
	assign c3[0] = c2[0];

	opr op4_8(c3[8],c3[0],c4[8]);
	assign c4[7] = c3[7];
	assign c4[6] = c3[6];
	assign c4[5] = c3[5];
	assign c4[4] = c3[4];
	assign c4[3] = c3[3];
	assign c4[2] = c3[2];
	assign c4[1] = c3[1];
	assign c4[0] = c3[0];

	wire [7:0] temp;

	assign temp[0] = c4[0][0];
	assign temp[1] = c4[1][0];
	assign temp[2] = c4[2][0];
	assign temp[3] = c4[3][0];
	assign temp[4] = c4[4][0];
	assign temp[5] = c4[5][0];
	assign temp[6] = c4[6][0];
	assign temp[7] = c4[7][0];

	assign #6 sum = temp^a^b;
	assign cout = c4[8][0];
endmodule