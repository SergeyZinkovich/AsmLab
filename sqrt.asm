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
    fmt_inp_n db "n: ", 0
    fmt_inp_a db "a: ", 0
    fmt_inp_eps db "eps: ", 0
    fmt_val db "%lu", 0
    format_out db "%.5lf", 10, 0
    format_inp db "%lf", 0
    n dd ?
    d dd 2
    eps dq ?
    a dq ?
    dv dq 2.0
    one dq 1.0
    left dq 0.0
    right dq 0.0    
    mid dq ?
    res dq 1.0
    temp dd ?
    temp2 dq ?
    temp3 dq -1.0


.code

_main:
    invoke crt_printf, addr fmt_inp_n
    invoke crt_scanf, addr fmt_val, addr n
    invoke crt_printf, addr fmt_inp_a
    invoke crt_scanf, addr format_inp, addr a
    invoke crt_printf, addr fmt_inp_eps
    invoke crt_scanf, addr format_inp, addr eps
    finit
    
    fld right
    fld a
    faddp st(1), st(0)
    fstp right

_loop:
    fld right
    fld left
    fsubp st(1), st(0)
 
    fld eps
    fcompp
    fstsw ax
    sahf
    
    jae _end

    fld right
    fld left
    faddp st(1), st(0)
    fld dv
    fdivp st(1), st(0)
    fstp mid

    fld res
    fld res
    fdivp st(1), st(0)  
    fstp res
    fld mid
    fstp temp2
    mov eax, n
    mov temp, eax
_loop1:
    cmp temp, 0
    jbe _next
    mov eax, temp
    mov edx, 0
    mov ebx, 2
    div ebx
    cmp edx, 1
    je _pow
_back:
    fld temp2
    fld temp2
    fmulp st(1), st(0)
    fstp temp2
    mov eax, temp
    mov edx, 0
    mov ebx, 2
    div ebx
    mov temp, eax
    jmp _loop1
_pow:
    fld res
    fld temp2
    fmulp st(1), st(0)
    fstp res
    jmp _back
_next:
    fld res
    fld a
    fcompp
    fstsw ax
    sahf

    jae _path1
    
    fld mid
    fstp right
    jmp _loop

_path1:
    fld mid
    fstp left
    jmp _loop
    
_end:
    fld right
    fld left
    faddp st(1), st(0)
    fld dv
    fdivp st(1), st(0)
    fstp mid
    invoke crt_printf, addr format_out, mid
    invoke crt_scanf, addr fmt_val, addr n
    exit
    
end _main
