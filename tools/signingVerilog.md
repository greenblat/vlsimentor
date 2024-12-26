
# Adding signature to verilog files.

The idea is script  which adds **wire [63:0] sign_version = 64'h745641436e181224 ;**  line to verilog modules.
There are 3 fields in this 64bit example constant. 

- date:  181224  signifies that this was signed on December 18th 2024.
- checksum: 1436e is checksum of all characters in the file, when comments and blanks are not counted.
- adler hash:  74564  is the adler hash of the file.
  

The script **signall.py myrtldir**  in vlsistuff/pybin3   will recompute checksum and adler in all verilog files in the directory. If signature isn't changed nothing will happen (date is not considered a change obvously). 
Otherwise, the file will get new signature and copy of the file is auto copied to ~/cellar directory. There the filename is prepended with date string. To keep history.

* *"adler" is a simple hash function*

## The script
    ~/vlsistuff/pybin3/signall.py 
    ~/vlsistuff/pybin3/signVerilogModule.py

in vlsistuff gitHub repository.

### The rational

When my work is used or verified outside my direct environment, i often wonder what version of the code they are using. Perhaps i forgot to commit my changes or they didnt pulled the latest.  Signed verilog files carry the signature into the waves files. So it is easy to check. Also all  historical copies are saved in ~/cellar directory. It makes possible to track the lifetime of the module.

The checksum and hash parts ensure that the file was not tampered with.  Nothing dramatic, but sometimes modifications creep in outside of my control.

Checksum can indicate how much the file changed.  Adler hash indicates any change. Swapping lines will not affect checksum, but will chnge the hash.
