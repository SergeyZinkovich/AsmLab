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
    fmt_inp_eps db "eps: ", 0
    outVal db "%.5lf", 10, 0
    inVal db "%lf", 0
    one dq 1.0
    counter dq 1.0
    eps dq ?
    e dq 1.0
    nextVal dq 1.0
.code
_main:
    invoke crt_printf, addr fmt_inp_eps  
    invoke crt_scanf, addr inVal, addr eps
    finit

    fld e
    
    _loop:
        fld nextVal
        fadd st(1), st(0)
        
        fld eps
        fcompp

        fstsw ax
        sahf   

        jae _exit
        
        fld nextVal
        
        fld counter
        fld one
        faddp st(1), st(0)
        fst counter

        fdivp st(1), st(0)    
        fstp nextVal

        jmp _loop
    _exit:

    fstp e
    
    invoke crt_printf, addr outVal, e
    invoke crt_scanf, addr inVal, addr eps

    exit
end _main