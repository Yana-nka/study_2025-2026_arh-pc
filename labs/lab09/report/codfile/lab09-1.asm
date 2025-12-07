%include 'in_out.asm'

SECTION .data
msg: DB 'Введите x: ',0
result_f: DB 'f(x) = 2x+7 = ',0
result_g: DB 'g(f(x)) = 3*(2x+7)-1 = ',0

SECTION .bss
x: RESB 80
res_f: RESB 80    ; результат f(x)
res_g: RESB 80    ; результат g(f(x))

SECTION .text
GLOBAL _start

_start:
;------------------------------------------
; Основная программа
;------------------------------------------
mov eax, msg
call sprint

mov ecx, x
mov edx, 80
call sread

mov eax, x
call atoi      ; преобразуем в число, результат в eax

; Вычисляем f(x) = 2x + 7
call _calcut
mov [res_f], eax   ; сохраняем результат f(x)

; Выводим результат f(x)
mov eax, result_f
call sprint
mov eax, [res_f]
call iprintLF

; Вычисляем g(f(x)) = 3*f(x) - 1
mov eax, [res_f]   ; загружаем f(x) в eax
call _subcalcul
mov [res_g], eax   ; сохраняем результат g(f(x))

; Выводим результат g(f(x))
mov eax, result_g
call sprint
mov eax, [res_g]
call iprintLF

call quit

;------------------------------------------
; Подпрограмма вычисления f(x) = 2x + 7
; Вход: eax = x
; Выход: eax = 2*x + 7
;------------------------------------------
_calcut:
    mov ebx, 2
    mul ebx      ; eax = x * 2
    add eax, 7   ; eax = 2x + 7
    ret

;------------------------------------------
; Подпрограмма вычисления g(f(x)) = 3*f(x) - 1
; Вход: eax = f(x)
; Выход: eax = 3*f(x) - 1
;------------------------------------------
_subcalcul:
    mov ebx, 3
    mul ebx      ; eax = f(x) * 3
    sub eax, 1   ; eax = 3*f(x) - 1
    ret
