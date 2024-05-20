;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
; Sample code for < Win32ASM Programming 2nd Edition>
; by 罗云彬, http://asm.yeah.net
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
; Receive.asm
; 从一个程序向另一个窗口程序发送消息 之 消息接收程序
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
; 使用 nmake 或下列命令进行编译和链接:
; ml /c /coff Receive.asm
; Link /subsystem:windows Receive.obj
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
		.386
		.model flat,stdcall
		option casemap:none
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
; Include 文件定义
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
include		windows.inc
include		gdi32.inc
includelib	gdi32.lib
include		user32.inc
includelib	user32.lib
include		kernel32.inc
includelib	kernel32.lib


counter equ 100h
IDEDIT  equ		101h
IDSTART equ  	102h
IDRESET equ  	103h
IDICON equ  	104h
IDCURS equ  	105h

F_PAUSE equ 0001h
F_RESET equ 0002h
F_COUNTING equ 0004h
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
; 数据段
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
		.data
msgformat db 'eax:%d',0
msg db 0 dup(20),0
hIcon dd ?
cnt dd ?


		.data?
hWinMain dd ?
hInstance dd ?
dwOption dd ?

hCount dd ?
hReset dd ?

		.const
szStop db '复位',0
szStart db '计数',0
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
; 代码段
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
		.code

_ProcThread proc uses ebx  esi edi lParam
		local @var
		or dwOption,F_COUNTING
		and dwOption,not ( F_RESET or F_PAUSE)
		invoke SetWindowText,hCount,addr szStop
		invoke EnableWindow,hReset,TRUE
		xor ebx,ebx
		.while !(dwOption & F_RESET)
			.if !(dwOption & F_PAUSE)
				inc ebx
				invoke SetDlgItemInt,hWinMain,IDEDIT,ebx,FALSE
			.endif
		.endw

		invoke SetWindowText,hCount,addr szStart
		invoke SetDlgItemInt,hWinMain,IDEDIT,0,FALSE
		invoke EnableWindow,hReset,FALSE
		and dwOption,not (F_COUNTING or  F_RESET or F_PAUSE )
		ret

_ProcThread endp
_ProcDlgMain	proc	uses ebx edi esi hWnd,wMsg,wParam,lParam
		local	@dwThreadID
		mov	eax,wMsg
;********************************************************************
		.if	eax ==	WM_COMMAND
			mov	eax,wParam
			.if ax == IDSTART
				.if dwOption & F_COUNTING
					or dwOption,F_RESET
				.else
					invoke CreateThread,NULL,0,offset _ProcThread,NULL,\
						NULL,addr @dwThreadID
					invoke CloseHandle,eax
				.endif
			.elseif ax == IDRESET
				xor dwOption,F_PAUSE
				; invoke SetDlgItemInt,hWinMain,IDEDIT,hWnd,FALSE
			.endif
;********************************************************************
		.elseif	eax ==	WM_CLOSE
			invoke	EndDialog,hWinMain,0
;********************************************************************
		.elseif	eax ==	WM_INITDIALOG
			push	hWnd
			pop	hWinMain
			invoke LoadIcon,hInstance,IDICON
			invoke SendMessage,hWnd,WM_SETICON,ICON_BIG,eax
			invoke LoadCursor,hInstance,IDCURS
			invoke SetClassLong,hWnd,GCL_HCURSOR,eax

			invoke GetDlgItem,hWnd,IDSTART
			mov hCount,eax
			invoke GetDlgItem,hWnd,IDRESET
			mov hReset,eax
			;invoke SetDlgItemText,hWnd,IDC_INFO,keychar
;********************************************************************
		.else
			mov	eax,FALSE
			ret
		.endif
		mov	eax,TRUE
		ret

_ProcDlgMain	endp

start:
		invoke GetModuleHandle,NULL
		mov hInstance,eax
		invoke DialogBoxParam,hInstance,counter,NULL,offset _ProcDlgMain,NULL
		; invoke GetLastError
		; invoke wsprintf,addr msg,addr formatmsg,eax
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
		;invoke	ExitProcess,NULL
		end	start
