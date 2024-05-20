;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
.386
.model flat,stdcall
option casemap:none
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
; Include 文件定义
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
include			windows.inc
include			gdi32.inc
includelib	gdi32.lib
include			user32.inc
includelib	user32.lib
include			kernel32.inc
includelib	kernel32.lib

;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

_IncCounter proto
includelib gdfdll01.lib

;*************************************************
;数据段
;*************************************************
.data
msg db 0 dup(20),0
formatmsg db "counter is:%d",0
boxtitle db "msg",0
.code

start:
  invoke _IncCounter
  invoke wsprintf,addr msg,addr formatmsg,eax
  invoke MessageBox,NULL,addr msg,addr boxtitle,MB_OK
end start