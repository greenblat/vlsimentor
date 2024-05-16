
import os,sys
import veri

SIGS = '''
     wclk
     rst_nw
     rclk
     rst_nr
     writex
     wdata
     readx
'''.split()



New = os.path.expanduser('~/vlsistuff/verification_libs3')
sys.path.append(New)
import logs

def conclusions():
    Fout.write('end\n')
    Fout.close()
    logs.closeLogs()

BASE = 'tb.dut'
CLK = BASE + '.clk'

def peekbin(Sig,Base=BASE):
    X = veri.peek('%s.%s'%(Base,Sig))
    return X

def peek(Sig,Base=BASE):
    Bin = peekbin(Sig,Base)
    WIDS[Sig] = len(Bin)
    return logs.intx(Bin)


def valid(Sig,Base=BASE):
    X = peekbin(Sig,Base)
    return X=='1'

wasTime = 0
def timeDiff():
    global wasTime
    Now = veri.stime()
    Diff = Now-wasTime
    wasTime = Now
    return Diff

Fout = open('tester.include','w')
Fout.write('integer cycle = 0;\n')
Fout.write('initial begin\n')
cycles = 0
def rposedge():
    global cycles
    Diff = timeDiff()
    Fout.write('    #%d;\n' % Diff)
    Fout.write('     rclk = 1;\n')
    Fout.write('     cycle = %d;\n' % cycles)
    cycles += 1

def wposedge():
    global cycles
    Diff = timeDiff()
    Fout.write('    #%d;\n' % Diff)
    Fout.write('     wclk = 1;\n')
    Fout.write('     cycle = %d;\n' % cycles)
    cycles += 1

VALUES = {}
WIDS = {}
for Sig in SIGS: VALUES[Sig] = "x"

def wnegedge():
    Diff = timeDiff()
    Fout.write('    #%d;\n' % Diff)
    Fout.write('     wclk = 0;\n')
    for Sig in SIGS:
        Now = peek(Sig)
        Was = VALUES[Sig]
        if Was != Now:
            Fout.write('     %s = %s%s;\n' % (Sig,WIDS[Sig],verilogvalue(Now)))
            VALUES[Sig] = Now
def rnegedge():
    Diff = timeDiff()
    Fout.write('    #%d;\n' % Diff)
    Fout.write('     rclk = 0;\n')
    for Sig in SIGS:
        Now = peek(Sig)
        Was = VALUES[Sig]
        if Was != Now:
            Fout.write('     %s = %s%s;\n' % (Sig,WIDS[Sig],verilogvalue(Now)))
            VALUES[Sig] = Now
            
def verilogvalue(Now):
    if Now < 0 :
        return "'bx"
    return "'h%x" % Now 

veri.sensitive('tb.dut.wclk','0','wnegedge()','0')
veri.sensitive('tb.dut.wclk','1','wposedge()','0')
veri.sensitive('tb.dut.rclk','0','rnegedge()','0')
veri.sensitive('tb.dut.rclk','1','rposedge()','0')


