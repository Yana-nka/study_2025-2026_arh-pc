%include 'in_out.asm'

SECTION .data
msg db "Программа вычисления функции f(x) = 3(x + 10) - 20",0
prompt db "Введите значение x: ",0
result db "Результат вычисления: ",0
expression db "f(x) = 3(x + 10) - 20",0

SECTION .bss
x resb 10

SECTION .text
global _start
_start:
    ; Вывод выражения для вычисления
    mov eax, msg
    call sprintLF
    mov eax, expression
    call sprintLF
    
    ; Запрос на ввод x
    mov eax, prompt
    call sprint
    
    ; Чтение введенного значения
    mov ecx, x
    mov edx, 10
    call sread
    
    ; Преобразование введенной строки в число
    mov eax, x
    call atoi
    
    ; Вычисление f(x) = 3(x + 10) - 20
    add eax, 10       ; EAX = x + 10
    mov ebx, 3        ; EBX = 3
    mul ebx           ; EAX = 3(x + 10)
    sub eax, 20       ; EAX = 3(x + 10) - 20
    
    ; Сохранение результата
    mov edi, eax
    
    ; Вывод результата
    mov eax, result
    call sprint
    mov eax, edi
    call iprintLF
    
    call quit
