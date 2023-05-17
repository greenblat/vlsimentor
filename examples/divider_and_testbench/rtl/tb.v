`timescale 1ns/1ps             // timescale is kind of prayer, like "BASAD" 
`define VERIFICATION_VERILOG             // here we present only regular verilog verification.
// `define VERIFICATION_PYTHON
module tb;


integer    cycles;   initial cycles=0;     // cycles count clocks.
integer    wrongs;   initial wrongs=0;     // wrongs count bad comparisons between golden model and rtl results.
integer    corrects; initial corrects=0;   // corrects count good comparisons.

`ifdef VERIFICATION_PYTHON
reg [31:0] marker;   initial marker=0;
reg [31:0] marker0;   initial marker0=0;
reg [31:0] marker1;   initial marker1=0;
reg [31:0] marker2;   initial marker2=0;
reg [31:0] marker3;   initial marker3=0;
reg [31:0] Index;   initial Index=0;
reg [31:0] ID;   initial ID=0;
`endif


parameter WID0 = 32;
parameter WID1 = 16;
reg [(WID0 - 1):0] arg0;     // args are inputs to the devider.
reg [(WID1 - 1):0] arg1;
reg  clk;                    // "system" clock.

wire  busy;                  // output that  signifies : dont load new job.
// this divider is "run-to_completion" and not "fully-pipeline).
wire [(WID1 - 1):0] remainder;    // output of divider
wire [(WID0 - 1):0] result;    // output of divider
reg  rst_n;        // global async reset for ASIC. in FPGA, reset better be synchronous. In both cases it is active low.
reg  vldin;        // trigger to start computation.
wire  vldout;       // output to signal results ready.

// typical clock generator
always begin
    clk=0;
    #10;       // keep zero for 10 ns.
    clk=1;
    #3;
`ifdef VERIFICATION_PYTHON
    $python("negedge()");
`endif
    #7;
end
initial begin    // set value of regs at the beginnig of simulation.
    $dumpvars(0,tb);   // keep waves file in VCD format. can be displayed by GTLWAVE free wave viewer. (or dinotrace) (or commercials).
    rst_n = 0;
    arg0 = 0;
    arg1 = 0;
    clk = 0;
    rst_n = 0;
    vldin = 0;
    #100;
    rst_n=1;   // after 100 ns, release reset.
end
// instance of the divider.  the module is divider_unsigned_v1, the instance name is "dut". 
divider_unsigned_v1 dut (
     .clk(clk) ,.rst_n(rst_n)

    ,.vldin(vldin)
    ,.arg0(arg0[(WID0 - 1):0])    // the bus arg0 is connected to pin arg0. pin is input, thus "reg" can drive it.
    ,.arg1(arg1[(WID1 - 1):0])

    ,.vldout(vldout)
    ,.busy(busy)                  // outputs (busy as example) drive "wire".
    ,.remainder(remainder[(WID1 - 1):0])
    ,.result(result[(WID0 - 1):0])
);

`ifdef VERIFICATION_PYTHON

// read it only after undersanding pytho driven verification. skip to endif.
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
`endif

`ifdef VERIFICATION_VERILOG
reg [7:0] state = 0;            // this also gives value to reg at time zero. 
integer Exp0,Exp1;               // integer is like "reg" of 32 bits wide.
always @(posedge clk) if (rst_n) begin    // start exersizing after reset.

    #2; // wait a bit, so changes are clearly visible after clock rise (2ns after).
    if (state == 0) begin
        arg0 <= $random;              // give random value to arg0
        arg1 <= $random & 32'hffff;              // give random value to arg1, but limit it to 16bits.
        vldin <= 1;
        state <= 1;
        cycles <= cycles + 1;
    end else if (state == 1) begin
        vldin <= 0;
        state <= 2;
    end else if (state == 2) begin
        if (vldout) begin
            state <= 0;
            Exp0 = arg0 /arg1;
            Exp1 = arg0 % arg1;
            if ((Exp0==result)&&(Exp1 == remainder)) begin
                corrects <= corrects + 1;
                $display("CORRECT corr=%d wrongs=%d  in= %d / %d    outputs exp=%d %d    actual= %d %d",
                    corrects,wrongs,arg0,arg1,Exp0,Exp1,result,remainder);
            end else begin
                wrongs <= wrongs + 1;
                $display("WRONG corr=%d wrongs=%d  %d / %d exp=%d %d actual= %d %d",
                    corrects,wrongs,arg0,arg1,Exp0,Exp1,result,remainder);
            end
        end else begin
            if ((wrongs>1000)||(cycles>10000)) $finish;
        end
    end
end

`endif
endmodule

