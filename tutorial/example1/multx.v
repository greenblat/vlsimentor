
module multx (input clk, input rst_n, input vldin, output vldout, input [31:0] aa, input [31:0] bb, output reg [63:0] out);


reg [31:0] mid1,mid2,mid3,mid4;

reg [2:0] vlds;
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        vlds <= 0;
     end else begin
        vlds <= {vlds[1:0],vldin};
     end
end
assign vldout = vlds[1];

always @(posedge clk) begin
    mid1 <= aa[15:0] * bb[15:0];
end

always @(posedge clk) begin
    mid2 <= aa[15:0] * bb[31:16];
end

always @(posedge clk) begin
    mid3 <= aa[31:16] * bb[15:0];
end

always @(posedge clk) begin
    mid4 <= aa[31:16] * bb[31:16];
end


always @(posedge clk) begin
    out <= mid1 + {mid2,16'b0} + {mid3,16'b0} + {mid4,32'b0};
end

endmodule

