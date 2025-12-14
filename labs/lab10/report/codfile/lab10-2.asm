SECTION .data
    filename db 'name.txt', 0h
    prompt db 'Как Вас зовут? ', 0h
    message db 'Меня зовут ', 0h
    
SECTION .bss
    name resb 100
    
SECTION .text
    global _start

; ========== ФУНКЦИИ ==========

; Функция печати строки
sprint:
    push edx
    push ecx
    push ebx
    push eax
    
    call slen      ; вычисляем длину строки
    
    mov edx, eax   ; длина
    pop ecx        ; строка (была в eax)
    mov ebx, 1     ; stdout
    mov eax, 4     ; sys_write
    int 80h
    
    pop ebx
    pop ecx
    pop edx
    ret

; Функция чтения строки
sread:
    push eax
    push ebx
    
    mov ebx, 0     ; stdin
    mov eax, 3     ; sys_read
    int 80h
    
    ; Заменяем символ новой строки на 0
    mov esi, ecx
    add esi, eax
    dec esi
    mov byte [esi], 0
    
    pop ebx
    pop eax
    ret

; Функция вычисления длины строки
slen:
    push ebx
    mov ebx, eax
    
nextchar:
    cmp byte [eax], 0
    jz finished
    inc eax
    jmp nextchar
    
finished:
    sub eax, ebx
    pop ebx
    ret

; Функция записи строки в файл
write_to_file:
    ; ebx - дескриптор файла
    ; ecx - строка
    push eax
    push edx
    
    mov eax, ecx
    call slen      ; получаем длину строки
    mov edx, eax   ; длина
    
    mov eax, 4     ; sys_write
    int 80h
    
    pop edx
    pop eax
    ret

; Функция выхода
quit:
    mov eax, 1     ; sys_exit
    mov ebx, 0     ; код возврата
    int 80h

; ========== ОСНОВНАЯ ПРОГРАММА ==========
_start:
    ; 1. Вывод приглашения
    mov eax, prompt
    call sprint
    
    ; 2. Ввод имени с клавиатуры
    mov ecx, name
    mov edx, 100
    call sread
    
    ; 3. Создание файла
    mov eax, 8          ; sys_creat
    mov ebx, filename
    mov ecx, 0644o      ; права доступа rw-r--r--
    int 80h
    
    ; Сохраняем дескриптор файла
    mov ebx, eax        ; дескриптор файла в ebx
    
    ; 4. Запись в файл сообщения "Меня зовут "
    mov ecx, message
    call write_to_file
    
    ; 5. Дописываем в файл введенное имя
    mov ecx, name
    call write_to_file
    
    ; 6. Закрываем файл
    mov eax, 6          ; sys_close
    int 80h
    
    ; Завершение программы
    call quit
