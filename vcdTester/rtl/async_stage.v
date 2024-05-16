`timescale 1ns / 1ps
module async_stage #(parameter WID=32)(
     input wclk
    ,input rst_nw
    ,input rclk
    ,input rst_nr
    ,input writex
    ,output wfull
    ,input [WID-1:0] wdata
    ,output reg  [WID-1:0] LVL_rdata
    ,output rempty
    ,input  readx
);
reg wtoken,rtoken;
wire wtoken_sync,rtoken_sync;
synchronizer_level syncr (.clk(rclk),.rst_n(rst_nr),.din(wtoken),.dout(wtoken_sync));
synchronizer_level syncw (.clk(wclk),.rst_n(rst_nw),.din(rtoken),.dout(rtoken_sync));
assign wfull  =  wtoken!=rtoken_sync;
assign rempty  =  wtoken_sync==rtoken;
always_ff @(posedge wclk or negedge rst_nw) begin
    if (!rst_nw) begin
        wtoken<=1'b0;
        LVL_rdata <= 1'b0;
    end else begin
        if (!wfull && writex) begin
            LVL_rdata <= wdata;
            wtoken <= !wtoken;
        end
    end
end
always_ff @(posedge rclk or negedge rst_nr) begin
    if (!rst_nr) begin
        rtoken<=1'b0;
    end else begin
        if (!rempty && readx) begin
            rtoken<=~rtoken;
        end
    end
end
wire [63:0]  sign_version = 64'h000127c111060323 ;
endmodule



