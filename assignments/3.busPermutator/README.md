
* Bus permutator

** tricky**

| interface signals | meaning |
|-------|--------|
| **inputs** |  |
| din[7:0]   | data-in |
| select[XX:0]   | select permutation |
| **outputs** |  |
| dout[7:0] | 8 bits output word |


## Mission
    Combinatorial permutation of input bus to output bus. No clocks. Just assigns.
    select[XX:0] sets the permutation. 
    No two inputs may be routed to the same output. 

1. determine minimal value of XX (select bus width).
2. implement the design with XX being not super optimized, but correct design.
3. if XX is far from minimal, what can be done to reduce it?



## TB 

the testbench should be something like this (or take this):

`module testbench;`
`reg [7:0] din;`
`reg [XX:0] select;`
`wire [7:0] dout;`
`wire vldout;`

`always begin`
    `#10;`
    `select = $random;`
    `#10;`
`end`

`initial begin`
    `$dumpvars(0,tb);`
    `din = 0;`
`end`

`mydesign dut (.clk(cll),.rst_n(rst_n),.din(din),.dout(dout),.vldout(vldout));`
`endmodule`

`module mydesign (input [7:0] din, output [7:0] dout, input [XX:0] select);`
`// WRITE YOUR CODE HERE`
`endmodule`

