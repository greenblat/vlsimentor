

# serial to parallel 

**Simple** **assignment**


| interface signals | meaning |
|-------|--------|
| **inputs** |  |
| clk | clock |
| rst_n | negative active reset |
| din   | single bit   data-in |
| **outputs** |  |
| dout[7:0] | 8 bits output word |
| vldout | pulse: tells dout is valid |


## Mission
 from deactivation of reset, shift in the din into shift register and pulse valid every 8 bits.

## TB 

the testbench should be something like this (or take this):

`module testbench;`
`reg clk;`
`reg rst_n;`
`reg din;`
`wire [7:0] dout;`
`wire vldout;`

`always begin`
    `clk = 0;`
    `#10;`
    `clk = 1;`
    `#5;`
    `din = $random;`
    `#5;`
`end`

`initial begin`
    `$dumpvars(0,tb);`
    `rst_n = 0;`
    `#100;`
    `rst_n = 1;`
`end`

`mydesign dut (.clk(cll),.rst_n(rst_n),.din(din),.dout(dout),.vldout(vldout));`
`endmodule`

`module mydesign (input clk, input rst_n, input din, output [7:0] dout, output vldout);`
`// WRITE YOUR CODE HERE`
`endmodule`

