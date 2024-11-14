

module syncfifo_shared_6 #(parameter WID=128, parameter DEPTH=8) (
     input clk, input rst_n, input softreset
    ,input [5:0] vldin
    ,input [5:0] [WID-1:0] din
    ,input [5:0] readout
    ,output [5:0] [WID-1:0] dout
    ,output [5:0] full
    ,output [5:0] empty
    ,output [15:0] count

);

reg [DEPTH-1:0]  [WID-1:0] bufs;

reg [DEPTH-1:0] occupied;
wire [31:0] mask =  ~((1<<DEPTH)-1);

wire [31:0] occupied0 = mask | occupied;

wire [5:0] index0,index1,index2,index3,index4,index5;

find_first_zero zero0 (.din(occupied0),.dout(index0));
wire [31:0] mask0 = {31'b0,vldin[0]} << index0 ;
wire [31:0] occupied1 = mask0 | occupied0;

find_first_zero zero1 (.din(occupied1),.dout(index1));
wire [31:0] mask1 = {31'b0,vldin[1]} << index1 ;
wire [31:0] occupied2 = mask1 | occupied1;

find_first_zero zero2 (.din(occupied2),.dout(index2));
wire [31:0] mask2 = {31'b0,vldin[2]} << index2 ;
wire [31:0] occupied3 = mask2 | occupied2;

find_first_zero zero3 (.din(occupied3),.dout(index3));
wire [31:0] mask3 = {31'b0,vldin[3]} << index3 ;
wire [31:0] occupied4 = mask3 | occupied3;

find_first_zero zero4 (.din(occupied4),.dout(index4));
wire [31:0] mask4 = {31'b0,vldin[4]} << index4 ;
wire [31:0] occupied5 = mask4 | occupied4;

find_first_zero zero5 (.din(occupied5),.dout(index5));





wire is_full = (count==8);
assign full = {6{is_full}};


localparam AWID = $clog2(DEPTH);
wire [5:0] [AWID-1:0] ptr;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        occupied <= 0;
    end else begin
        if (vldin[0] && !full[0])   occupied[index0] <= 1;
        if (vldin[1] && !full[1])   occupied[index1] <= 1;
        if (vldin[2] && !full[2])   occupied[index2] <= 1;
        if (vldin[3] && !full[3])   occupied[index3] <= 1;
        if (vldin[4] && !full[4])   occupied[index4] <= 1;
        if (vldin[5] && !full[5])   occupied[index5] <= 1;

        if (readout[0] && !empty[0]) occupied[ptr[0]] <= 0; 
        if (readout[1] && !empty[1]) occupied[ptr[1]] <= 0; 
        if (readout[2] && !empty[2]) occupied[ptr[2]] <= 0; 
        if (readout[3] && !empty[3]) occupied[ptr[3]] <= 0; 
        if (readout[4] && !empty[4]) occupied[ptr[4]] <= 0; 
        if (readout[5] && !empty[5]) occupied[ptr[5]] <= 0; 
    end
end

always @(posedge clk) begin
    if (vldin[0] && !full[0])   bufs[index0] <= din[0];
    if (vldin[1] && !full[1])   bufs[index1] <= din[1];
    if (vldin[2] && !full[2])   bufs[index2] <= din[2];
    if (vldin[3] && !full[3])   bufs[index3] <= din[3];
    if (vldin[4] && !full[4])   bufs[index4] <= din[4];
    if (vldin[5] && !full[5])   bufs[index5] <= din[5];
end 

wire [WID-1:0] din4 = din[4];
assign dout[0] = empty[0] ? 0 : bufs[ptr[0]];
assign dout[1] = empty[1] ? 0 : bufs[ptr[1]];
assign dout[2] = empty[2] ? 0 : bufs[ptr[2]];
assign dout[3] = empty[3] ? 0 : bufs[ptr[3]];
assign dout[4] = empty[4] ? 0 : bufs[ptr[4]];
assign dout[5] = empty[5] ? 0 : bufs[ptr[5]];

wire [WID-1:0] dbg0 = bufs[0];
wire [WID-1:0] dbg1 = bufs[1];
wire [WID-1:0] dbg2 = bufs[2];
wire [WID-1:0] dbg3 = bufs[3];
wire [WID-1:0] dbg4 = bufs[4];
wire [WID-1:0] dbg5 = bufs[5];



wire [5:0] int_full;

wire [15:0] count0,count1,count2,count3,count4,count5;
assign count = count0 + count1 + count2 + count3 + count4 + count5;

syncfifo #(AWID,DEPTH) ptr_0_fifo (.clk(clk),.rst_n(rst_n)
    ,.vldin(vldin[0] && !full[0]) ,.din(index0[AWID-1:0])
    ,.empty(empty[0]),.full(int_full[0])
    ,.readout(readout[0] && !empty[0])
    ,.dout(ptr[0])
    ,.softreset(softreset)
    ,.count(count0)
);

syncfifo #(AWID,DEPTH) ptr_1_fifo (.clk(clk),.rst_n(rst_n)
    ,.vldin(vldin[1] && !full[1]) ,.din(index1[AWID-1:0])
    ,.empty(empty[1]),.full(int_full[1])
    ,.readout(readout[1] && !empty[1])
    ,.dout(ptr[1])
    ,.softreset(softreset)
    ,.count(count1)
);

syncfifo #(AWID,DEPTH) ptr_2_fifo (.clk(clk),.rst_n(rst_n)
    ,.vldin(vldin[2] && !full[2]) ,.din(index2[AWID-1:0])
    ,.empty(empty[2]),.full(int_full[2])
    ,.readout(readout[2] && !empty[2])
    ,.dout(ptr[2])
    ,.softreset(softreset)
    ,.count(count2)
);

syncfifo #(AWID,DEPTH) ptr_3_fifo (.clk(clk),.rst_n(rst_n)
    ,.vldin(vldin[3] && !full[3]) ,.din(index3[AWID-1:0])
    ,.empty(empty[3]),.full(int_full[3])
    ,.readout(readout[3] && !empty[3])
    ,.dout(ptr[3])
    ,.softreset(softreset)
    ,.count(count3)
);

syncfifo #(AWID,DEPTH) ptr_4_fifo (.clk(clk),.rst_n(rst_n)
    ,.vldin(vldin[4] && !full[4]) ,.din(index4[AWID-1:0])
    ,.empty(empty[4]),.full(int_full[4])
    ,.readout(readout[4] && !empty[4])
    ,.dout(ptr[4])
    ,.softreset(softreset)
    ,.count(count4)
);

syncfifo #(AWID,DEPTH) ptr_5_fifo (.clk(clk),.rst_n(rst_n)
    ,.vldin(vldin[5] && !full[5]) ,.din(index5[AWID-1:0])
    ,.empty(empty[5]),.full(int_full[5])
    ,.readout(readout[5] && !empty[5])
    ,.dout(ptr[5])
    ,.softreset(softreset)
    ,.count(count5)
);



wire [63:0]  sign_version = 64'h00055bf817010624 ;
endmodule
// from /Users/iliagreenblat/vlsimine/newnoc/rtl/syncfifo_shared_6.v// from /Users/iliagreenblat/vlsimine/newnoc/rtl/syncfifo_shared_6.v
