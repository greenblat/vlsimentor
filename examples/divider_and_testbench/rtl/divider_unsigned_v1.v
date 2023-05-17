
`timescale 1ns/1ps

module divider_unsigned_v1 #(parameter WID0=32, parameter WID1=16) (
    input clk,
    input rst_n,
    input [WID0-1:0] arg0,
    input [WID1-1:0] arg1,
    input vldin,
    output busy,
    output vldout,
    output reg [WID0-1:0] result,
    output [WID1-1:0] remainder
);

reg busy_reg;
assign busy = busy_reg;
reg [WID0-1:0] middle;
assign remainder = middle[WID1-1:0];
reg [WID1-1:0] arg1hold;
wire [4:0] first_one_a = find_first_one(32'b0|middle);
wire [4:0] first_one_b = find_first_one(32'b0|arg1hold);
wire [4:0] initial_shift = first_one_a -first_one_b;
wire [4:0] initial_shift1 = initial_shift-1;
reg [WID0-1:0] shifted;

always @(posedge clk) begin
    shifted <= (arg1hold << initial_shift);
end

wire [WID0-1:0] half = {1'b0,shifted[WID0-1:1]};
wire [WID0-1:0] quarter = {2'b0,shifted[WID0-1:2]};
wire [WID0-1:0] eights = {3'b0,shifted[WID0-1:3]};

wire half_ok = initial_shift!=5'b0;
wire quarter_ok = initial_shift>5'd1;
wire eights_ok = initial_shift>5'd2;

wire taken0 = (middle>=shifted);
wire [WID0-1:0]  temp0 = taken0 ? middle-shifted : middle;
wire taken1 = (temp0>=half)&&half_ok;
wire [WID0-1:0]  temp1 = taken1 ? temp0-half : temp0;
reg pipeline_on;

wire simples_wire = vldin && ((arg0==0)||(arg1==0)||(arg1==1) || (arg1>arg0));
reg simples; always @(posedge clk) simples<=simples_wire;
assign vldout = (busy_reg && (middle<arg1hold)) ||simples;
always @(posedge clk) begin
    if (!rst_n) begin
        result <= 0;
        busy_reg <= 1'b0;
        pipeline_on <= 1'b0;
        middle <= 0;
        arg1hold <= 0;
    end else begin
        if (vldin && !busy_reg) begin
            if ((arg0==0)||(arg1==0)) begin
                result <= 0;
                middle <= 0;
            end else if (arg1>arg0) begin
                result <= 0;
                middle <= arg0;
            end else if (arg1==arg0) begin
                result <= 1;
                middle <= 0;
            end else if (arg1==1) begin
                result <= arg0;
                middle <= 0;
            end else begin
                middle <= arg0;
                busy_reg <= 1'b1;
                pipeline_on <= 1'b1;
                result <= 0;
                arg1hold <= arg1;
            end
        end else if (busy_reg) begin
            if (middle<arg1hold) begin
                busy_reg <= 1'b0;
            end else if (!pipeline_on) begin
                pipeline_on <= 1'b1;
                middle <= temp1;
                if (taken0)
                    result[initial_shift] <= 1'b1;
                if ((initial_shift>0)&&taken1) begin
                    result[initial_shift1] <= 1'b1;
                end
            end else pipeline_on <= 1'b0;
        end
    end
end

function [4:0] find_first_one ( input [31:0] data);
reg z31_28,z27_24,z23_20,z19_16,z15_12;
reg z11_8,z7_4,z3_0;
reg [4:0] res;
reg [3:0] mid;
reg [1:0] bits;
begin
    z31_28 = (data[31:28]==4'b0);
    z27_24 = (data[27:24]==4'b0);
    z23_20 = (data[23:20]==4'b0);
    z19_16 = (data[19:16]==4'b0);
    z15_12 = (data[15:12]==4'b0);
    z11_8 = (data[11:8]==4'b0);
    z7_4 = (data[7:4]==4'b0);
    z3_0 = (data[3:0]==4'b0);

    mid = 
        (!z31_28) ? data[31:28] : 
        (!z27_24) ? data[27:24] : 
        (!z23_20) ? data[23:20] : 
        (!z19_16) ? data[19:16] : 
        (!z15_12) ? data[15:12] : 
        (!z11_8) ? data[11:8] : 
        (!z7_4) ? data[7:4] : 
        (!z3_0) ? data[3:0] : 4'b0;
    bits = 
        mid[3] ? 2'b11 : 
        mid[2] ? 2'b10 : 
        mid[1] ? 2'b01 : 2'b00;

    res = 
        (!z31_28) ? { 3'b111,bits}: 
        (!z27_24) ? { 3'b110,bits}: 
        (!z23_20) ? { 3'b101,bits}: 
        (!z19_16) ? { 3'b100,bits}:
        (!z15_12) ? { 3'b011,bits}:
        (!z11_8) ? { 3'b010,bits}:
        (!z7_4) ? { 3'b001,bits}:
        (!z3_0) ? { 3'b000,bits}: 5'b0;
    

    find_first_one = res;
end
endfunction


endmodule





