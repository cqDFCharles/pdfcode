;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
.386
.model flat,stdcall
option casemap:none
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
; Include 文件定义
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
include			windows.inc

;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

.data?
counter dd ?

.code

DllEntry proc _hInstance,_dwReason,_dwReserved
  mov eax,TRUE
  ret
DllEntry endp
_CheckCounter	proc

		mov	eax,counter
		cmp	eax,0
		jge	@F
		xor	eax,eax
		@@:
		cmp	eax,10
		jle	@F
		mov	eax,10
		@@:
		mov	counter,eax
		ret

_CheckCounter	endp
_IncCounter proc
  inc counter
  call _CheckCounter
  ret
_IncCounter endp
end DllEntry