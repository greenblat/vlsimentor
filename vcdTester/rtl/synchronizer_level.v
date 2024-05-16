
`timescale 1ns / 1ps

module synchronizer_level #(parameter WID=1) (
    input clk, input [WID-1:0] din, input rst_n,output [WID-1:0] dout
);

reg [WID-1:0] SYNCFLOP0,SYNCFLOP1;
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        SYNCFLOP0 <= 1'b0;
        SYNCFLOP1 <= 1'b0;
    end else begin
        SYNCFLOP0 <= din;
        SYNCFLOP1 <= SYNCFLOP0;
    end
end
assign dout = SYNCFLOP1;


wire [63:0]  sign_version = 64'h00006ebd11060323 ;
endmodule

