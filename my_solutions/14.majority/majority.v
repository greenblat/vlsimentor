// two solutions presented
module majority (input [31:0] din, output [5:0] ones, output [5:0] zeroes);

// simplest solution
assign ones = $countones(din);
assign zeroes = 32-ones;

// classic  solution
reg [5:0] res;
integer ii;
always @(*) begin
    res = 0;
    for (ii=0;ii<32;ii=ii+1) res = res + din[ii];
end
assign ones = res;
endmodule


