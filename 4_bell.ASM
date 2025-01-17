ESC_    equ     1Bh     ;ASCII-eia eeaaeoe ESC
ESC_    equ     1Bh     ;����-��� ������� ESC
F2      equ     3Ch     ;����-��� ������� F2
F3      equ     3Dh     ;����-��� ������� F3
F4      equ     3Eh     ;����-��� ������� F4
F5      equ     3Fh     ;����-��� ������� F5
G       equ     67H     ;ASCII-eia eeaaeoe G
H       equ     68h     ;ASCII-eia eeaaeoe H
J       equ     6Ah     ;ASCII-eia eeaaeoe J
K       equ     6Bh     ;ASCII-eia eeaaeoe K
G       equ     22h     ;����-��� ������� G
H       equ     23h     ;����-��� ������� H
J       equ     24h     ;����-��� ������� J
K       equ     25h     ;����-��� ������� K

        org 100h
start:
        mov ah,10h
        int 16h       ;������ ������� � ����������
        cmp al, ESC_ ; ESC check
        je exit
        cmp ah, F2   ; ������ �� ������� F2
        je F2_met
        cmp ah, F3   ; ������ �� ������� F3
        je F3_met
        cmp ah, F4   ; ������ �� ������� F4
        je F4_met
        cmp ah, F5   ; ������ �� ������� F5
        je F5_met
        mov ah,08h
        int 21h

        cmp al,'{'
        je  OUTPUT
        ;jne start
        je OUTPUT

        cmp al,'}'
        je  OUTPUT
        ;jne start
        je OUTPUT

        cmp     al,'|'
        je  OUTPUT
        ;jne start
        cmp al,'|'
        je OUTPUT

        cmp     al,'~'
        je  OUTPUT
        cmp al,'~'
        je OUTPUT

        ;mov ah,2h
        ;int 16h       ;iieo?aai aaeo noaoona
        mov ah,2h
        int 16h       ;�������� ���� �������

        ;test al,00000100B   ;i?iaa?yai aeo 3 - CTRL
        ;JZ   start     ;anee 0, oi CTRL auee??ai
        test al,00000100b   ;��������� ��� 3 - ALT
        JE   start     ;���� 0, �� CTRL ��������

        mov ah,10h
        int 16h
        mov ah,8h
        int 21h

        cmp al,G
        je Color_1
        je ALT_G

        cmp al,H
        je ALT_H

        cmp al,J
        je ALT_J

        cmp al,K
        je ALT_K

        jne start

bell:
        ;�������� � ����� �����
        mov ah,2h
        mov dl,7h
        int 21h

        ret

ALT_G:
        mov     ah, 09h  ; ����� ���������
        mov     bl, 0f0h ; ������ ����� �� ����� ����
        mov     cx, 5   ; ��������� ������ 5 ����
        int     10h

        mov dx,ALTG
        int 21h
        jmp start

Color_1:
        ;gray backgrnd with black text
        mov ah,9h
        mov bl,0f9h
        mov cx,11
        int 10h
ALT_H:
        mov     ah, 09h  ; ����� ���������
        mov     bl, 0f1h ; ������ ����� �� ����� ����
        mov     cx, 5   ; ��������� ������ 5 ����
        int     10h

        mov dx,ALTH
        int 21h
        jmp start

ALT_J:
        mov     ah, 09h  ; ����� ���������
        mov     bl, 5Fh ; ����� ����� �� ���������� ����
        mov     cx, 5   ; ��������� ������ 5 ����
        int     10h

        mov dx,ALTJ
        int 21h
        jmp start

ALT_K:
        mov     ah, 09h  ; ����� ���������
        mov     bl, 90h ; ������ ����� �� ��������� ����
        mov     cx, 5   ; ��������� ������ 5 ����
        int     10h

        mov dx,ALTK
        int 21h
        jmp start

F2_met:
        ; auaia oaenoiaiai nniiauaiey
        ; ����� ���������� ���������
        mov ah,9h
        mov al, 6
        int 29h
        mov ah, 9h
        mov dx, NL
        int 21h
        jmp start

F3_met:
        ; auaia oaenoiaiai nniiauaiey
        ; ����� ���������� ���������
        mov ah,9h
        mov al, 5
        int 29h
        mov ah, 9h
        mov dx, NL
        int 21h
        jmp start

F4_met:
        ; auaia oaenoiaiai nniiauaiey
        ; ����� ���������� ���������
        mov ah,9h
        mov al, 4
        int     29h
        mov ah, 9h
        mov dx, NL
        int 21h
        jmp start

F5_met:
        ; auaia oaenoiaiai nniiauaiey
        ; ����� ���������� ���������
        mov ah,9h
        mov al, 3
        int 29h
        mov ah, 9h
        mov dx, NL
        int 21h
        jmp start
OUTPUT:
        ; ����� ������������ ��������
        mov ah,02h  ; ���� ������� � �������
        mov dl,al
        int 21h
        mov ah, 9h
        mov dx, NL
        int 21h
        jmp start
exit:
        mov ah, 9h
        mov     dx, exit_str
        int     21h
        mov ah,8h   ;����� ������� ����� ������� ��� ������ �� ���������
        int 21h

        ret

NL                 db     $0d,$0a,'$'
F2_str             db "F2",$0d,$0a,'$'
ctrl_six_str       db "CTRL+6",$0d,$0a,'$'
exit_str           db "To exit now press any button...",$0d,$0a,'$'
ALTG              db "ALT_G", $0d,$0a,'$'
ALTH              db "ALT_H", $0d,$0a,'$'
ALTJ              db "ALT_J", $0d,$0a,'$'
ALTK              db "ALT_K", $0d,$0a,'$'