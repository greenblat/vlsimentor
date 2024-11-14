#! /usr/bin/env python3
import os,sys,string

Base = [0,1,2,3,4,5,6,7]
Dones = {}
def main():
    for Control in range(0x100000):
        V0 = permute1(Base,Control & 0xf)
        V1 = permute2(V0,(Control>>4) & 0xf)
        V2 = permute4(V1,(Control>>8) & 0xf)
        V3 = permute3(V2,(Control>>12) & 0xf)
        V4 = permute3(V3,(Control>>16) & 0xf)
        X = tuple(V4)
        if X not in Dones: Dones[X] = 0
        Dones[X] += 1
    goods,bads = 0,0
    for Key in Dones:
        if valid(Key): goods += 1
        else:
            bads += 1
        if Dones[Key] > 1:
            print("%d %s" % (Dones[Key],Key))
    print("goods %d bads %d" % (goods,bads))

def valid(Key):
    X = sum(Key)
    if X!=28: return False

    LL = list(Key)
    LL.sort()

    return True

def permute1(Vecin,Control):
    VV = Vecin[:]
    if (Control & 1): swap(0,1,VV)
    if (Control & 2): swap(2,3,VV)
    if (Control & 4): swap(4,5,VV)
    if (Control & 8): swap(6,7,VV)
    return VV

def permute2(Vecin,Control):
    VV = Vecin[:]
    if (Control & 1): swap(0,2,VV)
    if (Control & 2): swap(1,3,VV)
    if (Control & 4): swap(4,6,VV)
    if (Control & 8): swap(5,7,VV)
    return VV

def permute3(Vecin,Control):
    VV = Vecin[:]
    if (Control & 1): swap(1,2,VV)
    if (Control & 2): swap(3,4,VV)
    if (Control & 4): swap(5,6,VV)
    if (Control & 8): swap(0,7,VV)
    return VV

def permute4(Vecin,Control):
    VV = Vecin[:]
    if (Control & 1): swap(0,4,VV)
    if (Control & 2): swap(1,5,VV)
    if (Control & 4): swap(2,6,VV)
    if (Control & 8): swap(3,7,VV)
    return VV

def permute5(Vecin,Control):
    VV = Vecin[:]
    if (Control & 1): swap(0,7,VV)
    if (Control & 2): swap(1,6,VV)
    if (Control & 4): swap(2,5,VV)
    if (Control & 8): swap(3,4,VV)
    return VV

def swap(A,B,Vec):
    X = Vec[A]
    Y = Vec[B]
    Vec[A] = Y
    Vec[B] = X





if __name__ == '__main__': main()
