
// auto generated C headers file of plug_rgf regfile
#ifndef __PLUG_RGF_H
    #define __PLUG_RGF_H

    #include <inttypes.h>

    typedef struct {
    rw uint32_t  CONTROL[3]               ;          // ad=0x0 w=72 acc=rw      "this is very important register"
    ro uint32_t  STATUS                   ;          // ad=0xc w=32 acc=ro      "read only register"
    rw uint32_t  CONTROL2                 ;          // ad=0x10 w=11 acc=rw      "fielded register, no need for width here"
} plug_rgf_RegDef;

#define RATE_COUNT (6)
#define RATE_OFFSET (0)
#define DSC_COUNT (1)
#define DSC_OFFSET (6)
#define BDD_COUNT (4)
#define BDD_OFFSET (7)

#endif
