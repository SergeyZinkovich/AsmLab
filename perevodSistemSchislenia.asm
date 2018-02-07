.386                    
.model flat, stdcall    
option casemap: none    

include \masm32\include\kernel32.inc
include \masm32\include\masm32.inc
include \masm32\include\msvcrt.inc
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\masm32.lib
includelib \masm32\lib\msvcrt.lib
include \masm32\macros\macros.asm

.data
    outX db "x: ", 0
    outQ db "q: ", 0
    outVal db "%hu ", 0
    inVal db "%hu", 0
    
    x dw ?
    q dw ?
    counter dw 1
    arr dw 32 dup(0) 

.code
_main:
    invoke crt_printf, addr outX
    invoke crt_scanf, addr inVal, addr x
    invoke crt_printf, addr outQ
    invoke crt_scanf, addr inVal, addr q
    
    mov counter, 1
    
_loop:

    cmp x, 0
    je _exit

    mov dx, 0
    mov ax, x
    div q
    mov x, ax
    
    mov eax, offset arr
    movzx ebx, counter
    mov [eax + 2*ebx], dx 
        
    inc counter
    
    jmp _loop
    
_exit:

    dec counter

_loop1:

    cmp counter, 0
    je _end1

    mov eax, offset arr
    movzx edx, counter
    mov bx, [eax + 2*edx]
    invoke crt_printf, addr outVal, ebx

    dec counter

    jmp _loop1
    
_end1:

    invoke crt_scanf, addr inVal, addr x
    
end _main
