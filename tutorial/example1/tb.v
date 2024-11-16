`timescale 1ns/1ps
module tb;
integer    cycles;   initial cycles=0;
integer    errors;   initial errors=0;
integer    wrongs;   initial wrongs=0;
integer    warnings;   initial warnings=0;
integer    panics;   initial panics=0;
integer    corrects; initial corrects=0;
integer    seqptr; initial seqptr=0;
reg [255:0] markstr;   initial markstr=0;
reg [31:0] mark;   initial mark=0;
reg [31:0] marker;   initial marker=0;
reg [31:0] marker0;   initial marker0=0;
reg [31:0] marker1;   initial marker1=0;
reg [31:0] marker2;   initial marker2=0;
reg [31:0] marker3;   initial marker3=0;
reg [31:0] Index;   initial Index=0;
reg [31:0] ID;   initial ID=0;
reg [31:0] aa;
reg [31:0] bb;
reg  clk;
wire [63:0] out;
reg  vldin;
wire  vldout;
reg rst_n;

always begin
    clk=0;
    #10;
    clk=1;
    #3;
    $python("negedge()");
    #7;
end
initial begin
    $dumpvars(0,tb);
    rst_n = 0;
    aa = 0;
    bb = 0;
    clk = 0;
    vldin = 0;
    #100;
    rst_n=1;
end
multx dut (
     .aa(aa[31:0])
    ,.bb(bb[31:0])
    ,.clk(clk)
    ,.rst_n(rst_n)
    ,.out(out[63:0])
    ,.vldin(vldin)
    ,.vldout(vldout)
);

reg [1023:0] testname;
initial begin
    if ($value$plusargs("LOG=%s",testname)) begin 
        $python("pymonname()",testname);
    end 

    if ($value$plusargs("SEQ=%s",testname)) begin 
         $display(" Running SEQ= %s.",testname); 
    end else begin
        testname = 0;
        $display(" default test");
    end 
    #10;
    if (testname!=0) $python("sequence()",testname);
end 
endmodule

