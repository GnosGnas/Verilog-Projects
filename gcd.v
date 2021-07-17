module GCD_dp(gt,lt,eq,ldA,ldB,sel1,sel2,sel_in,data_in,clk);
	input ldA,ldB,sel1,sel2,sel_in,clk;
	input [15:0] data_in;
	output gt,lt,eq;
	wire [15:0] Aout,Bout,x,y,bus,SubOut;
	PIPO A(Aout,bus,ldA,clk);
	PIPO B(Bout,bus,ldB,clk);
	MUX MUX_in1(x,Aout,Bout,sel1);
	MUX MUX_in2(y,Aout,Bout,sel2);
	MUX MUX_load(bus,SubOut,data_in,sel_in);
	SUB SB(SubOut,x,y);
	COMPARE COMP(lt,gt,eq,Aout,Bout);
endmodule


module PIPO(dout,din,ld,clk);
	input [15:0] din;
	input ld,clk;
	output reg [15:0] dout;
	
	always@(posedge clk)
		if(ld) dout<=din;
endmodule


module SUB(out,in1,in2);
	input [15:0] in1,in2;
	output reg [15:0] out;
	always @(*)
		out=in1-in2;
endmodule


module COMPARE(lt,gt,eq,d1,d2);
	input [15:0] d1,d2;
	output lt,gt,eq;
	
	assign lt=d1>d2;
	assign gt=d1<d2;
	assign eq=d1==d2;
endmodule


module MUX(out,in0,in1,sel);
	input [15:0] in0,in1;
	input sel;
	output [15:0] out;

	assign out=sel?in1:in0;
endmodule


module controller(ldA,ldB,sel1,sel2,sel_in,done,clk,lt,gt,eq,start);
	input clk,lt,gt,eq,start;
	output reg ldA,ldB,sel1,sel2,sel_in,done;
	reg [2:0] state;
	parameter s0=3'b0,s1=3'b1,s2=3'b10,s3=3'b11,s4=3'b100,s5=3'b101;

	always @(posedge clk)
		case (state)
		s0: if(start) state<=s1;
		s1: state<=s2;
		s2: #2 if(eq) state<=s5;
			else if(lt) state<=s3;
			else if(gt) state<=s4;
		s3: #2 if(eq) state<=s5;
			else if(lt) state<=s3;
			else if(gt) state<=s4;
		s4: #2 if(eq) state<=s5;
			else if(lt) state<=s3;
			else if(gt) state<=s4;
		s5: state<=s5;
		default: state<=s0;
		endcase
	
	always @(state)
		case (state)
		s0: begin sel_in=1;ldA=1;ldB=0;done=0; end
		s1: begin sel_in=1;ldA=0;ldB=1; end
		s2: if(eq) done=1;
			else if(lt) begin
					sel1=1;sel2=0;sel_in=0;
					#1 ldA=0;ldB=1;
				end
			else if(gt) begin
					sel1=0;sel2=1;sel_in=0;
					#1 ldA=1;ldB=0;
				end
		s3: if(eq) done=1;
			else if(lt) begin
					sel1=1;sel2=0;sel_in=0;
					#1 ldA=0;ldB=1;
				end
			else if(gt) begin
					sel1=0;sel2=1;sel_in=0;
					#1 ldA=1;ldB=0;
				end
		s4: if(eq) done=1;
			else if(lt) begin
					sel1=1;sel2=0;sel_in=0;
					#1 ldA=0;ldB=1;
				end
			else if(gt) begin
					sel1=0;sel2=1;sel_in=0;
					#1 ldA=1;ldB=0;
				end
		s5: begin
			done=1;sel1=0;sel2=0;ldA=0;ldB=0;
			end
		default: begin ldA=0;ldB=0; end
		endcase
endmodule


module GCD_tb;
	reg [15:0] din;
	reg clk,start;
	wire done;
	reg [15:0]a,b;
	
	GCD_dp DP(gt,lt,eq,ldA,ldB,sel1,sel2,sel_in,din,clk);
	controller CON(ldA,ldB,sel1,sel2,sel_in,done,clk,lt,gt,eq,start);

	initial
		begin
		clk=1'b0;
		#3 start=1'b1;
		#1000 $finish;
		end
	always #5 clk=~clk;

	initial
		begin
		#12 din=13;
		#10 din=78;
		end
		
	initial
		begin
		$monitor($time,"%d %b",DP.Aout,done); //Aout is inside the module
		$dumpfile("gcd.vcd");
		$dumpvars(0,GCD_tb);
		end
endmodule



