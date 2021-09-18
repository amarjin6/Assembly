org 100h
start: 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
 
 ;auaia oaenoa a eiinieu 
 mov ah,9h 
 mov dx, str2 
 int 21h 
 
 ;aaia no?iee iieuciaaoaeai 
 mov ah,0Ah 
 mov dx, my_str 
 int 21h 
 
 ;ia?aoia ia iiao? no?ieo 
 mov ah,9h 
 mov dx, new_line 
 int 21h 
 
 ;iaiyai ia?aue e iineaaiee yeaiaiou no?iee 
 mov bp, my_str+2 ; aa?an ia?aiai yeaiaioa no?iee 
 mov bl,[bp-1] ; oaeoe?aneay aeeia no?iee 
 mov cl,[bp] ; 1 yeaiaio no?iee 
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
 ; auaia oaenoiaiai nniiauaiey 
 mov ah, 9h 
 mov dx,txt 
 int 21h 
 
 
 mov ah,10 ;aaia no?iee 
 lea dx,[strEnter] 
 int 21h 
 
 mov ah,2 ;ia?aaia no?iee 
 mov dl,10 
 int 21h 
 
 xor bx,bx ;i?enoeou n?ao?ee 
 xor cx,cx 
 
 
 cld ; na?anuaaai oeaa iai?aaeaiey, aoaai eaoe io ia?aea no?iee e ai eiioa 
 mov cx,16 ;onoaiiaea aeeiu no?iee a 15 aaeo 
 mov si,strEnter+12 ; a ?aaeno?a SI aa?an no?iee, ioeoaa eiie?oai aaeou 
 mov di,string2 ; a ?aaeno?a DI aa?an no?iee, eoaa eiie?oai aaeou 
 
repne movsb ; auiieiyai eiie?iaaiea 
 
 ; auaia iieo?aiiie no?iee 
 mov ah,9h 
 mov dx, string2 
 int 21h 
 
 
 mov ah,2 ;ia?aaia no?iee 
 mov dl,10 
 int 21h 
 
 mov cl,[len+1] ;aeeia no?iee 
 lea di,[strEnter] ;ia no?ieo 
 mov al,cl ;neiaie, eioi?ue iaai iian?eoaou 
m1: 
 repne scasb ;eneaou neiaie a no?iea 
 jnz short exit ;neiaie ia iaeaai, auoia 
m2: ;iaeaai 
 inc bl ;oaaee?eou n?ao?ee ia 1 
 test cx,cx ;anee NO ia 0, a no?iea anou neiaieu, 
 jnz short m1 ; i?iaie?eou iiene 
 
exit: 
;----------Auaia ia ye?ai-------— 
 mov ax,bx 
;auaia ia ye?ai 
 xor cx, cx 
 mov bx,10 
oi2: 
 xor dx,dx 
 div bx 
; Aaeei ?enei ia iniiaaiea nn. A inoaoea iieo?aaony iineaaiyy oeo?a. 
; N?aco auaiaeou a? iaeucy, iiyoiio nio?aiei a? a noyea. 
 push dx 
 inc cx 
; A n ?anoiui iiaoi?yai oi ?a naiia, ioaaeyy io iaai i?a?aaio? 
; oeo?o ni?aaa, iiea ia inoaiaony iieu, ?oi cia?eo, ?oi aaeuoa 
; neaaa oieuei ioee. 
 test ax, ax 
 jnz oi2 
 
 ; auaia oaenoiaiai nniiauaiey 
 mov ah, 9h 
 mov dx,chetchic 
 int 21h 
 
; Oaia?u i?enooiei e auaiao. 
 mov ah, 02h 
oi3: 
 pop dx 
; Ecaeaeaai i?a?aaio? oeo?o, ia?aaiaei a? a neiaie e auaiaei. 
 sub dl,1; anee iaiuoa 9! 
 add dl,'0' 
 int 21h 
; Iiaoi?ei ?iaii noieuei ?ac, neieuei oeo? ian?eoaee. 
 loop oi3 
;---------------------------------------— 
 xor ax,ax ;?aaou ia?aoey eeaaeoe 
 int 16h 
 
 ; auaia oaenoiaiai nniiauaiey 
 mov ah, 9h 
 mov dx,exit_str 
 int 21h 
 
 mov ah,8h ;?aaou ia?aoey e?aie eeaaeoe aey auoiaa ec i?ia?aiiu 
 int 21h 
 ret 
 
txt db 0dh, 0ah, "Enter string: ", 0dh, 0ah, '$' 
exit_str db 0dh, 0ah,"To exit now press any button...", 0dh, 0ah, '$' 
string2 db '***************',0dh, 0ah, '$' 
strEnter db 16 ;ia 15 neiaieia 
len db ? ;aeeia 
str2 db "Input 1 element:", $0d, $0a, "$" 
my_str db 2,0,2 dup('$') 
new_line db $0d, $0A, "$" 
chetchic db "Number of matches: ", 0dh, 0ah, '$'