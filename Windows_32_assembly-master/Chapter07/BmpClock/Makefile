NAME = BmpClock
OBJS = $(NAME).obj
RES  = $(NAME).res

LINK_FLAG = /subsystem:windows
ML_FLAG = /c /coff /I D:\masm32\include

$(NAME).exe: $(OBJS) $(RES)
	Link $(LINK_FLAG) $(OBJS) $(RES)

%.obj:%.asm
	ml $(ML_FLAG) $<
%.res:%.rc
	rc /fo $@ $<

clean:
	rm -f *.obj
	rm -f *.res
