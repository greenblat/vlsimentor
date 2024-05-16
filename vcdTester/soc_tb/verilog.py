

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
GIVEUP_TIMEOUT = 1000    # how many cycles to run before retirment. 

#import axiSlave
#axis = axiSlave.axiSlaveClass('tb',Monitors)
#import axiMaster
#axi = axiMaster.axiMasterClass('tb',Monitors)
import sequenceClass
seq = sequenceClass.sequenceClass('tb',Monitors,'',[]) # ('axis',axis),('axim',axim)


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
QUEUE = []
def rnegedge():
    rempty = logs.peek('tb.rempty')
    if rempty == 1: 
        veri.force('tb.readx','0')
        return

    rdata = logs.peek('tb.rdata')
    veri.force('tb.readx','1')
    exp = QUEUE.pop(0)
    logs.log_ensure(exp == rdata, "EXP=%x ACT=%x" % (exp,rdata))



def wnegedge():
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
        Wr = random.randint(0,100) > 40
        wfull = logs.peek('tb.wfull')
        if Wr and (wfull == 0):
            veri.force('tb.writex','1')
            Val = random.randint(1000,5000)
            veri.force('tb.wdata',str(Val))
            QUEUE.append(Val)

        else:
            veri.force('tb.writex','0')
            veri.force('tb.wdata','0')

        for Mon in Monitors: Mon.run()

def cucu():  # list of all interface signals, just to help You find the names
    veri.force('tb.rclk','0')
    veri.force('tb.readx','0')
    veri.force('tb.rst_nr','0')
    veri.force('tb.rst_nw','0')
    veri.force('tb.wclk','0')
    veri.force('tb.wdata','0')
    veri.force('tb.writex','0')
    rdata = logs.peek('tb.rdata')
    rempty = logs.peek('tb.rempty')
    wfull = logs.peek('tb.wfull')
