

def apb_slave(AWID,DWID):
    print('''
  ,input [15:0] paddr
  ,input       penable
  ,output [31:0] prdata
  ,output       pready
  ,input       psel
  ,output       pslverr
  ,input [31:0] pwdata
  ,input       pwrite

    ''')

def axi_wr_master(PREF,AWID,DWID,LWID,IDWID):
    print('''
    ,output [3:0] Pawid            
    ,output [31:0] Pawaddr
    ,output [7:0] Pawlen
    ,output [2:0] Pawsize
    ,output [1:0] Pawburst
    ,output [3:0] Pawcache
    ,output [3:0] Pawqos
    ,output [2:0] Pawprot
    ,output Pawvalid
    ,input Pawready
    ,output [DWID-1:0] Pwdata
    ,output [DWID/8-1:0] Pwstrb
    ,output Pwlast
    ,output Pwvalid
    ,input Pwready
    ,input [3:0] Pbid 
    ,input [1:0] Pbresp
    ,input Pbvalid
    ,output Pbready
    '''.replace('P',PREF))

def axi_rd_master(PREF,AWID,DWID,LWID,IDWID):
    print('''
    ,output [3:0] Parid
    ,output [31:0] Paraddr
    ,output [7:0] Parlen
    ,output [2:0] Parsize
    ,output [1:0] Parburst
    ,output [3:0] Parcache
    ,output [3:0] Parqos
    ,output [2:0] Parprot
    ,output Parvalid
    ,input Parready
    ,input [3:0] Prid 
    ,input [DWID-1:0] Prdata
    ,input [1:0] Prresp
    ,input Prlast
    ,input Prvalid
    ,output Prready
    '''.replace('P',PREF))

def axi_wr_slave(PREF='',AWID=32,DWID=64,LWID=8,IDWID=4):
    print('''
    ,input [3:0] Pawid            
    ,input [31:0] Pawaddr
    ,input [7:0] Pawlen
    ,input [2:0] Pawsize
    ,input [1:0] Pawburst
    ,input [3:0] Pawcache
    ,input [3:0] Pawqos
    ,input [2:0] Pawprot
    ,input Pawvalid
    ,output Pawready
    ,input [DWID-1:0] Pwdata
    ,input [DWID/8-1:0] Pwstrb
    ,input Pwlast
    ,input Pwvalid
    ,output Pwready
    ,output [3:0] Pbid 
    ,output [1:0] Pbresp
    ,output Pbvalid
    ,input Pbready
    '''.replace('P',PREF))

def axi_rd_slave(PREF='',AWID=32,DWID=64,LWID=8,IDWID=4):
    print('''
    ,input [3:0] Parid
    ,input [31:0] Paraddr
    ,input [7:0] Parlen
    ,input [2:0] Parsize
    ,input [1:0] Parburst
    ,input [3:0] Parcache
    ,input [3:0] Parqos
    ,input [2:0] Parprot
    ,input Parvalid
    ,output Parready
    ,output [3:0] Prid 
    ,output [DWID-1:0] Prdata
    ,output [1:0] Prresp
    ,output Prlast
    ,output Prvalid
    ,input Prready
    '''.replace('P',PREF))

def axi_slave(PREF='',AWID=32,DWID=64,LWID=8,IDWID=4):
    axi_wr_slave(PREF,AWID,DWID,LWID,IDWID)
    axi_rd_slave(PREF,AWID,DWID,LWID,IDWID)




def axi_master(PREF='',AWID=32,DWID=64,LWID=8,IDWID=4):
    axi_wr_master(PREF,AWID,DWID,LWID,IDWID)
    axi_rd_master(PREF,AWID,DWID,LWID,IDWID)

def axi_rd_conn():
    print('''
    ,arid(arid)
    ,araddr(araddr)
    ,arlen(arlen)
    ,arsize(arsize)
    ,arburst(arburst)
    ,arcache(arcache)
    ,arqos(arqos)
    ,arprot(arprot)
    ,arvalid(arvalid)
    ,arready(arready)
    ,rid(rid)
    ,rdata(rdata)
    ,rresp(rresp)
    ,rlast(rlast)
    ,rvalid(rvalid)
    ,rready(rready)
    ''')

def axi_wr_conn():
    print('''
    ,.awid(awid)
    ,.awaddr(awaddr)
    ,.awlen(awlen)
    ,.awsize(awsize)
    ,.awburst(awburst)
    ,.awcache(awcache)
    ,.awqos(awqos)
    ,.awprot(awprot)
    ,.awvalid(awvalid)
    ,.awready(awready)
    ,.wdata(wdata)
    ,.wstrb(wstrb)
    ,.wlast(wlast)
    ,.wvalid(wvalid)
    ,.wready(wready)
    ,.bid (bid )
    ,.bresp(bresp)
    ,.bvalid(bvalid)
    ,.bready(bready)
    ''')


def apb_conn():
    print('''
    ,.paddr(paddr)
    ,.penable(penable)
    ,.prdata(prdata)
    ,.pready(pready)
    ,.psel(psel)
    ,.pslverr(pslverr)
    ,.pwdata(pwdata)
    ,.pwrite(pwrite)

    ''')

def syncfifo(NAME='syncfifo'):
    print('''
syncfifo #(.WID(WID),.DEPTH(DEPTH)) NAME (
    .clk(clk),.rst_n(rst_n)
    ,.vldin(vldin)
    ,.din(din)
    ,.readout(readout)
    ,.empty(empty)
    ,.dout(dout)
    ,.full(full)
    ,.count(in_count)
);

    '''.replace('NAME',NAME))

# -*- encoding: UTF8 -*-
import os,sys,string

def include(Fname):
    lines = open(Fname).read()
    print(lines)
Strings={}
Strings['str0']='''
module rnd (input [7:0] sel, output reg [7:0] rndout);

always @* begin
    case (sel)
'''
Strings['str1']='''
        II : rndout = JJ;
'''
Strings['str2']='''
        default: rndout = 0;
    endcase
end
endmodule


'''


def argv(Ind):
    WW = sys.argv[1].split()
    if Ind<len(WW):
        return WW[Ind]
    return ''


def clog2(In):
    return len(bin(In))-2

Vars={}
import string
def formati(Var,Val):
    if len(Val)==0:
        return '<>1<>'
    if len(Var)==0:
        return '<>2<>'
    if Val[0] in '0123456789':
        if (len(Var)>1)and(Var[1] in '0123456789'):
            if Var[0]=='X':
                V1 = '%x'%int(Val)
            elif (Var[0]=='B'):
                V1 = bin(int(Val))
                V1 = V1[2:]
            elif (Var[0]=='D'):
                V1 = str(int(Val))
            else:
                return Val
            Wid = int(Var[1])
            while len(V1)<Wid:
                V1 = '0'+V1
            return V1                
    return Val


def evalStuff(Str):
    wrds = Str.split('<>')
    if len(wrds)<3: return Str
    Varsi = {}
    for Var in Vars:
        Val = Vars[Var]
        try:
            Varsi[Var]=int(Val)
        except:
            pass
    for II in range(1,len(wrds),2):
        try:
            New = eval(wrds[II],{},Varsi)
            wrds[II] = str(New)
        except:
            try:
                exec("NxiX = %s"%wrds[II])
                wrds[II] = str(NxiX)
            except:
                print('// failed eval of "%s"'%(wrds[II]))
    Str2 = ''.join(wrds)
    return Str2


def print_Strings(Str):
    X = Strings[Str][:]
    X = evalStuff(X)



    if X[0]=='\n':
        X = X[1:]
    res=[]
    for Var in Vars:
        res.append((len(Var),Var,Vars[Var]))
    res.sort()
    res.reverse()
    for _,Var,Val in res:
        X = X.replace(Var,formati(Var,Val))
    print(X[:-1])
        


import random
print_Strings('str0')
for II in range(256):
    Vars["II"]=str(II)
    JJ = random.randint(0,256)
    Vars["JJ"]=str(JJ)
    print_Strings('str1')
print_Strings('str2')
