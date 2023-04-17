
FIELDS = {}
REGS = {}
DEFAULTS = {}
ADDR_MAP = {}
# = (Width, Offset)


def prepfield(Name, Val):
    if Name in FIELDS:
        (Wid, Off) = FIELDS[Name]
        Mask = (1 << Wid)-1
        Res = (Mask & Val) << Off
        return Res, ~(Mask << Off)
    return 0, 0xffffffff


def setField(Reg, Field, Val):
    if Field == 'default':
        REGS[Reg] = DEFAULTS[Reg]
        return
    Prep, Mask = prepfield(Field, Val)
    if Reg not in REGS:
        REGS[Reg] = DEFAULTS[Reg]
    REGS[Reg] = (REGS[Reg] & Mask) | Prep


ADDR_MAP["control"] = 0x0
control = 0x0
DEFAULTS["control"] = 0x0
ADDR_MAP["status"] = 0xc
status = 0xc
DEFAULTS["status"] = 0x0
ADDR_MAP["control2"] = 0x10
control2 = 0x10
DEFAULTS["control2"] = 0x0
FIELDS["rate"] = (6, 0)
FIELDS["dsc"] = (1, 6)
FIELDS["bdd"] = (4, 7)
