module tb;
	reg [19:0] a,b;
	wire [39:0] out;
	reg clk;

	MULT M(a,b,out,clk);

	always
	#36 clk = !clk;

	initial
	begin
	a = 121;
	b = 11;
	clk = 0;

	$monitor($time," %d x %d = %d ",a,b,out);

	#20000 $finish;
	end
endmodule