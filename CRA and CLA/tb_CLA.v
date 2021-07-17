module tb;
	parameter N = 8;

	reg [N-1:0] a,b;
	wire [N-1:0] s;
	wire cout;

	CLA CarryLookahead(a,b,s,cout);

	initial
		begin
		$monitor($time,"%d + %d = %d (+8*%d)",a,b,s,cout);
		a = 10;
		b = 12;

		#100 $finish;
		end
endmodule