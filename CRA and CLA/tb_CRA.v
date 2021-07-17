module tb;
	parameter N = 64;

	reg [N-1:0] a,b;
	wire [N-1:0] s;
	wire cout;

	CRA CarryRipple(a,b,s,cout);

	initial
		begin
		$monitor($time,"%d + %d = %d  (+8*%d)",a,b,s,cout);
		a = 1561;
		b = 1456;

		#100 $finish;
		end
endmodule