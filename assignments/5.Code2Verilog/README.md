

# Translate C or Python to RTL

Algorithms that have C or Python representation often need to be translated to RTL.
Then the original C/PY code can be used as golden reference model.

XTEA is encryption / decryption algorithm. 
read the code (in Python) and implement it in RTL.
also find XTEA in wikipedia to get sense of the code.

Debugging can be done by file-to-file compare: 
   - run python code and record the results. 
   - run rtl code with iodentical key/data 
   - compare the logs
later we will show how to debug it directly by employing python-driven-verification.

in assignment number 6, there is another example of C-to-RTL.


