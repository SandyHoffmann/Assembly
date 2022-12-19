;------------------
TITLE   PROGRAM SHELL FOR A86 SEGMENTATION
PAGE    60,132
 
 
;-----------Code Segment-----------
.MODEL TINY
.STACK 64
.CODE
    ORG 100H
START:  
 
    SUB     AX, AX
    SUB     BX, BX
    SUB     CX, CX
    SUB     DX, DX
 
    ;DISPLAY
    MOV     AX, 0600H
    MOV     BH, 07H
    MOV     DX,184FH
    INT     10H
 
    ;SET VIDEO MODE
    MOV     AH, 00
    MOV     AL, 06H
    INT     10H
 
    CALL    SETSCREEN
 
 
 
LOOP2:  CALL    SETBORDER
    CALL    SETMSG
     MOV     AX, 03H
     INT     33H
     CMP     CX, 0200
     JGE     SKIP
 
     MOV     AX, 05
     INT     33H
     CMP     AL, 1
     JNE     SKIP
 
     MOV     AX, 03H
     INT     33H
     MOV     AH, 0CH
     MOV     AL, 00H
     INT     10H
     JMP     POINT
 
SKIP:    CMP     DX, b INTY
     JE      COMPX
     JMP     DPOINT
COMPX:   CMP     CX, b INTX
     JNE     DPOINT
 
POINT:   ;CALL    SETMSG
     MOV     AX, 03H
     INT     33H
 
     MOV     b INTX, CX
     MOV     b INTY, DX
     
     MOV     AH, 0CH
     MOV     AL, 00H
     INT     10H
     
     CMP     CX, 0200
     JGE     DPOINT
     
     JMP     LOOP1       
 
 
DPOINT: MOV     CX, b INTX
    MOV     DX, b INTY
    MOV     AH, 0CH
    MOV     AL, 01H
    INT     10H
    JMP     POINT
 
 
SKIP2:
    ;Check for Key Press to Quit
LOOP1:  
    MOV     AH, 01          ;Any input? check
    INT     16H             
    JZ      LOOP2
    MOV     AH, 0
    INT     16H
    CMP     AL, 'r'
    JE      LOOP3
    CMP     AL, 'q'
    JE      QUIT
    JMP     LOOP2
 
LOOP3:  CALL    SETSCREEN
    JMP     LOOP2
 
QUIT:   
    MOV     AH, 00
    MOV     AL, 03H
    INT     10H
 
    MOV     AH,4CH
    INT     21H     ; RETURN TO DOS PROMPT
 
;----------- Subroutines ----------
SETSCREEN       PROC
    MOV     CX, 0000
    MOV     DX, 0000
CLOOP:  MOV     AH, 0CH
    MOV     AL, 01
    INT     10H
    INC     CX
    CMP     CX, 640
    JNZ     CLOOP
    MOV     CX, 0000
    INC     DX
    CMP     DX, 200
    JNZ     CLOOP
        RET
SETSCREEN       ENDP
 
SETBORDER       PROC
    MOV     CX, 0201
    MOV     DX, 0000
BLOOP:  MOV     AH, 0CH
    MOV     AL, 00H
    INT     10H
    INC     DX
    CMP     DX, 200
    JNZ     BLOOP
        RET
SETBORDER       ENDP
            
SETCURSOR       PROC
    MOV     AH, 02
    MOV     BH, 00
    MOV     DL, 65
    MOV     DH, b Row
    INT     10H
        RET
SETCURSOR       ENDP
 
SETMSG          PROC
    MOV     b Row, 22
    CALL    SETCURSOR
    MOV     AH, 09
    MOV     DX, OFFSET MSGR
    INT     21H
    
    MOV     b Row, 23
    CALL    SETCURSOR
    MOV     AH, 09
    MOV     DX, OFFSET MSGQ
    INT     21H
        RET
SETMSG          ENDP
 
;----------- Data Segment----------
.DATA
    MSGR    DB      'R to Reset','$'        
    MSGQ    DB      'Q to Quit','$'
 
    INTX    DB      2 DUP (?),'$'
    INTY    DB      2 DUP (?),'$'
 
    Row     DB      ?
    Column  DB      ?
 
END     START
