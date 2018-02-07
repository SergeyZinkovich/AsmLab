.386
.model flat, stdcall
option casemap: none

;Подключаем вспомогательные модули
include \masm32\include\kernel32.inc
include \masm32\include\masm32.inc
include \masm32\include\msvcrt.inc
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\masm32.lib
includelib \masm32\lib\msvcrt.lib
include \masm32\macros\macros.asm

.data
    outVal db "%lu ", 0
    outA db "a: ", 0
    inVal db "%lu", 0
    a dd ?
    i dd ?
    ansCount dd 0
    
.code
_main:
    invoke crt_printf, addr outA
    invoke crt_scanf, addr inVal, addr a
    mov i, 1
_loop:
    inc i
    mov eax, 1
    cmp eax, a
    je _print
_loop1:
    mov edx, 0
    mov eax, a
    div i
    cmp edx, 0
    jne _loop
    push i
    inc ansCount
    mov a, eax
    jmp _loop1    
_print:
    cmp ansCount, 0
    je _exit
    pop eax
    dec ansCount
    invoke crt_printf, addr outVal, eax
    jmp _print
_exit:
    invoke crt_scanf, addr inVal, addr a
    exit
end _main
