
# VI 

visual text editor. oldest one, i think
## basic commands

- invoke:  vi myfile
- :     typing ":" will set You in line mode. typing commands 
- in line mode:   
      w - write (save file)
      w newname - save under new name
      q  - quit
      wq  - write and quit
      %s/aa/bb/g   -  on all lines (%) replace aa with bb - "g" says on all appearances
      10,20s/bb/cc/   - same only on lines 10 to 20
      set nu          - display line numbers. usefull!
      set ai / noai    - auto indent / no
      set tabstop=4    - tab is 4 chars
      set expandtab     - a must for python edits: replaces all tabs with 4 chars, on save of a file.

- in "visual" mode:

- o        open new line
- i        start inserting characters before current one
- a        start inserting after current one
- 5 yy     yank (catch) 5 lines from cursor
- 5 dd     delete 5 lines
- x        delete one letter
- 5 x      delete 5 letters
- escape    returns to visual idle mode

