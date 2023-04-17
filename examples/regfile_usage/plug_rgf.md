 - addrwid 20
 - bus apb
 - empty 0xdeadbeaf
 - reset async
 - width 32


|addr|reg   |field|pos|access|width|reset|desc|
|----|------|-----|---|------|-----|-----|----|
|0x0|control| | |rw|72| |"this is very important register"|
|0xc|status| | |ro|32| |"read only register"|
|0x10|control2| | |rw|11| |"fielded register, no need for width here"|
| | |rate|[5:0]| |6| |"baud rate"|
| | |dsc|[6:6]| |1| ||
| | |bdd|[10:7]| |4| ||
