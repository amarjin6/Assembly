        org 100h
start:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

        ;����� ������ � �������
        mov ah,9h
        mov dx, str2
        int 21h

        ;���� ������ �������������
        mov ah,0Ah
        mov dx, my_str
        int 21h

        ;������� �� ����� ������
        mov ah,9h
        mov dx, new_line
        int 21h

        ;������ ������ � ��������� �������� ������
        mov bp, my_str+2 ; ����� ������� �������� ������
        mov bl,[bp-1]  ; ����������� ����� ������
        mov cl,[bp] ; 1 ������� ������

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        ; ����� ���������� ����������
        mov ah, 9h
        mov     dx,txt
        int     21h


  mov ah,10   ;���� ������
    lea dx,[strEnter]
    int 21h

    mov ah,2    ;������� ������
    mov dl,10
    int 21h
 
    xor bx,bx   ;�������� �������
    xor cx,cx


        cld   ; ���������� ���� �����������, ����� ���� �� ������ ������ � �� �����
        mov     cx,16 ;��������� ����� ������ � 15 ����
        mov     si,strEnter+12   ; � �������� SI ����� ������, ������ �������� �����
        mov     di,string2  ; � �������� DI ����� ������, ���� �������� �����

repne     movsb     ; ��������� �����������

        ; ����� ���������� ������
        mov ah,9h
        mov dx, string2
        int 21h


        mov ah,2    ;������� ������
        mov dl,10
        int 21h

  xor bx,bx   ;�������� �������
    xor cx,cx
    mov cl,[len+1]    ;����� ������
    lea di,[strEnter]  ;�� ������
    mov al,cl  ;������, ������� ���� ����������
m1:
    repne scasb ;������ ������ � ������
    jnz short exit  ;������ �� ������, �����
m2:         ;������
    inc bl      ;��������� ������� �� 1
    test cx,cx  ;���� �� �� 0, � ������ ���� �������,
    jnz short m1    ; ���������� �����
 
exit:
;����� �� �����
    mov ax,bx
;����� �� �����
    xor     cx, cx
    mov     bx,10
oi2:
    xor     dx,dx
    div     bx
; ����� �������� � ������, ������� �������� � � �����.
    push    dx
    inc     cx
; � � ������� ��������� �� �� �����, ������� �� ���� ���������
; ����� ������, ���� �� ��������� ����, ��� ������, ��� ������
; ����� ������ ����.
    test    ax, ax
    jnz     oi2

 ; ����� ���������� ����������
        mov ah, 9h
        mov     dx,chetchic
        int     21h

; ������ ��������� � ������.
    mov     ah, 02h
oi3:
    pop     dx
; ��������� ��������� �����, ��������� � � ������ � �������.
    sub dl,1; ���� ������ 9!
    add     dl,'0'
    int     21h
; �������� ����� ������� ���, ������� ���� ���������.
    loop    oi3
;-----------------------------------------
    xor ax,ax   ;����� ������� �������
    int 16h

        ; ����� ���������� ����������
        mov ah, 9h
        mov     dx,exit_str
        int     21h

        mov ah,8h   ;����� ������� ����� ������� ��� ������ �� ���������
        int 21h
        ret

txt     db     0dh, 0ah,  "Enter string: ", 0dh, 0ah, '$'
exit_str        db      0dh, 0ah,"To exit now press any button...", 0dh, 0ah, '$'
string2    db       '***************',0dh, 0ah, '$'
strEnter db 16    ;�� 15 ��������
len db ?    ;�����
str2    db "Input 1 element:", $0d, $0a, "$"
my_str  db 2,0,2 dup('$')
new_line   db      $0d, $0A, "$"
chetchic   db      "Number of matches: ", 0dh, 0ah, '$'