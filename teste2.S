data segment public
msg db
db
'The cursor is at row
' and column '
data ends
code segment public
assume CS:code
main
start:
proc
push
sub
push
far
DS
AX,AX
AX
mov AX,data
mov DS, AX
as sume DS:data
mov AH,2 /function 2 — set cursor
mov DH,05 /row 5
mov DL,Oah /column 10
16 EGA/VGA: A Programmer's Reference Guide
mov BH,0 ;page 0
int lOh ;BIOS video call
mov AH,3 /function 3 - read cursor
position
mov BH,0 /page 0
int lOh /BIOS video call
/DH now contains the row
/DL now contains the coliimn
mov
mov
call
mov
sub
call
mov
mov
assume
mov
mov
mov
mov
mov
mov
int
ret
AL,DL /mov column to AL
BX,offset msg[35] /offset of ASCII #
bin2asc /conv bin to ASCII
AL,DH /move row into AL
BX,14 /offset of ASCII #
bin2asc /convert again
AX,data /get data seg location
ES,AX
ES:data
AH,13h
AL,0
BH,0
BL,Ofh
BP,offset msg
CX,37
lOh
/set ES for next call
/func 13h—write string
/cursor does not move
/string of characters
/only attribute in BL
/page 0
/high intensity white
/ES:BP points to string
/length of string
/BIOS video call
main endp
bin2asc proc near
COMMENT* This binary to ASCII conversion routine is
written for this program and is limited to
numbers less than 100.
AL: 8 bit value to convert
BX: offset in DS which receives a 2 byte ASCII
value
mov AH, 0
mov DL,10
div DL /convert to decimal digits
add AX,3030h /add 30h to get
/ASCII codes
mov [BX] ,AL /write 10's place
mov
ret
bin2asc endp
code ends
end start
[BX+1],AH
;write I's place
