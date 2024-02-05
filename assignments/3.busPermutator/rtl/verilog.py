

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
GIVEUP_TIMEOUT = 10000000    # how many cycles to run before retirment. 

import sequenceClass
seq = sequenceClass.sequenceClass('tb',Monitors,'',[])


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




class driverMonitor(logs.driverClass):
    def __init__(self,Path,Monitors):
        logs.driverClass.__init__(self,Path,Monitors)
#        Monitors.append(self)
#        self.Path = Path
#        self.state='idle'
#        self.waiting  = 0
#
#    def force(self,Sig,Val):
#        veri.force('%s.%s'%(self.Path,Sig),str(Val))
#
#    def peek(self,Sig):
#        return logs.peek('%s.%s'%(self.Path,Sig))
#    def peeksigned(self,Sig):
#        return logs.peeksigned('%s.%s'%(self.Path,Sig))
#
#    def valid(self,Sig):
#        return self.peek(Sig)==1
#
    def run(self):
        if self.waiting>0:
            self.waiting -= 1
        elif self.state=='idle':
            self.state='work0'
        elif self.state=='work0':
            self.state='work1'
        elif self.state=='work1':
            self.state='idle'


        if self.valid('validin')and self.valid('takenin'):
            return

# example of driver class usage
# driverMonitor('tb',Monitors)

AGGR = {}
stopit = False
def negedge():
    global cycles,stopit
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
        veri.force('tb.din','0x76543210')
    if (cycles>30):
        for Mon in Monitors: Mon.run()
        Dout = logs.peek('tb.dout')
        if Dout not in AGGR: AGGR[Dout] = 0
        AGGR[Dout] += 1
        Sel = logs.peek('tb.select')
        if Sel == 0x1ffff:
            stopit = True
        if Sel == 0x1b977:
            logs.log_info('XXXXXX din=%x dout=%08x select=%x panic=%x' % (logs.peek('tb.din'),logs.peek('tb.dout'),logs.peek('tb.select'),logs.peek('tb.dut.panic')))
            
        logs.log_info('din=%x dout=%08x select=%x panic=%x' % (logs.peek('tb.din'),logs.peek('tb.dout'),logs.peek('tb.select'),logs.peek('tb.dut.panic')))
        veri.force('tb.select',str(cycles-31))
    if (cycles==375000) or stopit:
        AGGR2 = {}
        for ind,Key in enumerate(AGGR):
            Num = AGGR[Key]
            logs.log_info('%3d KEY %08x = %d' % (ind,Key,Num))
            AGGR2['%08x' % Key] = 1
        ind = 0
        for Key in FULL:
            Keyi = '%08x' % int(Key,16)
#            logs.log_info('XXX |%s|%s| %s' % (Key,Keyi,Keyi not in AGGR2))
            if Keyi not in AGGR2:
                logs.log_info('%3d MISS %s' % (ind,Key))
                ind += 1
        logs.log_info('MISSINGS %d' % (ind))
        logs.closeLogs()                
        veri.finish()




FULL = {}

def rndfill():
    X = [0,1,2,3,4,5,6,7]
    for ii in range(480000):
        Key = ''.join(map(str,X))
        if Key not in FULL: 
            FULL[Key] = 1
        else:
            FULL[Key] += 1
        random.shuffle(X)
rndfill()
logs.log_info('keys %d' % len(FULL))


def cucu():  # list of all interface signals, just to help You find the names
    veri.force('tb.din','0')
    veri.force('tb.select','0')
    dout = logs.peek('tb.dout')
