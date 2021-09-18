        org 100h
start:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

        ;вывод текста в консоль
        mov ah,9h
        mov dx, str2
        int 21h

        ;ввод строки пользователем
        mov ah,0Ah
        mov dx, my_str
        int 21h

        ;переход на новую строку
        mov ah,9h
        mov dx, new_line
        int 21h

        ;меняем первый и последний элементы строки
        mov bp, my_str+2 ; адрес первого элемента строки
        mov bl,[bp-1]  ; фактическая длина строки
        mov cl,[bp] ; 1 элемент строки

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        ; вывод текстового ссообщения
        mov ah, 9h
        mov     dx,txt
        int     21h


  mov ah,10   ;ввод строки
    lea dx,[strEnter]
    int 21h

    mov ah,2    ;перевод строки
    mov dl,10
    int 21h
 
    xor bx,bx   ;очистить счетчик
    xor cx,cx


        cld   ; сбрасываем флаг направления, будем идти от начала строки и до конца
        mov     cx,16 ;установка длины строки в 15 байт
        mov     si,strEnter+12   ; в регистре SI адрес строки, откуда копируем байты
        mov     di,string2  ; в регистре DI адрес строки, куда копируем байты

repne     movsb     ; выполняем копирование

        ; вывод полученной строки
        mov ah,9h
        mov dx, string2
        int 21h


        mov ah,2    ;перевод строки
        mov dl,10
        int 21h

  xor bx,bx   ;очистить счетчик
    xor cx,cx
    mov cl,[len+1]    ;длина строки
    lea di,[strEnter]  ;на строку
    mov al,cl  ;символ, который надо подсчитать
m1:
    repne scasb ;искать символ в строке
    jnz short exit  ;символ не найден, выход
m2:         ;найден
    inc bl      ;увеличить счетчик на 1
    test cx,cx  ;если СХ не 0, в строке есть символы,
    jnz short m1    ; продолжить поиск
 
exit:
;Вывод на экран
    mov ax,bx
;вывод на экран
    xor     cx, cx
    mov     bx,10
oi2:
    xor     dx,dx
    div     bx
; Сразу выводить её нельзя, поэтому сохраним её в стэке.
    push    dx
    inc     cx
; А с частным повторяем то же самое, отделяя от него очередную
; цифру справа, пока не останется ноль, что значит, что дальше
; слева только нули.
    test    ax, ax
    jnz     oi2

 ; вывод текстового ссообщения
        mov ah, 9h
        mov     dx,chetchic
        int     21h

; Теперь приступим к выводу.
    mov     ah, 02h
oi3:
    pop     dx
; Извлекаем очередную цифру, переводим её в символ и выводим.
    sub dl,1; если меньше 9!
    add     dl,'0'
    int     21h
; Повторим ровно столько раз, сколько цифр насчитали.
    loop    oi3
;-----------------------------------------
    xor ax,ax   ;ждать нажатия клавиши
    int 16h

        ; вывод текстового ссообщения
        mov ah, 9h
        mov     dx,exit_str
        int     21h

        mov ah,8h   ;ждать нажатия любой клавиши для выхода из программы
        int 21h
        ret

txt     db     0dh, 0ah,  "Enter string: ", 0dh, 0ah, '$'
exit_str        db      0dh, 0ah,"To exit now press any button...", 0dh, 0ah, '$'
string2    db       '***************',0dh, 0ah, '$'
strEnter db 16    ;на 15 символов
len db ?    ;длина
str2    db "Input 1 element:", $0d, $0a, "$"
my_str  db 2,0,2 dup('$')
new_line   db      $0d, $0A, "$"
chetchic   db      "Number of matches: ", 0dh, 0ah, '$'