
// helper = how i envision the module starter.

module pattern #(parameter LEN=128, parameter HEADER=12'b010011000111, parameter HEADLEN=12) (
    input clk, input rst_n
    ,input din
    ,output reg synced
    ,output reg framevld
    ,output reg [115:0] payload
);

reg [2*LEN-1:0] shiftreg;
always @(posedge clk) begin
    shiftreg <= {shiftreg[2*LEN-2:0],din};
end

// more code from You

endmodule

