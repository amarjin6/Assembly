org 100h


start:
                mov ah, 09h
                mov dx, inputL          ;����������� ����� L
                int 21h

                mov ah, 0ah             ; 0aH ���� ������ � �����,��� ������ ������ � ������ max ������ ������ � ������ �����������
                mov dx, strL            ;������ ������ ����� L
                int 21h

                mov bx, dx              ;�������� � bx ������ �� ������ � �������� �������� �������� ��� ��������� ���������(bx ������������ ��� ��������������� ���������.)
                call count_number       ;��������� �� ������ ����� L
                push ax                 ;��������� �� �������� �� �������� � ����

                mov ah, 02h             ;�������� ������ �� DL �� ����������� �����. ������������ ������ Backspace (ASCII 8), ��������� ������ ����� �� ���� ������� � �������� ��� � ����� �������
                mov dx, 0x0D0A          ;A �������� ASCII ��� ������� ����� ������,D 10 �������� ASCII �������� �������.
                int 21h

                mov ah, 09h
                mov dx, inputM          ;����������� ����� M
                int 21h

                mov ah, 0ah
                mov dx, strM            ;������ ������ ����� M
                int 21h

                mov bx, dx
                call count_number       ;��������� �� ������ ����� M
                push ax                 ;��������� �� �������� �� � ����

                call get_result         ;�������� ��������� ����������


                mov ax, [res]           ;���������� � �� ��������� ��� ������������ ������ �����
                call output_number      ;����� ������

                pop ax                  ;������ ����
                pop ax

                mov ah, 08h
                int 21h                 ;����� �������� ����� ���������
                ret

count_number:                   ;��������� ��������� ����� �� ������
                xor ax, ax      ;�������� ��
                xor dx, dx      ;�������� dx

                add bx, 1h      ;����������� ����� ������ �� 1
                mov cl, [bx]    ;����������� 1 ����, � ������� ��������� ����������� ����� ������

lp:                             ;���� ��������� �����
                inc bx          ;����������� ��������� �� ������ �� 1
                mul [cm]        ;�������� �� 10
                add al, [bx]    ;���������� �����
                sub ax, '0'     ;������� ��� '0'

                loop lp         ;��������� ������� �� �� 1, ���������� � �����, ���� �� ����, �� ��������� ����

                ret


output_number:                   ;��������� ������ ����� �� �����
                push '*'        ;����������, ��� ������ ����� � ����� ����� ������ *

lpt:                            ;���� ��������� ����� �� ����� � �������� ��� � ����
                div [cm]        ;������� ����� �� 10, ������� ������ � dx
                push dx         ;��������� � ���� ������� �� �������
                xor dx, dx      ;������� dx �� ��� ����������� ����������
                cmp ax, 0h      ;���������� ��������� ������� � 0
                jne lpt         ;���� �� 0, �� ������ ����


                mov ah, 02h
                mov dx, 0x0D0A
                int 21h

lpp:                            ;���� ������ �����
                pop bx          ;����������� ����� �� �����

                cmp bx, '*'     ;���� ����� �����
                je endst        ;�� ������� �� �����

                add bx, '0'     ;����� ��������� '0' ����� �������� ������

                mov ah, 02h
                mov dx, bx      ;������� ������
                int 21h

                jmp lpp         ;��������� ����

endst:          ret             ;�������

get_result:
                mov bp, sp      ;� ������� bp �������� ��������� �� ���� ��� ������� � ������ ���������� �����

                ;register
                mov ax, [bp+4]  ;� ������� �� �������� ���������� L
                mov bx, [bp+4]
                mul bx ; � ax
                mul bx
                mov bx, ax  ;32*L � cx

                mov cx, [bp+2]  ;� ������� ax �������� ���������� M
                mov ax, [bp+2]
                mul cx ;� ax M*M

                call proc1 ;����� ���������

                mov ah,9h
                mov dx, new_line
                int 21h

                ;����� ������ � �������
                mov ah,9h
                mov dx, str3
                int 21h

                ;����� � ������� ����������
                mov ah,2h
                mov dx, [res]
                int 21h

                ;������� �� ����� ������
                mov ah,9h
                mov dx, new_line
                int 21h


                          ;Global
                mov ax, [bp+4]  ;� ������� �� �������� ���������� L
                mov bx, [bp+4]
                mul bx
                mul bx
                mov [L], ax

                mov cx, [bp+2]  ;� ������� ax �������� ���������� M
                mov ax, [bp+2]
                mul cx ;� ax M*M
                mov [M], ax
                call proc2 ;����� ���������

                ;����� ������ � �������
                mov ah,9h
                mov dx, str4
                int 21h

                ;����� � ������� ����������
                mov ah,2h
                mov dx, [res]
                int 21h

                ;������� �� ����� ������
                mov ah,9h
                mov dx, new_line
                int 21h

                mov ax, [bp+4]  ;� ������� �� �������� ���������� L
                mov bx, [bp+4]
                mul bx
                mov bx, [bp+4]
                mul bx
                mov bx, ax
                push bx ;��������� � ���� ��������

                mov cx, [bp+2]  ;� ������� ax �������� ���������� M
                mov ax, [bp+2]
                mul cx ;� ax M*M
                mov cx, ax
                push cx ;��������� � ���� ��������
                call proc3 ;����� ���������

                ;����� ������ � �������
                mov ah,9h
                mov dx, str5
                int 21h

                ;����� � ������� ����������
                mov ah,2h
                mov dx, [res]
                int 21h

                ;������� �� ����� ������
                mov ah,9h
                mov dx, new_line
                int 21h

                ;�������� ������� �������
                mov ah, 8h ;��������� (�������) ������ �� ������������ �������� ���������� � ���������� ���� ������ � AL
                int 21h


                  ret             ;������� �� ���������


proc1:
                sub bx, ax ;�����
                sub bx, 48
                add bx, '0' ;������� � ASCII ��� may request that the compiler use the ASCII code of that character, which for the digit zero would be 48 in decimal
                mov [res], bx   ;��������� ���������

                ret

proc2:
                mov bx, [L]  ; ��������� �������� A
                mov cx, [M]  ; ��������� �������� B
                sub bx, cx  ;�����
                sub bx, 48
                add bx, '0'  ;������� � ASCII ���
                mov [res], bx  ; ��������� �������� � ������

                ret

proc3:
                pop dx  ; ��������� ����� �������� � �������� ���������
                pop cx ; ��������� �������� B
                pop bx ; ��������� �������� A
                sub bx,cx ;�����
                sub bx, 48
                add bx, '0' ;������� � ASCII ���
                mov [res], bx  ; ��������� �������� � ������
                push dx ; ���������� �� ����� ����� �������� � �������� ���������

                ret




inputL          db "Enter number L: $"
inputM          db "Enter number M: $"
str3            db "Register procedure result is $"
str4            db "Memory procedure result is $"
str5            db "Stack procedure result is $"
strL            db 10, 0, 10 dup(?)
strM            db 10, 0, 10 dup(?)
numL            dw 0h
numM            dw 0h
new_line        db  $0d, $0A, "$"
cm              dw 10
L               dw 0h
M               dw 0h
res             dw 0h

