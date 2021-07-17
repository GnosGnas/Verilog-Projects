module tb;
	reg [15:0] a,b;
	wire [31:0] out;
	reg clk;

	MULT M(a,b,out,clk);

	always
	#75 clk = !clk;

	initial
	begin
	a = 12;
	b = 24;
	clk = 0;

	$monitor($time," %d x %d = %d ",a,b,out);

	#16000 $finish;
	end
endmodule