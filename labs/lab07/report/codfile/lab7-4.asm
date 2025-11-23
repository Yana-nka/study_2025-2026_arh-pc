%include 'in_out.asm'

SECTION .data
msg db "Вычисление функции f(x, a)",0
prompt_x db "Введите значение x: ",0
prompt_a db "Введите значение a: ",0
result_msg db "Результат f(x, a): ",0
func_desc db "f(x,a) = { a/2, если a != 1; 10+x, если a = 1 }",0

SECTION .bss
x resb 10
a_val resb 10

SECTION .text
global _start
_start:
    ; Вывод заголовка и описания функции
    mov eax, msg
    call sprintLF
    mov eax, func_desc
    call sprintLF
    
    ; Ввод значения x
    mov eax, prompt_x
    call sprint
    mov ecx, x
    mov edx, 10
    call sread
    
    ; Ввод значения a
    mov eax, prompt_a
    call sprint
    mov ecx, a_val
    mov edx, 10
    call sread
    
    ; Преобразование x в число
    mov eax, x
    call atoi
    push eax      ; Сохраняем x в стеке
    
    ; Преобразование a в число
    mov eax, a_val
    call atoi     ; Теперь a в EAX
    
    ; Проверка условия: если a = 1
    cmp eax, 1
    je case_a_equals_1
    
    ; Случай a ≠ 1: f(x,a) = a/2
    mov ebx, 2    ; Делитель
    xor edx, edx  ; Обнуляем EDX для деления
    div ebx       ; EAX = a/2
    jmp print_result
    
case_a_equals_1:
    ; Случай a = 1: f(x,a) = 10 + x
    pop eax       ; Восстанавливаем x из стека
    add eax, 10   ; EAX = 10 + x
    
print_result:
    ; Вывод результата
    mov edi, eax
    mov eax, result_msg
    call sprint
    mov eax, edi
    call iprintLF
    
    call quit
