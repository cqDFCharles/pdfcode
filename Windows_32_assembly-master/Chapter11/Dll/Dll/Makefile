DLL = Sample

ML_FLAG = /c /coff
LINK_FLAG = /subsystem:windows /Dll

####################################################
# 创建共享数据段的DLL时使用的连接选项
# LINK_FLAG = /subsystem:windows /Dll /section:.bss,S
####################################################

$(DLL).dll: $(DLL).obj $(DLL).def
	Link  $(LINK_FLAG) /Def:$(DLL).def $(DLL).obj

%.obj:%.asm
	ml $(ML_FLAG) $<
%.res:%.rc
	rc $<

clean:
	del *.obj
	del *.exp

