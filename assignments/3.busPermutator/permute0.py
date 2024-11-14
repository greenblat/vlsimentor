#! /usr/bin/env python3
import os,sys,string

def main():
    Fname = sys.argv[1]
    File = open(Fname)
    Fout = open('out.file','w')

    while 1:
        line = File.readline()
        if line=='': return
        wrds = line.split()
        if len(wrds)==0:
            pass
        else:
            work()

if __name__ == '__main__': main()
