        org 100h


start:
                mov ah, 09h
                mov dx, inputL          ;����������� ����� L
                int 21h

                mov ah, 0ah
                mov dx, strL            ;������ ������ ����� L
                int 21h

                mov bx, dx              ;�������� � bx ������ �� ������ � �������� �������� �������� ��� ��������� ���������
                call count_number       ;��������� �� ������ ����� L
                push ax                 ;��������� �� �������� �� �������� � ����

                mov ah, 02h
                mov dx, 0x0D0A
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

count_number:                    ;��������� ��������� ����� �� ������
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

                mov ax, [bp+4]  ;� ������� �� �������� ���������� L
                mov cx, 20h
                mul cx ;32*L � ax
                mov cx, ax  ;32*L � cx

                mov bx, [bp+2]  ;� ������� ax �������� ���������� M
                mov ax, [bp+2]
                mul bx ;� ax M*M
                mov bx, 7h
                mul bx;7*M*M � ax



                add ax, cx      ;
                mov [res], ax   ;��������� ���������

                ret             ;������� �� ���������





inputL          db "Enter number L: $"
inputM          db "Enter number M: $"
outputRes       db "A+B = $"
strL            db 10, 0, 10 dup(?)
strM            db 10, 0, 10 dup(?)
numL            dw 0h
numM            dw 0h
cm              dw 10
res             dw 0h

