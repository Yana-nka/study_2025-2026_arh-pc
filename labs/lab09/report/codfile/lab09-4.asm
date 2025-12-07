%include 'in_out.asm'

SECTION .data
msg_func db "Функция: f(x)=17+5x",0
msg_result db "Сумма f(x) = ",0
msg_usage db "Использование: ./program x1 x2 x3 ...",0
newline db 0xA,0

SECTION .text
global _start

; ============================================
; ПОДПРОГРАММА вычисления функции f(x) = 17 + 5x
; Вход:  eax = x (значение аргумента)
; Выход: eax = 17 + 5*x (результат вычисления)
; ============================================
_calculate_function:
    push ebx
    mov ebx, 5
    imul ebx           ; eax = eax * 5
    add eax, 17        ; eax = eax + 17
    pop ebx
    ret

; ============================================
; ОСНОВНАЯ ПРОГРАММА
; ============================================
_start:
    ; Выводим информацию о функции
    mov eax, msg_func
    call sprintLF

    ; Получаем аргументы командной строки
    pop ecx            ; Количество аргументов (argc)
    
    ; Проверяем, есть ли аргументы кроме имени программы
    cmp ecx, 1
    jle no_args        ; Если только имя программы - выход
    
    pop eax            ; Пропускаем имя программы (argv[0])
    dec ecx            ; Уменьшаем счетчик аргументов
    
    mov ebx, 0         ; ebx = сумма результатов (инициализация)

next_arg:
    ; Обработка очередного аргумента
    pop eax            ; Берем аргумент (строку)
    call atoi          ; Преобразуем строку в число (результат в eax)
    
    ; ВЫЗОВ ПОДПРОГРАММЫ для вычисления функции
    call _calculate_function ; eax = 17 + 5*x
    
    add ebx, eax       ; Добавляем результат к общей сумме
    
    loop next_arg      ; Повторяем для всех аргументов

    ; Вывод результата
    mov eax, msg_result
    call sprint
    mov eax, ebx       ; Переносим сумму в eax для вывода
    call iprintLF
    call quit

no_args:
    ; Если нет аргументов
    mov eax, msg_usage
    call sprintLF
    call quit