
module fp_multiplier ( input [31:0] ain,input [31:0] bin, output [31:0] out);

wire [31:0] ZERO = 32'b0;
wire [31:0] NEGZERO = 32'h80000000;
wire zeroes = (ZERO==ain)||(ZERO==bin)||(NEGZERO==ain)||(NEGZERO==bin);

// Your code here

assign out = zeroes ? ZERO : {z_sign,z_exp,z_mat};
endmodule
