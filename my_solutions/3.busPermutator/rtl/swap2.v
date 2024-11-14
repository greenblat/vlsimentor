

module swap2 (input [2:0] aa, input [2:0]  bb, input sel,output [2:0]  oa, output [2:0]  ob);

assign oa = sel ? bb : aa;
assign ob = sel ? aa : bb;


endmodule
