NAME = Hello
OBJS = $(NAME).obj

LINK_FLAG = /subsystem:windows
ML_FLAG = /c /coff

$(NAME).exe: $(OBJS)
	Link $(LINK_FLAG) $(OBJS)
%.obj:%.asm
	ml $(ML_FLAG) $<

clean:
	del *.obj
