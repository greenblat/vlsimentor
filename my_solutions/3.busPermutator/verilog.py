

import os,sys,random
import veri



NewName = os.path.expanduser('~')
if os.path.exists('%s/vlsistuff' % NewName):
    sys.path.append('%s/vlsistuff/verification_libs3'%NewName)
elif 'VLSISTUFF' in os.environ:
    sys.path.append('%s/verification_libs3'%os.environ['VLSISTUFF'])
else:
    print("please set VLSISTUFF to where You cloned vlsistuff repository. like:  /home/cucu/softs/vlsistuff")
    sys.exit()

import logs
Monitors=[]
cycles=0
GIVEUP_TIMEOUT = 100000000    # how many cycles to run before retirment. 

import sequenceClass


def pymonname(Name):
    logs.pymonname(Name)



def sequence(TestName):
    Seq = logs.bin2string(TestName)
    seq.readfile(Seq)
    logs.setVar('sequence',Seq)
    Dir = os.path.dirname(Seq)
    logs.setVar('testsdir',Dir)
    logs.log_info('SEQUENCE %d'%len(seq.Sequence))


def cannot_find_sig(Sig):
    logs.log_error('cannot find "%s" signal in the design'%Sig)



Lib = {}
class driverMonitor(logs.driverClass):
    def __init__(self,Path,Monitors):
        logs.driverClass.__init__(self,Path,Monitors)
        self.Control = 0
        self.waiting = 5
    def run(self):
        if self.waiting>0:
            self.waiting -= 1
            return
        Dout = self.peek('dout')
        Bin = bin(Dout)[2:]
        Str = makestr(Dout)
        logs.log_info('%04x %s' % (self.Control,Str))
        if Str not in Lib: Lib[Str] = 0
        Lib[Str] += 1
        self.Control += 1
        self.Control &= 0x0fff
        self.force('control',self.Control)
        self.waiting = 1

        if self.Control == 0:
            Solutions = len(list(Lib.keys()))
            logs.log_info("XXX0 %s %s" % (Solutions,(1<<16)/Solutions))
            veri.finish()
            return
    def onFinish(self):
        logs.log_info("XXX1 %s" % len(list(Lib.keys())))

def makestr(Int):
    res = ''
    for ii in range(8):
        X = Int & 7
        Int = Int >> 3
        res = str(X)+res
    return res
# example of driver class usage
drv = driverMonitor('tb',Monitors)
seq = sequenceClass.sequenceClass('tb',Monitors,'',[('drv',drv)])



def negedge():
    global cycles
    cycles += 1
    veri.force('tb.cycles',str(cycles))
    if (cycles>GIVEUP_TIMEOUT):
        logs.log_info('finishing on default guard of %d'%GIVEUP_TIMEOUT)
        veri.finish()
    rst_n = veri.peek('tb.rst_n')
    if (rst_n!='1'):
        return

    if (cycles==30):
        veri.listing('tb','100','deep.list')
    if (cycles>30):
        for Mon in Monitors: Mon.run()

def cucu():  # list of all interface signals, just to help You find the names
    veri.force('tb.control','0')
    veri.force('tb.din','0')
    dout = logs.peek('tb.dout')
