`timescale 1ns/1ps
module tb;
integer    cycles;   initial cycles=0;
integer    errors;   initial errors=0;
integer    wrongs;   initial wrongs=0;
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
parameter WID = 32;
reg  rclk;
wire [(WID - 1):0] rdata;
reg  readx;
wire  rempty;
reg  rst_nr;
reg  rst_nw;
reg  wclk;
reg [(WID - 1):0] wdata;
wire  wfull;
reg  writex;
wire rst_n = rst_nw;
wire clk = wclk;

`include "tester.include"

initial begin
    $dumpvars(0,tb);
    rclk = 0;
    readx = 0;
    rst_nr = 0;
    rst_nw = 0;
    wclk = 0;
    wdata = 0;
    writex = 0;
    #100;
    rst_nr = 1;
    rst_nw = 1;
end
async2fifo dut (
     .rclk(rclk)
    ,.rdata(rdata[(WID - 1):0])
    ,.readx(readx)
    ,.rempty(rempty)
    ,.rst_nr(rst_nr)
    ,.rst_nw(rst_nw)
    ,.wclk(wclk)
    ,.wdata(wdata[(WID - 1):0])
    ,.wfull(wfull)
    ,.writex(writex)
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


module inout_driver ( inout io , input dflt );

reg val; initial val=0;
reg drive; initial drive=0;
assign io = drive ? val : 1'bz;
assign (pull1,pull0) io = dflt;

endmodule
