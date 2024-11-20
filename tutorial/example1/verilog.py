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


import random

class driverMonitor(logs.driverClass):
    def __init__(self,Path,Monitors):
        logs.driverClass.__init__(self,Path,Monitors)
        self.Active = 0
        self.Queue = []

    def run(self):
        self.check()
        if self.Active == 0: 
            self.force('vldin',0)
            return
        if random.randint(0,100) < 70: 
            self.force('vldin',0)
            return
            
        AA = random.randint(0,0xffffffff)
        BB = random.randint(0,0xffffffff)
        self.Queue.append((AA,BB))
        self.force('aa',AA)
        self.force('bb',BB)
        self.force('vldin',1)
        self.Active -= 1
                
    def check(self):
        if self.peek('vldout'):
            out = self.peek('out')
            AA,BB = self.Queue.pop(0)
            Exp  = AA * BB
            if (Exp == out):
                logs.log_correct('0x%x <= 0x%x * 0x%x' % (out,AA,BB))
            else:
                logs.log_wrong('exp:0x%x act:0x%x <= 0x%x * 0x%x' % (Exp,out,AA,BB))
    
    def action(self,Txt,Orig=[]):
        wrds = Txt.split()
        if wrds==[]:
            return
        elif (wrds[0] == 'active'):
            self.Active = self.eval(wrds[1])
        else:
            logs.log_error('unknown action %s' % (Txt))


    def busy(self,Why=False):
        return self.Active > 0

    def onFinish(self):
        return



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
    veri.force('tb.aa','0')
    veri.force('tb.bb','0')
    veri.force('tb.vldin','0')
    out = logs.peek('tb.out')
    vldout = logs.peek('tb.vldout')
