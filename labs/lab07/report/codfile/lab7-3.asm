%include 'in_out.asm'

SECTION .data
msg db "Нахождение наименьшей из трех переменных",0
result_msg db "Наименьшее значение: ",0
a dd 15      ; Значение переменной a
b dd 8       ; Значение переменной b  
c dd 12      ; Значение переменной c

SECTION .text
global _start
_start:
    ; Вывод заголовка
    mov eax, msg
    call sprintLF
    
    ; Загрузка переменных в регистры
    mov eax, [a]
    mov ebx, [b]
    mov ecx, [c]
    
    ; Сравнение a и b
    cmp eax, ebx
    jl compare_a_c    ; Если a < b, перейти к сравнению a и c
    mov eax, ebx      ; Иначе минимальное пока b
    
compare_a_c:
    ; Сравнение текущего минимума (в EAX) с c
    cmp eax, ecx
    jl print_result   ; Если текущий минимум меньше c, перейти к выводу
    mov eax, ecx      ; Иначе минимум - c
    
print_result:
    ; Сохранение результата
    mov edi, eax
    
    ; Вывод результата
    mov eax, result_msg
    call sprint
    mov eax, edi
    call iprintLF
    
    call quit
