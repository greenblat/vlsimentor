

`timescale 1ns/1ps


module round_robin_4z (
     input clk, input rst_n
    ,input accepted
    ,input [3:0] requests
    ,output [3:0] grants
);

reg [1:0] ptr;


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
                ptr <= (ptr==3) ? 0 : (ptr + 1);
            end
        end else if (state == 2) begin
            if (accepted( begin
                state <= 0;
                ptr <= (ptr==3) ? 0 : (ptr + 1);
            end
        end
    end
end

assign grants = (state==2) ? (1<<ptr) : 0;


endmodule


