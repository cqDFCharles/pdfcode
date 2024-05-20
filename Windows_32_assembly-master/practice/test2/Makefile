ASM:=$(wildcard *.asm)
OBJS:=$(patsubst %.asm,%.obj,$(ASM))
RC:=$(wildcard *.rc)
EXE:=$(patsubst %.asm,%.exe,$(ASM))
RES:=$(patsubst %.rc,%.res,$(RC))
ML_FLAGS:=-c -coff
LINK_FLAGS:=/subsystem:console
all:$(EXE)

%.obj:%.asm
	ml $(ML_FLAGS) $< 
%.res:%.rc
	rc  /fo $@ $< 
$(EXE):$(OBJS) $(RES)
	link $(LINK_FLAGS) $(OBJS) $(RES)

clean:
	rm -f $(EXE) $(RES) $(OBJS)
