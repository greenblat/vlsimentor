
* Bus permutator

** tricky**

| interface signals | meaning |
|-------|--------|
| **inputs** |  |
| din[7:0][2:0]   | data-in |
| select[XX:0]   | select permutation |
| **outputs** |  |
| dout[7:0][2:0] | 8 bits output word |


## Mission
    Combinatorial permutation of input bus to output bus. No clocks. Just assigns.
    select[XX:0] sets the permutation. 
    No two input busses may be routed to the same output. 

![image-20240205193656807](/Users/iliagreenblat/Library/Application Support/typora-user-images/image-20240205193656807.png)

1. determine minimal value of XX (select bus width).
2. implement the design with XX being not super optimized, but correct design.
3. if XX is far from minimal, what can be done to reduce it?
4. HINT: to check solution, assign din = {3'd7,3'd6,3'd5,3'd4,3'd3,3'd2,3'd1,3'd0};


## TB 

the testbench should be something like this (or take this):
("X" is Yours to set) (for easier debug, din and dout are 8 fields of 4 bits each)

`module testbench;`
`reg [7:0][3:0] din;`
`reg [XX:0] select;`
`wire [7:0][3:0] dout;`
`wire vldout;`

`always begin`
    `#10;`
    `select = $random;`
    `#10;`
`end`

`initial begin`
    `$dumpvars(0,tb);`
    `din = {4'd7,4'd6'4'd5,4'd4,4'd3,4'd2,4'd1,4'd0};`
`end`

`mydesign dut (.clk(cll),.rst_n(rst_n),.din(din),.dout(dout),.vldout(vldout));`
`endmodule`

`module mydesign (input [7:0][3:0] din, output [7:0][3:0] dout, input [XX:0] select);`
`// WRITE YOUR CODE HERE`
`// "X" value is your responsibility`
`endmodule`

