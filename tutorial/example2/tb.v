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
reg [15:0] baudrate;
reg  clk;
reg [7:0] control;
reg  nreset;
wire  rx_valid;
wire #30 read_rx = rx_valid;;
wire  rxd;
wire [7:0] rxdata;
wire [7:0] status;
wire  tx_empty;
wire  txd;
reg [7:0] txdata;
reg  write_tx;
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
    baudrate = 10;
    clk = 0;
    control = 8'h50;
    txdata = 0;
    write_tx = 0;
    #100;
    rst_n=1;
end
uartx2 dut0 (
     .clk(clk) ,.nreset(rst_n)
    ,.rxd(rxd) ,.txd(txd)
    ,.baudrate(baudrate[15:0])

    ,.read_rx(read_rx) ,.rx_valid(rx_valid) ,.rxdata(rxdata[7:0])
    ,.tx_empty(tx_empty) ,.txdata(txdata[7:0]) ,.write_tx(write_tx)

    ,.control(control[7:0])
    ,.status()
);

wire read_rx2;
wire rx_valid2;
wire [7:0] rxdata2;

wire [7:0] txdata2;
wire write_tx2;
wire tx_empty2;

wire [15:0] baudrate2 = baudrate+1;
uartx2 dut1 (
     .clk(clk) ,.nreset(rst_n)
    ,.txd(rxd) ,.rxd(txd)
    ,.control(control[7:0])
    ,.baudrate(baudrate2)

    ,.read_rx(read_rx2)
    ,.rx_valid(rx_valid2)
    ,.rxdata(rxdata2[7:0])
    ,.tx_empty(tx_empty2)
    ,.txdata(txdata2[7:0])
    ,.write_tx(write_tx2)
    ,.status()
);

reg [7:0] [7:0] delay_line;
reg [7:0] valids;

assign write_tx2 = valids[7];
assign read_rx2 = rx_valid2;
assign txdata2 = delay_line[7];
wire panic = write_tx2 && !tx_empty2;

always @(posedge clk) begin
    delay_line[0] <= rxdata2;
    delay_line[1] <= delay_line[0];
    delay_line[2] <= delay_line[1];
    delay_line[3] <= delay_line[2];
    delay_line[4] <= delay_line[3];
    delay_line[5] <= delay_line[4];
    delay_line[6] <= delay_line[5];
    delay_line[7] <= delay_line[6];
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        valids <= 0;
    end else begin
        valids <= {valids[6:0],rx_valid2};
    end
end

always @(posedge read_rx) $display("RX CHAR %h",rxdata);


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

