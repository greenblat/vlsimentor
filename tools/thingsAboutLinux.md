
# usefull first set of terminal commands in Linux and in OSX.

Not excaustive by any means, but good first starter

| command | what it does |
|------|------------|
| pwd  | print current directory path |
| cd   | change directory to home |
| cd ~  | change directory to home, "~" equals my home |
| cd /home/moshe/projects  | change directory to specified absolute path |
| cd projects  | change directory to specified relative path |
| cd  -  | change directory to previous  |
| cd  !$  | change directory to last token of previous command |
| mkdir cucu |  make new directory |
| ls |  list directory |
| ls -ltFr |  list directory with all data |
| alias lt 'ls -ltFr'    |  create alias of ls, called lt | 
| setenv VAR VALUE  | create environment variable (tcsh format) |
| export VAR VALUE  |  create environment variable (bash format)   |
| grep PATTERN FILENAME | prints lines matching pattern from filename |
| history |    print last N commands executed from this terminal |
| echo "aaa" | print to terminal, usefull for system variables |
| find . -name "*.v" |  print names of all files ending in .v deep from the specified directory |
|                    |  "." is short for current directory , ".." is short for father directory |
|        |        |
| **Variables** |        |
| $PATH |  places to look fro executables:  setenv PATH .:/opt/homebrew/bin/:/opt/local/bin/:/sw/bin:$PATH   |
| $SHELL | echo $SHELL will reveal what kind of shell You are using |

