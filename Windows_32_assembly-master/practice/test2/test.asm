.386
.model flat, stdcall

include msvcrt.inc
includelib msvcrt.lib

.data
    szFmt db 'EAX=%d; ECX=%d; EDX=%d', 0

.code
start:
    mov eax, 11
    mov ecx, 22
    mov edx, 33
    invoke crt_printf, addr szFmt, eax, ecx, edx
    ret
end start