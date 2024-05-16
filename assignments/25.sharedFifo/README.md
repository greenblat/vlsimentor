
# Shared fifo assignment

## The scenario
we need to implement 4 independent fifos. The problem is that their width is big. Let say 1024 bits per entry.
Suppose the depth of each fifo should be 8. 
Making four simple fifos will demand around 4*8*1024 flops.
We want to keep this number lower. So the idea is to let the four fifos share the entries flops.

## Header 

module syncfifo_shared_4 #(parameter WID=1024, parameter DEPTH=8, parameter ENTRIES=10) (
     input clk, input rst_n, input softreset
    ,input vldin[3:0], input [3:0] [WID-1:0] din
    ,input [3:0] readout, output [3:0] [WID-1:0] dout
    ,output [3:0] full
    ,output [3:0] empty
    ,output [15:0] count
);

- four "full" outputs are the same. They are asserted when the shared table is full.
- "count" output is the number of occupied entries in the shared table.
- "DEPTH" is indivdual fifos depth.
- "ENTRIES" is the number of entries in the shared table.

## Assignment
1. write RTL code for this design. It is ok to instance vanilla fifos inside.
2. make testbench and verify functionality of this design.

good luck.

