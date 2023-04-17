

# Parity 

**Simple** **assignment**


| interface signals | meaning |
|-------|--------|
| **inputs** |  |
| clk | clock |
| rst_n | negative active reset |
| din[31:0]   | data-in |
| **outputs** |  |
| dout[31:0] | 32 bits output word |
| parity[3:0 | four parity bits, bit per byte |


## Mission
 from deactivation of reset,  on each clock, sample the inputs to outputs and generate 4 parity bits

## TB 

the testbench should be something like this (or take this):

`module testbench;
reg clk;
reg rst_n;
reg [31:0] din;
wire [31:0] dout;
wire [3:0] parity;`

`always begin
    clk = 0;
    #10;
    clk = 1;
    #5;
    din = $random;
    #5;
end`

`initial begin
    $dumpvars(0,tb);
    rst_n = 0;
    #100;
    rst_n = 1;
end`

`mydesign dut (.clk(cll),.rst_n(rst_n),.din(din),.dout(dout),.parity(parity));
endmodule
module mydesign.......
// WRITE YOUR CODE HERE
endmodule`


