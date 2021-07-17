module MULT(a,b,out,clk);

	//Stage 0:

	input [19:0] a,b;
	input clk;
	output [39:0] out;

	wire [19:0][38:0] t0;

	assign t0[0] = {19'b0, a[19]&b[0], a[18]&b[0], a[17]&b[0], a[16]&b[0], a[15]&b[0], a[14]&b[0], a[13]&b[0], a[12]&b[0], a[11]&b[0], a[10]&b[0], a[9]&b[0], a[8]&b[0], a[7]&b[0], a[6]&b[0], a[5]&b[0], a[4]&b[0], a[3]&b[0], a[2]&b[0], a[1]&b[0], a[0]&b[0] };
	assign t0[1] = {18'b0, a[19]&b[1], a[18]&b[1], a[17]&b[1], a[16]&b[1], a[15]&b[1], a[14]&b[1], a[13]&b[1], a[12]&b[1], a[11]&b[1], a[10]&b[1], a[9]&b[1], a[8]&b[1], a[7]&b[1], a[6]&b[1], a[5]&b[1], a[4]&b[1], a[3]&b[1], a[2]&b[1], a[1]&b[1], a[0]&b[1],1'b0};
	assign t0[2] = {17'b0, a[19]&b[2], a[18]&b[2], a[17]&b[2], a[16]&b[2], a[15]&b[2], a[14]&b[2], a[13]&b[2], a[12]&b[2], a[11]&b[2], a[10]&b[2], a[9]&b[2], a[8]&b[2], a[7]&b[2], a[6]&b[2], a[5]&b[2], a[4]&b[2], a[3]&b[2], a[2]&b[2], a[1]&b[2], a[0]&b[2],2'b0};
	assign t0[3] = {16'b0, a[19]&b[3], a[18]&b[3], a[17]&b[3], a[16]&b[3], a[15]&b[3], a[14]&b[3], a[13]&b[3], a[12]&b[3], a[11]&b[3], a[10]&b[3], a[9]&b[3], a[8]&b[3], a[7]&b[3], a[6]&b[3], a[5]&b[3], a[4]&b[3], a[3]&b[3], a[2]&b[3], a[1]&b[3], a[0]&b[3],3'b0};
	assign t0[4] = {15'b0, a[19]&b[4], a[18]&b[4], a[17]&b[4], a[16]&b[4], a[15]&b[4], a[14]&b[4], a[13]&b[4], a[12]&b[4], a[11]&b[4], a[10]&b[4], a[9]&b[4], a[8]&b[4], a[7]&b[4], a[6]&b[4], a[5]&b[4], a[4]&b[4], a[3]&b[4], a[2]&b[4], a[1]&b[4], a[0]&b[4],4'b0};
	assign t0[5] = {14'b0, a[19]&b[5], a[18]&b[5], a[17]&b[5], a[16]&b[5], a[15]&b[5], a[14]&b[5], a[13]&b[5], a[12]&b[5], a[11]&b[5], a[10]&b[5], a[9]&b[5], a[8]&b[5], a[7]&b[5], a[6]&b[5], a[5]&b[5], a[4]&b[5], a[3]&b[5], a[2]&b[5], a[1]&b[5], a[0]&b[5],5'b0};
	assign t0[6] = {13'b0, a[19]&b[6], a[18]&b[6], a[17]&b[6], a[16]&b[6], a[15]&b[6], a[14]&b[6], a[13]&b[6], a[12]&b[6], a[11]&b[6], a[10]&b[6], a[9]&b[6], a[8]&b[6], a[7]&b[6], a[6]&b[6], a[5]&b[6], a[4]&b[6], a[3]&b[6], a[2]&b[6], a[1]&b[6], a[0]&b[6],6'b0};
	assign t0[7] = {12'b0, a[19]&b[7], a[18]&b[7], a[17]&b[7], a[16]&b[7], a[15]&b[7], a[14]&b[7], a[13]&b[7], a[12]&b[7], a[11]&b[7], a[10]&b[7], a[9]&b[7], a[8]&b[7], a[7]&b[7], a[6]&b[7], a[5]&b[7], a[4]&b[7], a[3]&b[7], a[2]&b[7], a[1]&b[7], a[0]&b[7],7'b0};
	assign t0[8] = {11'b0, a[19]&b[8], a[18]&b[8], a[17]&b[8], a[16]&b[8], a[15]&b[8], a[14]&b[8], a[13]&b[8], a[12]&b[8], a[11]&b[8], a[10]&b[8], a[9]&b[8], a[8]&b[8], a[7]&b[8], a[6]&b[8], a[5]&b[8], a[4]&b[8], a[3]&b[8], a[2]&b[8], a[1]&b[8], a[0]&b[8],8'b0};
	assign t0[9] = {10'b0, a[19]&b[9], a[18]&b[9], a[17]&b[9], a[16]&b[9], a[15]&b[9], a[14]&b[9], a[13]&b[9], a[12]&b[9], a[11]&b[9], a[10]&b[9], a[9]&b[9], a[8]&b[9], a[7]&b[9], a[6]&b[9], a[5]&b[9], a[4]&b[9], a[3]&b[9], a[2]&b[9], a[1]&b[9], a[0]&b[9],9'b0};
	assign t0[10] = {9'b0, a[19]&b[10], a[18]&b[10], a[17]&b[10], a[16]&b[10], a[15]&b[10], a[14]&b[10], a[13]&b[10], a[12]&b[10], a[11]&b[10], a[10]&b[10], a[9]&b[10], a[8]&b[10], a[7]&b[10], a[6]&b[10], a[5]&b[10], a[4]&b[10], a[3]&b[10], a[2]&b[10], a[1]&b[10], a[0]&b[10],10'b0};
	assign t0[11] = {8'b0, a[19]&b[11], a[18]&b[11], a[17]&b[11], a[16]&b[11], a[15]&b[11], a[14]&b[11], a[13]&b[11], a[12]&b[11], a[11]&b[11], a[10]&b[11], a[9]&b[11], a[8]&b[11], a[7]&b[11], a[6]&b[11], a[5]&b[11], a[4]&b[11], a[3]&b[11], a[2]&b[11], a[1]&b[11], a[0]&b[11],11'b0};
	assign t0[12] = {7'b0, a[19]&b[12], a[18]&b[12], a[17]&b[12], a[16]&b[12], a[15]&b[12], a[14]&b[12], a[13]&b[12], a[12]&b[12], a[11]&b[12], a[10]&b[12], a[9]&b[12], a[8]&b[12], a[7]&b[12], a[6]&b[12], a[5]&b[12], a[4]&b[12], a[3]&b[12], a[2]&b[12], a[1]&b[12], a[0]&b[12],12'b0};
	assign t0[13] = {6'b0, a[19]&b[13], a[18]&b[13], a[17]&b[13], a[16]&b[13], a[15]&b[13], a[14]&b[13], a[13]&b[13], a[12]&b[13], a[11]&b[13], a[10]&b[13], a[9]&b[13], a[8]&b[13], a[7]&b[13], a[6]&b[13], a[5]&b[13], a[4]&b[13], a[3]&b[13], a[2]&b[13], a[1]&b[13], a[0]&b[13],13'b0};
	assign t0[14] = {5'b0, a[19]&b[14], a[18]&b[14], a[17]&b[14], a[16]&b[14], a[15]&b[14], a[14]&b[14], a[13]&b[14], a[12]&b[14], a[11]&b[14], a[10]&b[14], a[9]&b[14], a[8]&b[14], a[7]&b[14], a[6]&b[14], a[5]&b[14], a[4]&b[14], a[3]&b[14], a[2]&b[14], a[1]&b[14], a[0]&b[14],14'b0};
	assign t0[15] = {4'b0, a[19]&b[15], a[18]&b[15], a[17]&b[15], a[16]&b[15], a[15]&b[15], a[14]&b[15], a[13]&b[15], a[12]&b[15], a[11]&b[15], a[10]&b[15], a[9]&b[15], a[8]&b[15], a[7]&b[15], a[6]&b[15], a[5]&b[15], a[4]&b[15], a[3]&b[15], a[2]&b[15], a[1]&b[15], a[0]&b[15],15'b0};
	assign t0[16] = {3'b0, a[19]&b[16], a[18]&b[16], a[17]&b[16], a[16]&b[16], a[15]&b[16], a[14]&b[16], a[13]&b[16], a[12]&b[16], a[11]&b[16], a[10]&b[16], a[9]&b[16], a[8]&b[16], a[7]&b[16], a[6]&b[16], a[5]&b[16], a[4]&b[16], a[3]&b[16], a[2]&b[16], a[1]&b[16], a[0]&b[16],16'b0};
	assign t0[17] = {2'b0, a[19]&b[17], a[18]&b[17], a[17]&b[17], a[16]&b[17], a[15]&b[17], a[14]&b[17], a[13]&b[17], a[12]&b[17], a[11]&b[17], a[10]&b[17], a[9]&b[17], a[8]&b[17], a[7]&b[17], a[6]&b[17], a[5]&b[17], a[4]&b[17], a[3]&b[17], a[2]&b[17], a[1]&b[17], a[0]&b[17],17'b0};
	assign t0[18] = {1'b0, a[19]&b[18], a[18]&b[18], a[17]&b[18], a[16]&b[18], a[15]&b[18], a[14]&b[18], a[13]&b[18], a[12]&b[18], a[11]&b[18], a[10]&b[18], a[9]&b[18], a[8]&b[18], a[7]&b[18], a[6]&b[18], a[5]&b[18], a[4]&b[18], a[3]&b[18], a[2]&b[18], a[1]&b[18], a[0]&b[18],18'b0};
	assign t0[19] = {a[19]&b[19], a[18]&b[19], a[17]&b[19], a[16]&b[19], a[15]&b[19], a[14]&b[19], a[13]&b[19], a[12]&b[19], a[11]&b[19], a[10]&b[19], a[9]&b[19], a[8]&b[19], a[7]&b[19], a[6]&b[19], a[5]&b[19], a[4]&b[19], a[3]&b[19], a[2]&b[19], a[1]&b[19], a[0]&b[19], 19'b0 };


	//Stage 1:
	reg res1;
	wire [20:0] w11,w12;
	reg [19:1][39:1] t1 = 0;

	csa21 c1_1(t0[0][21:1],t0[1][21:1],t0[2][21:1],w11,w12);

	wire [21:0] w13,w14;

	csa21 c1_2(t0[3][24:4],t0[4][24:4],t0[5][24:4],w13[21:1],w14[21:1]);

	assign w13[0] = t0[3][3];

	wire [21:0] w16,w17;

	csa21 c1_5(t0[6][27:7],t0[7][27:7],t0[8][27:7],w16[21:1],w17[21:1]);

	assign w16[0] = t0[6][6];

	wire [21:0] w19,w110;

	csa21 c1_8(t0[9][30:10],t0[10][30:10],t0[11][30:10],w19[21:1],w110[21:1]);

	assign w19[0] = t0[9][9];

	wire [21:0] w112,w113;

	csa21 c1_11(t0[12][33:13],t0[13][33:13],t0[14][33:13],w112[21:1],w113[21:1]);

	assign w112[0] = t0[12][12];

	wire [21:0] w115,w116;

	csa21 c1_14(t0[15][36:16],t0[16][36:16],t0[17][36:16],w115[21:1],w116[21:1]);

	assign w115[0] = t0[15][15];

	always@(posedge clk)
	begin
	res1 = t0[0][0];
	t1[1][21:1] = w11;
	t1[2][22:2] = w12;
	t1[3][24:3] = w13;
	t1[5][25:5] = w14[21:1];
	t1[6][27:6] = w16;
	t1[8][28:8] = w17[21:1];
	t1[9][30:9] = w19;
	t1[11][31:11] = w110[21:1];
	t1[12][33:12] = w112;
	t1[14][34:14] = w113[21:1];
	t1[15][36:15] = w115;
	t1[17][37:17] = w116[21:1];
	t1[18] = t0[18];
	t1[19] = t0[19];
	end

	//Stage 2:

	reg [1:0] res2;
	reg [19:2][39:2] t2 = 0;
	wire [22:0] w21,w22;

	csa23 c2_1(t1[1][24:2], t1[2][24:2], t1[3][24:2], w21,w22);

	always@(posedge clk)
	begin
	t2[2][24:2] = w21;
	t2[3][25:3] = w22;
	end

	always@(posedge clk)
	res2 = {t1[1][1],res1};

	wire [23:0] w25,w26;

	csa23 c2_5(t1[5][28:6], t1[6][28:6], t1[8][28:6], w25[23:1], w26[23:1]);
	assign w25[0] = t1[5][5];

	always@(posedge clk)
	begin
	t2[5][28:5] = w25;
	t2[7][29:7] = w26[23:1];
	end

	wire [23:0] w211,w212;

	csa23 c2_11(t1[11][34:12], t1[12][34:12], t1[14][34:12], w211[23:1], w212[23:1]);
	assign w211[0] = t1[11][11];

	always@(posedge clk)
	begin
	t2[11][34:11] = w211;
	t2[13][35:13] = w212[23:1];
	end

	wire [21:0] w217,w218;

	csa21 c2_17(t1[17][38:18], t1[18][38:18], t1[19][38:18], w217[21:1], w218[21:1]);
	assign w217[0] = t1[17][17];

	always@(posedge clk)
	begin
	t2[17][38:17] = w217;
	t2[19][39:19] = w218[21:1];
	end

	//Stage 3:

	reg [2:0] res3;
	reg [19:3][39:3] t3 = 0;
	wire [25:0] w31,w32;

	csa26 c3_1(t2[2][28:3], t2[3][28:3], t2[5][28:3], w31,w32);

	always@(posedge clk)
	begin
	t3[3][28:3] = w31;
	t3[4][29:4] = w32;
	end

	always@(posedge clk)
	res3 = {t2[2][2],res2};

	wire [27:0] w37,w38;

	csa26 c3_7(t2[7][34:9], t2[9][34:9], t2[11][34:9], w37[27:2], w38[27:2]);
	assign w37[1:0] = t2[7][8:7];

	always@(posedge clk)
	begin
	t3[7][34:7] = w37;
	t3[10][35:10] = w38[27:2];
	end

	wire [25:0] w313,w314;

	csa24 c3_13(t2[13][38:15], t2[15][38:15], t2[17][38:15], w313[25:2], w314[25:2]);
	assign w313[1:0] = t2[13][14:13];

	always@(posedge clk)
	begin
	t3[13][38:13] = w313;
	t3[16][39:16] = w314[25:2];
	end

	always@(posedge clk)
	begin
	t3[19] = t2[19];
	end

	//Stage 4:

	reg [3:0] res4;
	reg [19:4][39:4] t4 = 0;
	wire [30:0] w41,w42;

	csa31 c4_1(t3[3][34:4], t3[4][34:4], t3[7][34:4], w41,w42);

	always@(posedge clk)
	begin
	t4[4][34:4] = w41;
	t4[5][35:5] = w42;
	end

	always@(posedge clk)
	res4 = {t3[3][3],res3};

	wire [29:0] w410,w411;

	csa27 c4_10(t3[10][39:13], t3[13][39:13], t3[16][39:13], w410[29:3], w411[29:3]);
	assign w410[2:0] = t3[10][12:10];

	always@(posedge clk)
	begin
	t4[10][39:10] = w410;
	t4[14][40:14] = w411[29:3];
	end

	always@(posedge clk)
	begin
	t4[19] = t3[19];
	end

	//Stage 5:

	reg [4:0] res5;
	reg [19:5][39:5] t5 = 0;
	wire [34:0] w51,w52;

	csa35 c5_1(t4[4][39:5], t4[5][39:5], t4[10][39:5], w51,w52);

	always@(posedge clk)
	begin
	t5[5][39:5] = w51;
	t5[6][40:6] = w52;
	end

	always@(posedge clk)
	res5 = {t4[4][4],res4};

	always@(posedge clk)
	begin
	t5[14] = t4[14];
	t5[19] = t4[19];
	end

	//Stage 6:

	reg [5:0] res6;
	reg [19:6][39:6] t6 = 0;
	wire [34:0] w61,w62;

	csa35 c6_1(t5[5][40:6], t5[6][40:6], t5[14][40:6], w61,w62);

	always@(posedge clk)
	begin
	t6[6][40:6] = w61;
	t6[7][41:7] = w62;
	end

	always@(posedge clk)
	res6 = {t5[5][5],res5};

	always@(posedge clk)
	begin
	t6[19] = t5[19];
	end

	//Stage 7:

	reg [6:0] res7;
	reg [19:7][39:7] t7 = 0;
	wire [34:0] w71,w72;

	csa35 c7_1(t6[6][41:7], t6[7][41:7], t6[19][41:7], w71,w72);

	always@(posedge clk)
	begin
	t7[7][41:7] = w71;
	t7[8][42:8] = w72;
	end

	always@(posedge clk)
	res7 = {t6[6][6],res6};

	//Stage 8:
	wire [34:0] rest;//unnecessary wire
	wire cp;
	reg [39:0] result; 

	cla35 carry_adder(t7[7][42:8], t7[8][42:8], rest, cp);

	always@(posedge clk)
	result = {rest[31:0],t7[7][7],res7};

	assign out = result;

	endmodule


module FullAdder(input a,b,c, output cout,s);
	assign cout = a&b|b&c|c&a;
	assign s = a^b^c;
endmodule

module csa21(a,b,c,x_out,c_out);
	parameter N = 21;

	input [N-1:0] a,b,c;
	output [N-1:0] x_out,c_out;

	genvar p;
	for(p = 0;p<N;p=p+1)
	begin:fa
	FullAdder FA(a[p],b[p],c[p],c_out[p],x_out[p]);
	end

endmodule

module csa23(a,b,c,x_out,c_out);
	parameter N = 23;

	input [N-1:0] a,b,c;
	output [N-1:0] x_out,c_out;

	genvar p;
	for(p = 0;p<N;p=p+1)
	begin:fa
	FullAdder FA(a[p],b[p],c[p],c_out[p],x_out[p]);
	end

endmodule

module csa24(a,b,c,x_out,c_out);
	parameter N = 24;

	input [N-1:0] a,b,c;
	output [N-1:0] x_out,c_out;

	genvar p;
	for(p = 0;p<N;p=p+1)
	begin:fa
	FullAdder FA(a[p],b[p],c[p],c_out[p],x_out[p]);
	end

endmodule

module csa26(a,b,c,x_out,c_out);
	parameter N = 26;

	input [N-1:0] a,b,c;
	output [N-1:0] x_out,c_out;

	genvar p;
	for(p = 0;p<N;p=p+1)
	begin:fa
	FullAdder FA(a[p],b[p],c[p],c_out[p],x_out[p]);
	end

endmodule

module csa27(a,b,c,x_out,c_out);
	parameter N = 27;

	input [N-1:0] a,b,c;
	output [N-1:0] x_out,c_out;

	genvar p;
	for(p = 0;p<N;p=p+1)
	begin:fa
	FullAdder FA(a[p],b[p],c[p],c_out[p],x_out[p]);
	end

endmodule

module csa31(a,b,c,x_out,c_out);
	parameter N = 31;

	input [N-1:0] a,b,c;
	output [N-1:0] x_out,c_out;

	genvar p;
	for(p = 0;p<N;p=p+1)
	begin:fa
	FullAdder FA(a[p],b[p],c[p],c_out[p],x_out[p]);
	end

endmodule

module csa35(a,b,c,x_out,c_out);
	parameter N = 35;

	input [N-1:0] a,b,c;
	output [N-1:0] x_out,c_out;

	genvar p;
	for(p = 0;p<N;p=p+1)
	begin:fa
	FullAdder FA(a[p],b[p],c[p],c_out[p],x_out[p]);
	end

endmodule


module opr(p,q,o);
	input [1:0] p,q;
	output [1:0] o;

	assign o[0] = p[1] | q[0]&p[0];
	assign o[1] = p[1] | q[1]&p[0];
endmodule

module cla35(a,b,sum,cout);
	input [34:0] a,b;
	output [34:0] sum;
	output cout;

	wire [35:0][1:0] c0;
	wire [34:0] t0,t1;

	assign t0 = a|b;
	assign t1 = a&b;

	assign c0[0] = 2'b0;
	assign c0[1] = {t1[0],t0[0]};
	assign c0[2] = {t1[1],t0[1]};
	assign c0[3] = {t1[2],t0[2]};
	assign c0[4] = {t1[3],t0[3]};
	assign c0[5] = {t1[4],t0[4]};
	assign c0[6] = {t1[5],t0[5]};
	assign c0[7] = {t1[6],t0[6]};
	assign c0[8] = {t1[7],t0[7]};
	assign c0[9] = {t1[8],t0[8]};
	assign c0[10] = {t1[9],t0[9]};
	assign c0[11] = {t1[10],t0[10]};
	assign c0[12] = {t1[11],t0[11]};
	assign c0[13] = {t1[12],t0[12]};
	assign c0[14] = {t1[13],t0[13]};
	assign c0[15] = {t1[14],t0[14]};
	assign c0[16] = {t1[15],t0[15]};
	assign c0[17] = {t1[16],t0[16]};
	assign c0[18] = {t1[17],t0[17]};
	assign c0[19] = {t1[18],t0[18]};
	assign c0[20] = {t1[19],t0[19]};
	assign c0[21] = {t1[20],t0[20]};
	assign c0[22] = {t1[21],t0[21]};
	assign c0[23] = {t1[22],t0[22]};
	assign c0[24] = {t1[23],t0[23]};
	assign c0[25] = {t1[24],t0[24]};
	assign c0[26] = {t1[25],t0[25]};
	assign c0[27] = {t1[26],t0[26]};
	assign c0[28] = {t1[27],t0[27]};
	assign c0[29] = {t1[28],t0[28]};
	assign c0[30] = {t1[29],t0[29]};
	assign c0[31] = {t1[30],t0[30]};
	assign c0[32] = {t1[31],t0[31]};
	assign c0[33] = {t1[32],t0[32]};
	assign c0[34] = {t1[33],t0[33]};
	assign c0[35] = {t1[34],t0[34]};

	wire [35:0][1:0] c1, c2, c3, c4, c5, c6, c7;

	opr op1_35(c0[35],c0[34],c1[35]);
	opr op1_34(c0[34],c0[33],c1[34]);
	opr op1_33(c0[33],c0[32],c1[33]);
	opr op1_32(c0[32],c0[31],c1[32]);
	opr op1_31(c0[31],c0[30],c1[31]);
	opr op1_30(c0[30],c0[29],c1[30]);
	opr op1_29(c0[29],c0[28],c1[29]);
	opr op1_28(c0[28],c0[27],c1[28]);
	opr op1_27(c0[27],c0[26],c1[27]);
	opr op1_26(c0[26],c0[25],c1[26]);
	opr op1_25(c0[25],c0[24],c1[25]);
	opr op1_24(c0[24],c0[23],c1[24]);
	opr op1_23(c0[23],c0[22],c1[23]);
	opr op1_22(c0[22],c0[21],c1[22]);
	opr op1_21(c0[21],c0[20],c1[21]);
	opr op1_20(c0[20],c0[19],c1[20]);
	opr op1_19(c0[19],c0[18],c1[19]);
	opr op1_18(c0[18],c0[17],c1[18]);
	opr op1_17(c0[17],c0[16],c1[17]);
	opr op1_16(c0[16],c0[15],c1[16]);
	opr op1_15(c0[15],c0[14],c1[15]);
	opr op1_14(c0[14],c0[13],c1[14]);
	opr op1_13(c0[13],c0[12],c1[13]);
	opr op1_12(c0[12],c0[11],c1[12]);
	opr op1_11(c0[11],c0[10],c1[11]);
	opr op1_10(c0[10],c0[9],c1[10]);
	opr op1_9(c0[9],c0[8],c1[9]);
	opr op1_8(c0[8],c0[7],c1[8]);
	opr op1_7(c0[7],c0[6],c1[7]);
	opr op1_6(c0[6],c0[5],c1[6]);
	opr op1_5(c0[5],c0[4],c1[5]);
	opr op1_4(c0[4],c0[3],c1[4]);
	opr op1_3(c0[3],c0[2],c1[3]);
	opr op1_2(c0[2],c0[1],c1[2]);
	opr op1_1(c0[1],c0[0],c1[1]);
	assign c1[0] = c0[0];

	opr op2_35(c1[35],c1[33],c2[35]);
	opr op2_34(c1[34],c1[32],c2[34]);
	opr op2_33(c1[33],c1[31],c2[33]);
	opr op2_32(c1[32],c1[30],c2[32]);
	opr op2_31(c1[31],c1[29],c2[31]);
	opr op2_30(c1[30],c1[28],c2[30]);
	opr op2_29(c1[29],c1[27],c2[29]);
	opr op2_28(c1[28],c1[26],c2[28]);
	opr op2_27(c1[27],c1[25],c2[27]);
	opr op2_26(c1[26],c1[24],c2[26]);
	opr op2_25(c1[25],c1[23],c2[25]);
	opr op2_24(c1[24],c1[22],c2[24]);
	opr op2_23(c1[23],c1[21],c2[23]);
	opr op2_22(c1[22],c1[20],c2[22]);
	opr op2_21(c1[21],c1[19],c2[21]);
	opr op2_20(c1[20],c1[18],c2[20]);
	opr op2_19(c1[19],c1[17],c2[19]);
	opr op2_18(c1[18],c1[16],c2[18]);
	opr op2_17(c1[17],c1[15],c2[17]);
	opr op2_16(c1[16],c1[14],c2[16]);
	opr op2_15(c1[15],c1[13],c2[15]);
	opr op2_14(c1[14],c1[12],c2[14]);
	opr op2_13(c1[13],c1[11],c2[13]);
	opr op2_12(c1[12],c1[10],c2[12]);
	opr op2_11(c1[11],c1[9],c2[11]);
	opr op2_10(c1[10],c1[8],c2[10]);
	opr op2_9(c1[9],c1[7],c2[9]);
	opr op2_8(c1[8],c1[6],c2[8]);
	opr op2_7(c1[7],c1[5],c2[7]);
	opr op2_6(c1[6],c1[4],c2[6]);
	opr op2_5(c1[5],c1[3],c2[5]);
	opr op2_4(c1[4],c1[2],c2[4]);
	opr op2_3(c1[3],c1[1],c2[3]);
	opr op2_2(c1[2],c1[0],c2[2]);
	assign c2[1] = c1[1];
	assign c2[0] = c1[0];

	opr op3_35(c2[35],c2[31],c3[35]);
	opr op3_34(c2[34],c2[30],c3[34]);
	opr op3_33(c2[33],c2[29],c3[33]);
	opr op3_32(c2[32],c2[28],c3[32]);
	opr op3_31(c2[31],c2[27],c3[31]);
	opr op3_30(c2[30],c2[26],c3[30]);
	opr op3_29(c2[29],c2[25],c3[29]);
	opr op3_28(c2[28],c2[24],c3[28]);
	opr op3_27(c2[27],c2[23],c3[27]);
	opr op3_26(c2[26],c2[22],c3[26]);
	opr op3_25(c2[25],c2[21],c3[25]);
	opr op3_24(c2[24],c2[20],c3[24]);
	opr op3_23(c2[23],c2[19],c3[23]);
	opr op3_22(c2[22],c2[18],c3[22]);
	opr op3_21(c2[21],c2[17],c3[21]);
	opr op3_20(c2[20],c2[16],c3[20]);
	opr op3_19(c2[19],c2[15],c3[19]);
	opr op3_18(c2[18],c2[14],c3[18]);
	opr op3_17(c2[17],c2[13],c3[17]);
	opr op3_16(c2[16],c2[12],c3[16]);
	opr op3_15(c2[15],c2[11],c3[15]);
	opr op3_14(c2[14],c2[10],c3[14]);
	opr op3_13(c2[13],c2[9],c3[13]);
	opr op3_12(c2[12],c2[8],c3[12]);
	opr op3_11(c2[11],c2[7],c3[11]);
	opr op3_10(c2[10],c2[6],c3[10]);
	opr op3_9(c2[9],c2[5],c3[9]);
	opr op3_8(c2[8],c2[4],c3[8]);
	opr op3_7(c2[7],c2[3],c3[7]);
	opr op3_6(c2[6],c2[2],c3[6]);
	opr op3_5(c2[5],c2[1],c3[5]);
	opr op3_4(c2[4],c2[0],c3[4]);
	assign c3[3] = c2[3];
	assign c3[2] = c2[2];
	assign c3[1] = c2[1];
	assign c3[0] = c2[0];

	opr op4_35(c3[35],c3[27],c4[35]);
	opr op4_34(c3[34],c3[26],c4[34]);
	opr op4_33(c3[33],c3[25],c4[33]);
	opr op4_32(c3[32],c3[24],c4[32]);
	opr op4_31(c3[31],c3[23],c4[31]);
	opr op4_30(c3[30],c3[22],c4[30]);
	opr op4_29(c3[29],c3[21],c4[29]);
	opr op4_28(c3[28],c3[20],c4[28]);
	opr op4_27(c3[27],c3[19],c4[27]);
	opr op4_26(c3[26],c3[18],c4[26]);
	opr op4_25(c3[25],c3[17],c4[25]);
	opr op4_24(c3[24],c3[16],c4[24]);
	opr op4_23(c3[23],c3[15],c4[23]);
	opr op4_22(c3[22],c3[14],c4[22]);
	opr op4_21(c3[21],c3[13],c4[21]);
	opr op4_20(c3[20],c3[12],c4[20]);
	opr op4_19(c3[19],c3[11],c4[19]);
	opr op4_18(c3[18],c3[10],c4[18]);
	opr op4_17(c3[17],c3[9],c4[17]);
	opr op4_16(c3[16],c3[8],c4[16]);
	opr op4_15(c3[15],c3[7],c4[15]);
	opr op4_14(c3[14],c3[6],c4[14]);
	opr op4_13(c3[13],c3[5],c4[13]);
	opr op4_12(c3[12],c3[4],c4[12]);
	opr op4_11(c3[11],c3[3],c4[11]);
	opr op4_10(c3[10],c3[2],c4[10]);
	opr op4_9(c3[9],c3[1],c4[9]);
	opr op4_8(c3[8],c3[0],c4[8]);
	assign c4[7] = c3[7];
	assign c4[6] = c3[6];
	assign c4[5] = c3[5];
	assign c4[4] = c3[4];
	assign c4[3] = c3[3];
	assign c4[2] = c3[2];
	assign c4[1] = c3[1];
	assign c4[0] = c3[0];

	opr op5_35(c4[35],c4[19],c5[35]);
	opr op5_34(c4[34],c4[18],c5[34]);
	opr op5_33(c4[33],c4[17],c5[33]);
	opr op5_32(c4[32],c4[16],c5[32]);
	opr op5_31(c4[31],c4[15],c5[31]);
	opr op5_30(c4[30],c4[14],c5[30]);
	opr op5_29(c4[29],c4[13],c5[29]);
	opr op5_28(c4[28],c4[12],c5[28]);
	opr op5_27(c4[27],c4[11],c5[27]);
	opr op5_26(c4[26],c4[10],c5[26]);
	opr op5_25(c4[25],c4[9],c5[25]);
	opr op5_24(c4[24],c4[8],c5[24]);
	opr op5_23(c4[23],c4[7],c5[23]);
	opr op5_22(c4[22],c4[6],c5[22]);
	opr op5_21(c4[21],c4[5],c5[21]);
	opr op5_20(c4[20],c4[4],c5[20]);
	opr op5_19(c4[19],c4[3],c5[19]);
	opr op5_18(c4[18],c4[2],c5[18]);
	opr op5_17(c4[17],c4[1],c5[17]);
	opr op5_16(c4[16],c4[0],c5[16]);
	assign c5[15] = c4[15];
	assign c5[14] = c4[14];
	assign c5[13] = c4[13];
	assign c5[12] = c4[12];
	assign c5[11] = c4[11];
	assign c5[10] = c4[10];
	assign c5[9] = c4[9];
	assign c5[8] = c4[8];
	assign c5[7] = c4[7];
	assign c5[6] = c4[6];
	assign c5[5] = c4[5];
	assign c5[4] = c4[4];
	assign c5[3] = c4[3];
	assign c5[2] = c4[2];
	assign c5[1] = c4[1];
	assign c5[0] = c4[0];

	opr op6_35(c5[35],c5[3],c6[35]);
	opr op6_34(c5[34],c5[2],c6[34]);
	opr op6_33(c5[33],c5[1],c6[33]);
	opr op6_32(c5[32],c5[0],c6[32]);
	assign c6[31] = c5[31];
	assign c6[30] = c5[30];
	assign c6[29] = c5[29];
	assign c6[28] = c5[28];
	assign c6[27] = c5[27];
	assign c6[26] = c5[26];
	assign c6[25] = c5[25];
	assign c6[24] = c5[24];
	assign c6[23] = c5[23];
	assign c6[22] = c5[22];
	assign c6[21] = c5[21];
	assign c6[20] = c5[20];
	assign c6[19] = c5[19];
	assign c6[18] = c5[18];
	assign c6[17] = c5[17];
	assign c6[16] = c5[16];
	assign c6[15] = c5[15];
	assign c6[14] = c5[14];
	assign c6[13] = c5[13];
	assign c6[12] = c5[12];
	assign c6[11] = c5[11];
	assign c6[10] = c5[10];
	assign c6[9] = c5[9];
	assign c6[8] = c5[8];
	assign c6[7] = c5[7];
	assign c6[6] = c5[6];
	assign c6[5] = c5[5];
	assign c6[4] = c5[4];
	assign c6[3] = c5[3];
	assign c6[2] = c5[2];
	assign c6[1] = c5[1];
	assign c6[0] = c5[0];

	assign c7[35] = c6[35];
	assign c7[34] = c6[34];
	assign c7[33] = c6[33];
	assign c7[32] = c6[32];
	assign c7[31] = c6[31];
	assign c7[30] = c6[30];
	assign c7[29] = c6[29];
	assign c7[28] = c6[28];
	assign c7[27] = c6[27];
	assign c7[26] = c6[26];
	assign c7[25] = c6[25];
	assign c7[24] = c6[24];
	assign c7[23] = c6[23];
	assign c7[22] = c6[22];
	assign c7[21] = c6[21];
	assign c7[20] = c6[20];
	assign c7[19] = c6[19];
	assign c7[18] = c6[18];
	assign c7[17] = c6[17];
	assign c7[16] = c6[16];
	assign c7[15] = c6[15];
	assign c7[14] = c6[14];
	assign c7[13] = c6[13];
	assign c7[12] = c6[12];
	assign c7[11] = c6[11];
	assign c7[10] = c6[10];
	assign c7[9] = c6[9];
	assign c7[8] = c6[8];
	assign c7[7] = c6[7];
	assign c7[6] = c6[6];
	assign c7[5] = c6[5];
	assign c7[4] = c6[4];
	assign c7[3] = c6[3];
	assign c7[2] = c6[2];
	assign c7[1] = c6[1];
	assign c7[0] = c6[0];

	wire [34:0] temp;

	assign temp[0] = c7[0][0];
	assign temp[1] = c7[1][0];
	assign temp[2] = c7[2][0];
	assign temp[3] = c7[3][0];
	assign temp[4] = c7[4][0];
	assign temp[5] = c7[5][0];
	assign temp[6] = c7[6][0];
	assign temp[7] = c7[7][0];
	assign temp[8] = c7[8][0];
	assign temp[9] = c7[9][0];
	assign temp[10] = c7[10][0];
	assign temp[11] = c7[11][0];
	assign temp[12] = c7[12][0];
	assign temp[13] = c7[13][0];
	assign temp[14] = c7[14][0];
	assign temp[15] = c7[15][0];
	assign temp[16] = c7[16][0];
	assign temp[17] = c7[17][0];
	assign temp[18] = c7[18][0];
	assign temp[19] = c7[19][0];
	assign temp[20] = c7[20][0];
	assign temp[21] = c7[21][0];
	assign temp[22] = c7[22][0];
	assign temp[23] = c7[23][0];
	assign temp[24] = c7[24][0];
	assign temp[25] = c7[25][0];
	assign temp[26] = c7[26][0];
	assign temp[27] = c7[27][0];
	assign temp[28] = c7[28][0];
	assign temp[29] = c7[29][0];
	assign temp[30] = c7[30][0];
	assign temp[31] = c7[31][0];
	assign temp[32] = c7[32][0];
	assign temp[33] = c7[33][0];
	assign temp[34] = c7[34][0];

	assign sum = temp^a^b;
	assign cout = c7[35][0];
endmodule