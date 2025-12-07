%include 'in_out.asm'
SECTION .data
msg: DB 'Результат: ',0
SECTION .text
GLOBAL _start
_start:
; ---- Вычисление выражения (3+2)*4+5
mov ebx,3
mov eax,2
add ebx,eax      ; ebx = 5
mov eax,ebx      ; ИСПРАВЛЕНИЕ: переносим 5 в eax
mov ecx,4
mul ecx          ; eax = 5 * 4 = 20
add eax,5        ; ИСПРАВЛЕНИЕ: добавляем к eax
mov edi,eax      ; сохраняем результат
; ---- Вывод результата на экран
mov eax,msg
call sprint
mov eax,edi
call iprintLF
call quit
