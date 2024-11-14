

`timescale 1ns/1ps


module round_robin #(parameter WID=16) (
     input clk, input rst_n
    ,input [WID-1:0] requests
    ,output [WID-1:0] grants
);

localparam WADDR = $clog2(WID);
reg [WADDR-1:0] ptr;


wire have_requests = requests!=0;

reg [1:0] state;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        ptr <= 0;
        state <= 0;
    end else begin
        if (state==0) begin
            if (have_requests) begin
                state <= 1;
            end
        end else if (state == 1) begin
            if (requests[ptr]) begin
               state <= 2; 
            end else begin
                ptr <= (ptr==(WID-1)) ? 0 : (ptr + 1);
            end
        end else if (state == 2) begin
            state <= 0;
            ptr <= (ptr==(WID-1)) ? 0 : (ptr + 1);
        end
    end
end

assign grants = (state==2) ? (1<<ptr) : 0;


endmodule


