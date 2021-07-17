module FullAdder(input a,b,cin, output cout,s);
	assign #6 cout = a&b|b&cin|cin&a;
	assign #12 s = a^b^cin;
endmodule

module CRA(a,b,sum,cout);
	parameter N = 64;

	input [N-1:0] a,b;
	output cout;
	output [N-1:0] sum;

	wire [N-1:0] c;

	assign cout = c[N-1];

	FullAdder FA0(a[0],b[0],1'b0,c[0],sum[0]);

	genvar p;
	for(p = 1;p<N;p=p+1)
		begin:fa
		FullAdder FA(a[p],b[p],c[p-1],c[p],sum[p]);
		end
endmodule