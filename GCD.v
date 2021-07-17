module gcd_datapath(data_in,ldA,ldB,clk,eqz,z); 
	input [15:0] data_in;
	input ldA,ldB,clk;
	output eqz;
	output [15:0] z;
	wire [15:0] a,b;
	reg [15:0] x,y;  //wire
	wire c; //use lt and gt
	assign a=ldA?data_in:0;  //assign separately and also modify bus with data_in and diff
	assign b=ldB?data_in:0;
	comp Res(c,x,y,eqz,clk,z); //c=1 if x>y  //assign bus with mux whose sel_in will be given in compiler

	initial
		begin
		@(posedge ldA) #1 x=a;
		@(posedge ldB) #1 y=b;
		end

	always @(posedge clk)
		if(c) #1 x=x-y; ///separately
		else #1 y=y-x;
endmodule


module comp(c,x,y,eqz,clk,z);
	input [15:0] x,y;
	input clk;
	output reg c,eqz;
	output reg [15:0] z;
	wire [15:0] t;
	sub CT(t,x,y);

	always @(clk)
		if(~|t) begin eqz=1; z=x; end
		else if(t[15]) begin c=0; eqz=0; z=-t; end
		else begin c=1;eqz=0; z=t; end
endmodule


module sub(out,in1,in2);
	input [15:0] in1,in2,e;
	output reg [15:0] out;

	always @(*)
	#1 out=in1-in2;
endmodule


module controller(input start,eqz,clk,output reg done,ldA,ldB);
	reg [2:0] state;
	parameter s0=3'b0, s1=3'b1,s2=3'b10,s3=3'b11,s4=3'b100;  //more states and control data bus stores from here
	initial #1 state=0;

	always @(clk)
		case(state)
		s0: if(start) state<=s1;
		s1: state<=s2;
		s2: state<=s3;
		s3: if(eqz) state<=s4;
		s4: state<=s4;
		default: state<=s0;
		endcase

	always @(state)
		case(state)
		s0: begin ldA=0;ldB=0;done=0; end
		s1: #1 ldA=1;
		s2: begin #1 ldA=0;ldB=1; end
		s3: if(eqz) begin #1 ldA=0;ldB=0;done=1; end 
		s4: state<=s4;
		default: state<=s0;
		endcase
endmodule


module tb;
	reg [15:0] data_in;
	wire [15:0] z;
	reg start,clk;
	wire eqz,ldA,ldB,done;

	gcd_datapath D(data_in,ldA,ldB,clk,eqz,z);
	controller C(start,eqz,clk,done,ldA,ldB);

	initial
		begin
		clk=1'b0;
		#1 start=1'b1;
		#500 $finish;
		end

	always #10 clk=~clk;

	initial begin
		data_in=0;
		#10 data_in=17;
		#10 data_in=10;
		end

	initial begin
		$monitor ($time," gcd=%d data_in=%d eqz=%b",z,data_in,eqz);
		$dumpfile("gcd.vcd");
		$dumpvars(0,tb);
		end
endmodule
