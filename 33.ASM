org 100h


start:
                mov ah, 09h
                mov dx, inputA          ;����������� ����� A
                int 21h

                mov ah, 0ah             ; 0aH ���� ������ � �����,��� ������ ������ � ������ max ������ ������ � ������ �����������
                mov dx, strA            ;������ ������ ����� A
                int 21h

                mov bx, dx              ;�������� � bx ������ �� ������ � �������� �������� �������� ��� ��������� ���������(bx ������������ ��� ��������������� ���������.)
                call count_number       ;��������� �� ������ ����� A
                push ax                 ;��������� �� �������� �� �������� � ����

                mov ah, 02h             ;�������� ������ �� DL �� ����������� �����. ������������ ������ Backspace (ASCII 8), ��������� ������ ����� �� ���� ������� � �������� ��� � ����� �������
                mov dx, 0x0D0A          ;A �������� ASCII ��� ������� ����� ������,D 10 �������� ASCII �������� �������.
                int 21h

                mov ah, 09h
                mov dx, inputB          ;����������� ����� B
                int 21h

                mov ah, 0ah
                mov dx, strB            ;������ ������ ����� B
                int 21h

                mov bx, dx
                call count_number       ;��������� �� ������ ����� B
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

                ;�������� ��������� ����� ��������
                mov ax, [bp+4]  ;� ������� �� �������� ���������� A
                mov bx, [bp+4] ;;� ������� b� �������� ���������� A
                mul ax ;A*A � ax
                mul ax ; A*A*A � ax
                mov bx, ax  ;A*A*A � bx

                mov cx, [bp+2]  ;� ������� ax �������� ���������� B
                mov ax, [bp+2]
                mul cx ;� ax B*B
               ; mov cx,ax;B*B � ax

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


                ;�������� ��������� ����� ���������� ����������
                mov ax, [bp+4]  ;� ������� �� �������� ���������� A
                mov bx, [bp+4]  ;� ������� b� �������� ���������� A
                mul ax ;A*A � ax
                mul ax ;A*A*A � ax
                mov [A], ax

                mov cx, [bp+2]  ;� ������� ax �������� ���������� B
                mov ax, [bp+2]
                mul ax ;� ax B*B
                mov [B], ax
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

                mov ax, [bp+4]  ;� ������� �� �������� ���������� A
                mov bx, [bp+4]
                mul ax ;A*A � ax
                mul ax
                mov bx, ax
                push bx ;��������� � ���� ��������

                mov cx, [bp+2]  ;� ������� ax �������� ���������� B
                mov ax, [bp+2]
                mul cx ;� ax B*B
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
                add bx, ax ;�����
                sub bx, 16
                add bx, '0' ;������� � ASCII ��� may request that the compiler use the ASCII code of that character, which for the digit zero would be 48 in decimal
                mov [res], bx   ;��������� ���������

                ret

proc2:
                mov bx, [A]  ; ��������� �������� A
                mov cx, [B]  ; ��������� �������� B
                add bx, cx  ;�����
                sub bx, 16
                add bx, '0'  ;������� � ASCII ���
                mov [res], bx  ; ��������� �������� � ������

                ret

proc3:
                pop dx  ; ��������� ����� �������� � �������� ���������
                pop cx ; ��������� �������� B
                pop bx ; ��������� �������� A
                add bx,cx ;�����
                sub bx, 16
                add bx, '0' ;������� � ASCII ���
                mov [res], bx  ; ��������� �������� � ������
                push dx ; ���������� �� ����� ����� �������� � �������� ���������

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

