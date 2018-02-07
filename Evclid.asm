.386                    ;Указываем тип процессора
.model flat, stdcall    ;Указываем используемую модель памяти и соглашение о вызовах
option casemap: none    ;Сохраняет регистр имен, заданных пользователем

;Подключаем вспомогательные модули
include \masm32\include\kernel32.inc
include \masm32\include\masm32.inc
include \masm32\include\msvcrt.inc
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\masm32.lib
includelib \masm32\lib\msvcrt.lib
include \masm32\macros\macros.asm

;Открываем секцию данных
.data
    outVal db "%li %li %li", 0
    outA db "a: ", 0
    outB db "b: ", 0
    inVal db "%lu", 0
    a dd ?
    b dd ?
    x dd ?
    y dd ?
    x1 dd 0
    x2 dd 1
    y1 dd 1
    y2 dd 0
    q dd ?
    r dd ?
    
;Открываем секцию кода
.code
;Точка входа в основную программу:
_main:
    invoke crt_printf, addr outA
    invoke crt_scanf, addr inVal, addr a
    invoke crt_printf, addr outB
    invoke crt_scanf, addr inVal, addr b
   
_loop:
    cmp b, 0
    jle _exit
    mov edx, 0
    mov eax, a
    div b
    mov q, eax
    mul b
    mov ebx, a
    neg eax
    add ebx, eax
    mov r, ebx
    mov eax, q
    mul x1
    mov ebx, x2
    neg eax
    add ebx, eax
    mov x, ebx
    mov eax, q
    mul y1
    mov ebx, y2
    neg eax
    add ebx, eax
    mov y, ebx
    mov eax, b
    mov a, eax
    mov eax, r
    mov b, eax
    mov eax, x1
    mov x2, eax
    mov eax, x
    mov x1, eax
    mov eax, y1
    mov y2, eax
    mov eax, y
    mov y1, eax
    jmp _loop
_exit:
    invoke crt_printf, addr outVal, a, x2, y2
    invoke crt_scanf, addr inVal, addr a
    exit
end _main
