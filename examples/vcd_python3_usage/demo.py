import os,sys
import veri

New = os.path.expanduser('~/vlsistuff/verification_libs3')
sys.path.append(New)
import logs

def conclusions():
    logs.closeLogs()

BASE = 'tb'
CLK = BASE + '.clk'

def peekbin(Sig,Base=BASE):
    X = veri.peek('%s.%s'%(Base,Sig))
    return X

def peek(Sig,Base=BASE):
    return logs.intx(peekbin(Sig,Base))


def valid(Sig,Base=BASE):
    X = peekbin(Sig,Base)
    return X=='1'

LASTTIME = 10000000

def negedge():
    if veri.stime()>LASTTIME:
        logs.closeLogs()
        veri.finish()
        sys.exit()
    work()

veri.sensitive(CLK,'0','negedge()','0')
# -> when CLK path goes down (or 1 for up) :: veri.sensitive(CLK,'0','negedge()')
# -> start time. period  :: veri.sensitive('100,'10','negedge()')
# -> on every time change :: veri.sensitive('always','0','negedge()')

reading = -1
def work():
    global reading
    if valid('penable') and valid('psel') and reading>=0:
        reading = -1
        prdata = peek('prdata')
        logs.log_info(f'apb read addr={paddr} rdata={prdata}')
    if valid('psel') and valid('pready'):
        paddr = peek('paddr')
        if valid('pwrite'):
            wdata = peek('pwdata')
            logs.log_info(f'apb write addr={paddr} wdata={wdata}')
        else:
            reading = paddr
#    -toggles  -start <TIME> -end <TIME>


