ML_FLAG = /c /coff /fo
LINK_FLAG = /subsystem:windows

Load.exe:DLL.dll

DLL.dll: DLL.obj
	Link  $(LINK_FLAG) /Dll DLL.obj
Load.exe: Load.obj Load.res
	Link  $(LINK_FLAG) Load.obj Load.res

%.obj:%.asm
	ml $(ML_FLAG) $@ $<
%.res:%.rc
	rc /fo $@ $<

clean:
	rm -f *.obj
	rm -f *.res
