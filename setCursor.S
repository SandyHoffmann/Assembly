.code16                   #generate 16-bit code
.text                     #executable code location
	.globl _start;
 

_start:                   #code entry point
    push %ds
    sub %ax, %ax          #set ax register to 0
    push %ax              #push ax register to stack

    movb $1, %ah
    movw $1, %cx
    int $0x10

    movb $2, %ah
    movb $5, %dh
    movb $0xa, %dl
    movb $0, %bh
    int $0x10

    movw $9, %ax           #set ax register to 9
    movw $0x0a, %bx        #set bx register to 0x0a
    movw $0x0, %cx        #set cx register to 0x0a
    
    # Fazendo o cursor se mover:
    movw $0, %bx

    movw %sp, %bp
    movw %bx, -2(%bp)
    
    print:
        movb $'y' , %al;       #character to print
        movb $0x0e, %ah;       #bios service code to print
        int  $0x10;     #interrupt 0x10 (video interrupt)
        movw %cx, %bx
        movw %bx, -2(%bp)

    loop:
        
        movw $0x3, %ax
        int $0x33
        movw -2(%bp), %bx
        cmp %bx, %cx
        jne print



. = _start + 256
sessao: 
    .byte 0xf, 0xf 
    .byte 0xe7, 0xe7
    .byte 0xf, 0xf

.equ len, . - sessao

loop_end:
	. = _start + 510      #mov to 510th byte from 0 pos
    .byte 0x55            #append boot signature
    .byte 0xaa            #append boot signature 
	int  $0x10            #interrupt the cpu now


    