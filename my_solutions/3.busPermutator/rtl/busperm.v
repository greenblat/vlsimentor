

module busperm ( input [7:0] [2:0]  din, output [7:0] [2:0]  dout, input [15:0] control);

wire [7:0] [2:0] sw0,sw1,sw2,sw3;
swap2 swap0 (.aa(din[0]),.bb(din[1]),.sel(control[0]),.oa(sw0[0]),.ob(sw0[1]) );
swap2 swap1 (.aa(din[2]),.bb(din[3]),.sel(control[1]),.oa(sw0[2]),.ob(sw0[3]) );
swap2 swap2 (.aa(din[4]),.bb(din[5]),.sel(control[2]),.oa(sw0[4]),.ob(sw0[5]) );
swap2 swap3 (.aa(din[6]),.bb(din[7]),.sel(control[3]),.oa(sw0[6]),.ob(sw0[7]) );


swap2 swap4 (.aa(sw0[0]),.bb(sw0[2]),.sel(control[4]),.oa(sw1[0]),.ob(sw1[1]) );
swap2 swap5 (.aa(sw0[1]),.bb(sw0[3]),.sel(control[5]),.oa(sw1[2]),.ob(sw1[3]) );
swap2 swap6 (.aa(sw0[4]),.bb(sw0[6]),.sel(control[6]),.oa(sw1[4]),.ob(sw1[5]) );
swap2 swap7 (.aa(sw0[5]),.bb(sw0[7]),.sel(control[7]),.oa(sw1[6]),.ob(sw1[7]) );

swap2 swap8 (.aa(sw1[0]),.bb(sw1[1]),.sel(control[8]),.oa(sw2[0]),.ob(sw2[1]) );
swap2 swap9 (.aa(sw1[2]),.bb(sw1[4]),.sel(control[9]),.oa(sw2[2]),.ob(sw2[3]) );
swap2 swap10 (.aa(sw1[4]),.bb(sw1[5]),.sel(control[10]),.oa(sw2[4]),.ob(sw2[5]) );
swap2 swap11 (.aa(sw1[6]),.bb(sw1[7]),.sel(control[11]),.oa(sw2[6]),.ob(sw2[7]) );

swap2 swap12 (.aa(sw2[0]),.bb(sw2[2]),.sel(control[12]),.oa(sw3[0]),.ob(sw3[1]) );
swap2 swap13 (.aa(sw2[1]),.bb(sw2[3]),.sel(control[13]),.oa(sw3[2]),.ob(sw3[3]) );
swap2 swap14 (.aa(sw2[4]),.bb(sw2[6]),.sel(control[14]),.oa(sw3[4]),.ob(sw3[5]) );
swap2 swap15 (.aa(sw2[5]),.bb(sw2[7]),.sel(control[15]),.oa(sw3[6]),.ob(sw3[7]) );


assign dout = sw3;

endmodule

