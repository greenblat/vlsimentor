

module solution1 (input [7:0][3:0] din, input [16:0] select, output [7:0] [3:0] dout);

wire [6:0] [3:0] stage7;
wire [5:0] [3:0] stage6;
wire [4:0] [3:0] stage5;
wire [3:0] [3:0] stage4;
wire [2:0] [3:0] stage3;
wire [1:0] [3:0] stage2;
wire  [3:0] stage1;
wire [6:0] panic;
select1 #(8) sel0 (.din(din),.dout(stage7),.one(dout[0]),.select(select[2:0]),.panic(panic[0]));
select1 #(7) sel1 (.din(stage7),.dout(stage6),.one(dout[1]),.select(select[5:3]),.panic(panic[1]));
select1 #(6) sel2 (.din(stage6),.dout(stage5),.one(dout[2]),.select(select[8:6]),.panic(panic[2]));
select1 #(5) sel3 (.din(stage5),.dout(stage4),.one(dout[3]),.select(select[11:9]),.panic(panic[3]));
select1 #(4) sel4 (.din(stage4),.dout(stage3),.one(dout[4]),.select(select[13:12]),.panic(panic[4]));
select1 #(3) sel5 (.din(stage3),.dout(stage2),.one(dout[5]),.select(select[15:14]),.panic(panic[5]));
select1 #(2) sel6 (.din(stage2),.dout(stage1),.one(dout[6]),.select(select[16]),.panic(panic[6]));

assign dout[7] = stage1;
    
// always  @(din) $display("%h",dout);

endmodule


module select1 #(parameter ARRWID = 8) (input [ARRWID-1:0][3:0] din,input [2:0] select
    , output [3:0] one, output reg [ARRWID-2:0][3:0] dout
    , output panic
);

assign panic = select >= ARRWID;

assign one =  din[select];
integer II;

always @* begin
    for (II=0;II<ARRWID;II=II+1) begin
        if (II<select) begin
//            $display("IIless sel=%d %d -> %d %d" ,select,II,dout[II], din[II]); 
            dout[II] = din[II];
        end else if (II>=select) begin
//            $display("sel=%d II=%d  -> %d %d", select,II,din[II+1],dout[II]);
            dout[II] = din[II+1];
        end
    end
//    $display("%m %h  %d" , dout,II);
end
endmodule

