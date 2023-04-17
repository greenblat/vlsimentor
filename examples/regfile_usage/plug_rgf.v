
`timescale 1ns / 1ps
module plug_rgf (input pclk, input presetn,
    input psel, input penable, input pwrite, input [4-1:0] pstrb, input [20-1:0] paddr, input [32-1:0] pwdata, output [32-1:0] prdata,output [32-1:0] prdata_wire
    ,output pready, output pslverr
    ,output [71:0] control
    ,input [31:0] status
    ,output [5:0] rate
    ,output  dsc
    ,output [3:0] bdd
);
    wire [10:0] control2; // hhh

wire i_pread = psel && !pwrite;
wire i_pwrite = psel && pwrite && penable;
assign pslverr = 0;
assign pready = 1;
wire [31:0] last_wdata;

wire [1023:0] ZEROES = 1024'b0;
plug_rgf_ram rgf (.pclk(pclk),.presetn(presetn),.pwrite(i_pwrite),.pread(i_pread),.paddr(paddr)
    ,.pwdata(pwdata),.prdata(prdata),.prdata_wire(prdata_wire)
    ,.pstrb(pstrb),.last_wdata(last_wdata)
    ,.penable(penable)
    ,.control(control)
    ,.status(status)
    ,.control2(control2)
);
assign rate = control2[5:0];
assign dsc = control2[6];
assign bdd = control2[10:7];
endmodule
`timescale 1ns / 1ps
module plug_rgf_ram (
    input pclk,input presetn,input pwrite, input pread, input penable
    ,input [32-1:0] pwdata, output [32-1:0] prdata, output [32-1:0] prdata_wire
    ,input [4-1:0] pstrb
    ,input [20-1:0] paddr ,output reg [32-1:0] last_wdata
    ,output pready
    ,output reg [71:0] control
    ,input [31:0] status
    ,output reg [10:0] control2
);
wire [32-1:0] wdata = pwdata;

wire [20-1:0] mpaddr0 =  20'hffffc & (paddr - 'h0);
wire [20-1:0] mpaddr = (pread||pwrite) ? mpaddr0  : 0;
assign prdata_wire =

    (mpaddr == 'h0) ? control[31:0] :
    (mpaddr == 'h4) ? control[63:32] :
    (mpaddr == 'h8) ? {24'b0,control[71:64]} :
    (mpaddr == 'hc) ? status[31:0] :
    (mpaddr == 'h10) ? {21'b0,control2} :
    32'hdeadbeaf;



reg [32-1:0] prdata_reg;
always @(posedge pclk) prdata_reg <=  prdata_wire;
assign pready = 1;

assign prdata =   
    prdata_reg;

wire [32-1:0] mask = { {{8{pstrb[3]}},{8{pstrb[2]}},{8{pstrb[1]}},{8{pstrb[0]}}} };
always @(posedge pclk) if (pwrite) last_wdata <= wdata & mask;
always @(posedge pclk or negedge presetn) begin
    if (!presetn) begin 
        control <= 72'h0;
        control2 <= 11'h0;
    end else if (pwrite)  begin
        if (mpaddr == 'h0) control[31:0] <= (control[31:0] & ~mask) | (wdata & mask);
        if (mpaddr == 'h4) control[63:32] <= (control[63:32] & ~mask) | (wdata & mask);
        if (mpaddr == 'h8) control[71:64] <= (control[71:64] & ~mask) | (wdata & mask);
        if (mpaddr == 'h10) control2 <= (control2 & ~mask[10:0]) | (wdata[10:0] & mask[10:0]);
    end
end
endmodule
