
`timescale 1ns / 1ps
module async2fifo #(parameter WID=32)(
     input wclk
    ,input rst_nw
    ,input rclk
    ,input rst_nr
    ,input writex
    ,output wfull
    ,input [WID-1:0] wdata
    ,output [WID-1:0] rdata
    ,output rempty
    ,input  readx
);

wire [WID-1:0] rdata0;
wire wfull0,rempty0;
wire [WID-1:0] rdata1;
wire wfull1,rempty1;


reg wptr;
always_ff @(posedge wclk or negedge rst_nw) begin
    if (!rst_nw) begin
        wptr<=0;
    end else if (writex && !wfull) begin
        wptr<=wptr+1'b1;
    end
end

assign wfull = ((wptr==0)&&wfull0) ||((wptr==1)&&wfull1) ;
wire writex0 = writex && (wptr==0)&&!wfull0;
wire writex1 = writex && (wptr==1)&&!wfull1;

reg rptr;
always_ff @(posedge rclk or negedge rst_nr) begin
    if (!rst_nr) begin
        rptr<=0;
    end else if (readx && !rempty) begin
        rptr<=rptr+1'd1;
    end
end

assign rdata =
    (rptr== 0) ? rdata0 :
    (rptr== 1) ? rdata1 :
     2'd0;

assign rempty =
    (rptr== 0) ? rempty0 :
    (rptr== 1) ? rempty1 :
     2'd0;

wire readx0 = readx && (rptr== 0);
wire readx1 = readx && (rptr== 1);


async_stage #(WID) stage0 (
     .rclk(rclk) ,.rst_nr(rst_nr)
    ,.wclk(wclk) ,.rst_nw(rst_nw)
    ,.LVL_rdata(rdata0) ,.readx(readx0) ,.rempty(rempty0)
    ,.wdata(wdata) ,.wfull(wfull0) ,.writex(writex0)
);
async_stage #(WID) stage1 (
     .rclk(rclk) ,.rst_nr(rst_nr)
    ,.wclk(wclk) ,.rst_nw(rst_nw)
    ,.LVL_rdata(rdata1) ,.readx(readx1) ,.rempty(rempty1)
    ,.wdata(wdata) ,.wfull(wfull1) ,.writex(writex1)
);


wire [63:0]  sign_version = 64'h0001a5af23220623 ;
endmodule



