

// skeleton 


module reordering_syncfifo #(parameter WID = 32, parameter DEPTH=8, parameter AWID = $clog2(DEPTH))(
     input clk,input rst_n, input softreset
    ,input vldin, input [WID-1:0] din, input [AWID:0] order, output ok_to_write
    ,input readout, output [WID-1:0] dout, output ok_to_read
    ,output [15:0] count
);





endmodule
