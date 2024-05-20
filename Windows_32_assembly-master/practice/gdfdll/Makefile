ASM:=$(wildcard *.asm)
OBJS:=$(patsubst %.asm,%.obj,$(ASM))
DLL:=$(patsubst %.asm,%.dll,$(ASM))
DLL_LIB:=$(patsubst %.asm,%.lib,$(ASM))
EXP:=$(patsubst %.asm,%.exp,$(ASM))
DEF:=$(wildcard *.def)
ML_FLAGS:=-c -coff
LINK_FLAGS:=/subsystem:windows /dll
all:$(DLL)

%.obj:%.asm
	ml $(ML_FLAGS) $< 

$(DLL):$(OBJS) $(DEF)
	link $(LINK_FLAGS) /def:$(DEF) $(OBJS)

clean:
	rm -f $(DLL) $(OBJS) $(EXP) $(DLL_LIB)