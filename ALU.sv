Project 3 ALU
Brayan Ortiz
module fullAdder(a, b, cin, cout, sum);
    output cout;
    output sum;
    input a;
    input b;
    input cin;
    assign cout = (b & cin) | (a & cin) | (a & b);
    assign sum = (a & ~b & ~cin) | (~a & ~b & cin) | (a & b & cin) | (~a & b & ~cin);
      
endmodule
module RippleAdder(a, b, cin, sum);
  wire cout;
  output [7:0] sum;
  input [7:0] a;
  input [7:0] b;
  wire [7:0] carry;
  input cin;
   
  fullAdder full1(a[0], b[0], cin, carry[1], sum[0]);
  fullAdder full2(a[1], b[1], carry[1], carry[2], sum[1]);
  fullAdder full3(a[2], b[2], carry[2], carry[3], sum[2]);
  fullAdder full4(a[3], b[3], carry[3], carry[4], sum[3]);
  fullAdder full5(a[4], b[4], carry[4], carry[5], sum[4]);
  fullAdder full6(a[5], b[5], carry[5], carry[6], sum[5]);
  fullAdder full7(a[6], b[6], carry[6], carry[7], sum[6]);
  fullAdder full8(a[7], b[7], carry[7], cout, sum[7]);

endmodule
module andop(a, b, andResult);
  input [7:0] a;
  input [7:0] b;
  output [7:0] andResult;
  assign andResult = a & b;
  
endmodule
module orop(a, b, orResult);
  input [7:0] a;
  input [7:0] b;
  output [7:0] orResult;
  assign orResult = a | b;
  
endmodule
module xorop(a, b, xorResult);
  input [7:0] a;
  input [7:0] b;
  output [7:0] xorResult;
  assign xorResult = a ^ b;
  
endmodule
  


module rotop(a, b, out);
  input [7:0] a;
  input [7:0] b;
  output [7:0] out;
  wire [7:0] c;
  wire [7:0] d;
  TwoToOne rot1(a, {a[3:0],a[7:4]}, b[2], c);
  TwoToOne rot2(c, {c[5:0],c[7:6]}, b[1], d);
  TwoToOne rot3(d, {d[6:0],d[7]}, b[0], out);
  
Endmodule

module  EightMux(sum,sub,rot,xorResult,ora,anda,undef1,undef2,op,mux7out);
  input[7:0] sum;
  input[7:0] sub;
  input[7:0] rot;
  input[7:0] xorResult; 
  input[7:0] ora; 
  input[7:0] anda;
  input[7:0] other1;
  input[7:0] other2;
  input[2:0] op;
  output[7:0] mux7out;
  wire [7:0] mux1out;
  wire [7:0] mux2out;
  wire [7:0] mux3out;
  wire [7:0] mux4out;
  wire [7:0] mux5out;
  wire [7:0] mux6out;
  wire [7:0] mux7out;
  input [7:0] undef1;
  input [7:0] undef2;
  
  TwoToOne Mux1(sum, sub, op[0], mux1out);
  TwoToOne Mux2(rot, xorResult, op[0], mux2out);
  TwoToOne Mux3(anda, ora, op[0], mux3out);
  TwoToOne Mux4(undef1, undef2, op[0], mux4out);
  TwoToOne Mux5(mux1out, mux2out, op[1], mux5out);
  TwoToOne Mux6(mux3out, mux4out, op[1], mux6out);
  TwoToOne Mux7(mux5out, mux6out, op[2], mux7out);
endmodule 

module TwoToOne(input1, input2, sel, result);
input [7:0] input1;
input [7:0] input2;
input sel;
output [7:0] result;
wire [7:0] sel8 = {sel,sel,sel,sel,sel,sel,sel,sel};
assign result = (input1 & ~sel8) | (input2 & sel8); 
 
endmodule

module ALU;
  reg [7:0] a;
  reg [7:0] b;
  wire[7:0] sum;
  wire[7:0] sub;
  wire[7:0] rot;
  wire[7:0] xorResult; 
  wire[7:0] ora; 
  wire[7:0] anda;
  wire[7:0] out;
  reg [2:0] op;
  wire cin;
  wire [7:0] undef1;
  wire [7:0] undef2;
  wire [7:0] c;
  wire [7:0] d;
  
  assign c = a;
  assign d = ~b;
  
  assign undef1 = 8'b11111111;
  assign undef2 = 8'b11111111;
  
  RippleAdder add1(a, b, 1'b0, sum); 
  RippleAdder sub1(c, d, 1'b1, sub);
  rotop rotop1(a, b, rot);
  xorop xorop1(a, b, xorResult);
  orop orop1(a, b, ora);
  andop andop1(a, b, anda);
  
  EightMux operand(sum,sub,rot,xorResult,ora,anda,undef1,undef2,op,out);

initial 
    begin  
     $monitor($time,,"a=%b%b%b%b%b%b%b%b,b=%b%b%b%b%b%b%b%b,op=%b%b%b,out=%b%b%b%b%b%b%b%b",a[7],a[6],a[5],a[4],a[3],a[2],a[1],a[0],b[7],b[6],b[5],b[4],b[3],b[2],b[1],b[0],op[2],op[1],op[0],out[7],out[6],out[5],out[4],out[3],out[2],out[1],out[0]);         
     #10 a[7]=0;a[6]=0;a[5]=0;a[4]=1;a[3]=1;a[2]=0;a[1]=0;a[0]=1;b[7]=0;b[6]=0;b[5]=0;b[4]=1;b[3]=1;b[2]=1;b[1]=1;b[0]=0;op[2]=0;op[1]=0;op[0]=0;
     #10 a[7]=0;a[6]=0;a[5]=0;a[4]=1;a[3]=1;a[2]=1;a[1]=1;a[0]=0;b[7]=0;b[6]=0;b[5]=0;b[4]=1;b[3]=1;b[2]=0;b[1]=0;b[0]=1;op[2]=0;op[1]=0;op[0]=1;   
     #10 a[7]=0;a[6]=0;a[5]=0;a[4]=1;a[3]=1;a[2]=1;a[1]=1;a[0]=0;b[7]=0;b[6]=0;b[5]=0;b[4]=1;b[3]=1;b[2]=0;b[1]=0;b[0]=1;op[2]=0;op[1]=0;op[0]=1;    
     #10 a[7]=0;a[6]=0;a[5]=0;a[4]=0;a[3]=1;a[2]=0;a[1]=1;a[0]=0;b[7]=0;b[6]=0;b[5]=0;b[4]=0;b[3]=0;b[2]=1;b[1]=0;b[0]=1;op[2]=0;op[1]=1;op[0]=0;    
     #10 a[7]=0;a[6]=0;a[5]=0;a[4]=0;a[3]=1;a[2]=1;a[1]=1;a[0]=1;b[7]=0;b[6]=0;b[5]=0;b[4]=0;b[3]=0;b[2]=0;b[1]=1;b[0]=1;op[2]=0;op[1]=1;op[0]=1;    
     #10 a[7]=0;a[6]=0;a[5]=0;a[4]=1;a[3]=1;a[2]=1;a[1]=1;a[0]=1;b[7]=0;b[6]=0;b[5]=0;b[4]=0;b[3]=0;b[2]=0;b[1]=1;b[0]=1;op[2]=1;op[1]=0;op[0]=0;    
     #10 a[7]=0;a[6]=0;a[5]=0;a[4]=0;a[3]=1;a[2]=1;a[1]=0;a[0]=0;b[7]=0;b[6]=0;b[5]=0;b[4]=0;b[3]=0;b[2]=1;b[1]=0;b[0]=1;op[2]=1;op[1]=0;op[0]=1;
     #10 $finish;
    end
endmodule

