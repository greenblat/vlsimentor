


vcd_python3 and vcd_python32

VCD file is waveform in text format. Unlike propriatarey formats from Cadence/Synopsys this 
format is human readable (not really, but ASCII only). Commercial formats are ibinary and much more compressed, but unscannable by us, simple mortals.

look in the pdf file here.
invoking vcd_python3/32 empty will give You some help.

it is built in vlsistuff/vcd_python_c and there are also some more apps for VCD.

vcd_python3 demo.vcd : invoking without python helper, will produce just "recorded" file. 
vcd_python3 demo.vcd demo.py  : will produce "recorded" file and  pymon.log0 file with prints from python helper.

