

# Set of tools

- all open source, downloadable freely. Let You produce quality stuff without tethering to servers.
- I work on Apple Mac, which is identical to Linux.
- Cannot provide much help on Windows.

| tool     | what it does           | more info                                     |
|----------|------------------------|-----------------------------------------------|
| python   | good to know scripting | scripts are the lubricant of all workflows    |
| vi       | my favorite text editor| Use whatever You like |
| sed      | handy text file formatter   | sed -e "s/clk/CLK1/g"  file0 > file1 : replaces strings from file to file |
| git      | version control        | enables sharing across many users / computers |
| typora   | display of .md files   | costs few shekels. displays .md files. note that all browsers also display .md |
| draw.io  | drawing diagrams       | free, useful to draw nice graphics, exports to .svg and .png    |
| wavedrom | drawing waveforms      | free, text input, draws nice timing diagrams  |
| dot      | graphviz               | graphviz is a package that turns text description into graph. |
|          |                        |  dot is the language of the description.                  |
| icarus   | free verilog simulator | reads verilog sources and can run simulations |
| gtkwave  | free waves viewer      | reads VCD files (produced by icarus and all other simulators |
|          |                        | and display graphic waves. works in Linux,Mac and Windows |
| **NEXT** |  **STAGE**          |                                                           |
| regfile.py| regfile generator     | my tool (so free): text to verilog of register file       |
| efinix   |  simple FPGA envir     |   simple to get hang of it.                               |
| altera   |  heavy load FPGA envir  |  by Intel                                                |
| xilinx   |  heavy load FPGA envir  |  by somebody else                                         |
| vcd_python3 | python scans VCD file | helps debug test runs.                                  |
| genver.py | macro preprocessor    | verilog code spiced with python directives, expands to legal verilog |
|          |                        |                                                           |
|          |                        |                                                           |
|----------|------------------------|-----------------------------------------------|

1. .md files are text files with "MarkDown" modifiers. just like HTML or XML are.
    replaces WORD documents.
2. VCD format:  oldest format to display waves. Main advantage: regular ascii text, no license and special readers.
                disadvantage:  takes more bytes than Synopsys/Cadence/Mentor propriatry formats/
                advantage: scripts can scan and extract usefull info.
3. best to work in Linux. all design teams work on Linux.  Built-in everything. Fedora or Ubuntu. 
