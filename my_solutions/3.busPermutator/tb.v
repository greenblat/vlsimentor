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
reg [15:0] control;
reg [7:0] [3:0] din;
wire [7:0] [3:0] dout;
reg clk;
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
    control = 0;

    din[0] = 0;
    din[1] = 1;
    din[2] = 2;
    din[3] = 3;
    din[4] = 4;
    din[5] = 5;
    din[6] = 6;
    din[7] = 7;

    #100;
    rst_n=1;
end
busperm2 dut (
     .control(control[15:0])
    ,.din(din)
    ,.dout(dout)
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

