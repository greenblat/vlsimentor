

module cordic_sqrt (
     input clk, input rst_n
    ,input [31:0] din         // number to compute sqrt off  (theta in C)
    ,input start            // start computing
    ,output [15:0] dout         // resulting square root  (s in C)
    ,output ready              // answer ready          
    ,output busy            // in the middle of work, start is disregarded at the duration
    ,input [4:0] iterations // optional: number of iterations. if writing without, just use 32.
);

// Your code


endmodule
