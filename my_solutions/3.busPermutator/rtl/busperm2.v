

module busperm2 ( input [7:0] [3:0]  din, output [7:0] [3:0]  dout, input [15:0] control);

wire [7:0] [3:0] sw0,sw1,sw2,sw3;

assign sw0[0] = control[0] ? din[4] : din[0];
assign sw0[1] = control[1] ? din[5] : din[1];
assign sw0[2] = control[2] ? din[6] : din[2];
assign sw0[3] = control[3] ? din[7] : din[3];

assign sw0[4] = control[0] ? din[0] : din[4];
assign sw0[5] = control[1] ? din[1] : din[5];
assign sw0[6] = control[2] ? din[2] : din[6];
assign sw0[7] = control[3] ? din[3] : din[7];

assign sw1[0] = control[4] ? sw0[2] : sw0[0];
assign sw1[1] = control[5] ? sw0[3] : sw0[1];
assign sw1[2] = control[4] ? sw0[0] : sw0[2];
assign sw1[3] = control[5] ? sw0[1] : sw0[3];

assign sw1[4] = control[6] ? sw0[4] : sw0[6];
assign sw1[5] = control[7] ? sw0[5] : sw0[7];
assign sw1[6] = control[4] ? sw0[6] : sw0[4];
assign sw1[7] = control[7] ? sw0[7] : sw0[5];

assign sw2[0] = control[8] ? sw1[1] : sw1[0];
assign sw2[1] = control[8] ? sw1[0] : sw1[1];
assign sw2[2] = control[9] ? sw1[3] : sw1[2];
assign sw2[3] = control[9] ? sw1[2] : sw1[3];

assign sw2[4] = control[10] ? sw1[5] : sw1[4];
assign sw2[5] = control[10] ? sw1[4] : sw1[5];
assign sw2[6] = control[11] ? sw1[7] : sw1[6];
assign sw2[7] = control[11] ? sw1[6] : sw1[7];

assign dout = sw2;

endmodule

