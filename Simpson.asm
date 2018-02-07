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
    fmt_inp_a db "a: ", 0
    fmt_inp_b db "b: ", 0
    format_out db "%.5lf", 10, 0
    format_inp db "%lf", 0
    a dq ?
    b dq ?
    x dq ?
    six dq 6.0
    four dq 4.0
    two dq 2.0
    firstm dq ?
    fa dq ?
    fb dq ?
    fmid dq ?
    ans dq ?

.code

_main:
    invoke crt_printf, addr fmt_inp_a
    invoke crt_scanf, addr format_inp, addr a
    invoke crt_printf, addr fmt_inp_b
    invoke crt_scanf, addr format_inp, addr b    
    finit
    fld a
    fsin
    fld a
    fcos
    faddp st(1), st(0)
    fstp fa

    fld a
    fld b
    faddp st(1), st(0)
    fld two 
    fdivp st(1), st(0)
    fst x
    fsin
    fld x
    fcos
    faddp st(1), st(0)
    fld four
    fmulp st(1), st(0)
    fstp fmid

    fld b
    fsin
    fld b
    fcos
    faddp st(1), st(0)
    fstp fb

    fld b
    fld a
    fsubp st(1), st(0)
    fld six
    fdivp st(1), st(0)
    fstp firstm

    fld fa
    fld fmid
    faddp st(1), st(0)
    fld fb
    faddp st(1), st(0)
    fld firstm
    fmulp st(1), st(0)
    fstp ans

    invoke crt_printf, addr format_out, ans
    invoke crt_scanf, addr format_inp, addr a
    exit
    
end _main
