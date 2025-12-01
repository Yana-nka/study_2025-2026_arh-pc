%include 'in_out.asm'

SECTION .data
msg_func db "Функция: f(x)=17+5x",0
msg_result db "Результат: ",0

SECTION .text
global _start

; Функция f(x) = 17 + 5x
f:
    imul eax, 5    ; eax = 5*x
    add eax, 17    ; eax = 17 + 5*x
    ret

_start:
    ; Выводим информацию о функции
    mov eax, msg_func
    call sprintLF
    
    pop ecx        ; Количество аргументов
    pop edx        ; Имя программы
    sub ecx, 1     ; Убираем имя программы
    mov ebx, 0     ; ebx = сумма (результат)
    jecxz exit     ; Если нет аргументов - выход

next_arg:
    pop eax        ; Берем аргумент
    call atoi      ; Преобразуем строку в число
    call f         ; Вычисляем f(x) = 17 + 5x
    add ebx, eax   ; Добавляем к сумме
    
    loop next_arg

exit:
    mov eax, msg_result
    call sprint
    mov eax, ebx
    call iprintLF
    call quit
