org 100h


start:
                mov ah, 09h
                mov dx, inputA          ;предложение ввода A
                int 21h

                mov ah, 0ah             ; 0aH ввод строки в буфер,где первый символ в буфере max длинна строки в второй фактическая
                mov dx, strA            ;вводим первое число A
                int 21h

                mov bx, dx              ;помещаем в bx ссылку на строку в качестве передачи регистра как параметра процедуры(bx используется при индексированной адресации.)
                call count_number       ;извлекаем из строки число A
                push ax                 ;результат из регистра ах помещаем в стек

                mov ah, 02h             ;Посылает символ из DL на стандартный вывод. обрабатывает символ Backspace (ASCII 8), перемещая курсор влево на одну позицию и оставляя его в новой позиции
                mov dx, 0x0D0A          ;A значение ASCII для символа новой строки,D 10 значение ASCII возврата каретки.
                int 21h

                mov ah, 09h
                mov dx, inputB          ;предложение ввода B
                int 21h

                mov ah, 0ah
                mov dx, strB            ;вводим второе число B
                int 21h

                mov bx, dx
                call count_number       ;извлекаем из строки число B
                push ax                 ;результат из регистра ах в стек

                call get_result         ;получаем результат вычислений


                mov ax, [res]           ;перемещаем в ах результат для последующего вывода ответ
                call output_number      ;вывод ответа

                pop ax                  ;чистим стек
                pop ax

                mov ah, 08h
                int 21h                 ;конец основной части программы
                ret

count_number:                   ;процедура получения числа из строки
                xor ax, ax      ;обнуляем ах
                xor dx, dx      ;обнуляем dx

                add bx, 1h      ;передвигаем адрес строки на 1
                mov cl, [bx]    ;захватываем 1 байт, в котором находится фактическая длина строки

lp:                             ;цикл получения числа
                inc bx          ;увеличиваем указатель на строку на 1
                mul [cm]        ;умножаем на 10
                add al, [bx]    ;прибавляем цифру
                sub ax, '0'     ;убираем код '0'

                loop lp         ;уменьшаем регистр сх на 1, сравниваем с нулем, если не ноль, то повторяем цикл

                ret


output_number:                   ;процедура вывода числа на экран
                push '*'        ;запоминаем, что концом числа в стеке будет символ *

lpt:                            ;цикл разбиения числа на цифры и передача его в стек
                div [cm]        ;деление числа на 10, остаток уходит в dx
                push dx         ;добавляем в стек остаток от деления
                xor dx, dx      ;очищаем dx от уже занесенного результата
                cmp ax, 0h      ;сравниваем результат деления с 0
                jne lpt         ;если не 0, то заново цикл


                mov ah, 02h
                mov dx, 0x0D0A
                int 21h

lpp:                            ;цикл вывода числа
                pop bx          ;вытаскиваем число из стека

                cmp bx, '*'     ;если конец стека
                je endst        ;то выходим из цикла

                add bx, '0'     ;иначе добавляем '0' чтобы получить символ

                mov ah, 02h
                mov dx, bx      ;выводим символ
                int 21h

                jmp lpp         ;повторяем цикл

endst:          ret             ;выходим

get_result:
                mov bp, sp      ;в регистр bp передаем указатель на стек для доступа к другим переменным стека

                ;передача параметра через регистры
                mov ax, [bp+4]  ;в регистр ах передаем переменную A
                mov bx, [bp+4] ;;в регистр bх передаем переменную A
                mul ax ;A*A в ax
                mul ax ; A*A*A в ax
                mov bx, ax  ;A*A*A в bx

                mov cx, [bp+2]  ;в регистр ax передаем переменную B
                mov ax, [bp+2]
                mul cx ;в ax B*B
               ; mov cx,ax;B*B в ax

                call proc1 ;вызов процедуры

                mov ah,9h
                mov dx, new_line
                int 21h

                ;вывод текста в консоль
                mov ah,9h
                mov dx, str3
                int 21h

                ;вывод в консоль результата
                mov ah,2h
                mov dx, [res]
                int 21h

                ;переход на новую строку
                mov ah,9h
                mov dx, new_line
                int 21h


                ;передача параметра через глобальные переменные
                mov ax, [bp+4]  ;в регистр ах передаем переменную A
                mov bx, [bp+4]  ;в регистр bх передаем переменную A
                mul ax ;A*A в ax
                mul ax ;A*A*A в ax
                mov [A], ax

                mov cx, [bp+2]  ;в регистр ax передаем переменную B
                mov ax, [bp+2]
                mul ax ;в ax B*B
                mov [B], ax
                call proc2 ;вызов процедуры

                ;вывод текста в консоль
                mov ah,9h
                mov dx, str4
                int 21h

                ;вывод в консоль результата
                mov ah,2h
                mov dx, [res]
                int 21h

                ;переход на новую строку
                mov ah,9h
                mov dx, new_line
                int 21h

                mov ax, [bp+4]  ;в регистр ах передаем переменную A
                mov bx, [bp+4]
                mul ax ;A*A в ax
                mul ax
                mov bx, ax
                push bx ;сохраняем в стек значение

                mov cx, [bp+2]  ;в регистр ax передаем переменную B
                mov ax, [bp+2]
                mul cx ;в ax B*B
                mov cx, ax
                push cx ;сохраняем в стек значение
                call proc3 ;вызов процедуры

                ;вывод текста в консоль
                mov ah,9h
                mov dx, str5
                int 21h

                ;вывод в консоль результата
                mov ah,2h
                mov dx, [res]
                int 21h

                ;переход на новую строку
                mov ah,9h
                mov dx, new_line
                int 21h

                ;ожидание нажатия клавиши
                mov ah, 8h ;Считывает (ожидает) символ со стандартного входного устройства и возвращает этот символ в AL
                int 21h


                ret             ;выходим из процедуры


proc1:
                add bx, ax ;сумма
                sub bx, 16
                add bx, '0' ;перевод в ASCII код may request that the compiler use the ASCII code of that character, which for the digit zero would be 48 in decimal
                mov [res], bx   ;сохраняем результат

                ret

proc2:
                mov bx, [A]  ; извлекаем параметр A
                mov cx, [B]  ; извлекаем параметр B
                add bx, cx  ;сумма
                sub bx, 16
                add bx, '0'  ;перевод в ASCII код
                mov [res], bx  ; сохраняем значение в памяти

                ret

proc3:
                pop dx  ; извлекаем адрес возврата к основной программе
                pop cx ; извлекаем параметр B
                pop bx ; извлекаем параметр A
                add bx,cx ;сумма
                sub bx, 16
                add bx, '0' ;перевод в ASCII код
                mov [res], bx  ; сохраняем значение в памяти
                push dx ; возвращаем на место адрес возврата к основной программе

                ret




inputA          db "Enter number A: $"
inputB          db "Enter number B: $"
str3            db "Register procedure result is $"
str4            db "Memory procedure result is $"
str5            db "Stack procedure result is $"
strA            db 10, 0, 10 dup(?)
strB            db 10, 0, 10 dup(?)
numA            dw 0h
numB            dw 0h
new_line        db  $0d, $0A, "$"
cm              dw 10
A               dw 0h
B               dw 0h
res             dw 0h

