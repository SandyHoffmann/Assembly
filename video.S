.code16

.text 

.globl _start


_start:

    #mov %es(%bx), %al; #load the latch registers

    movw $0xa0000, %dx			#beginning of display memory
	movw %dx, %es		


    movw $0x03ce, %dx # Graphics 1 and 2 address register
    mov $0x4, %al # Seto o index 4 (como pede a funcao 0x03cf)
    out %al, %dx

    movw $0x03cf, %dx # Mode Register
    movb $0x5, %al # Seleciona o index 5
    out %al, %dx 

    movw $0x03df, %dx #Para chegar ao modo 0x13, adiciono 0x10 ao index 5
    movb $0x00, %al # Seto o low bit do mask 0 (write mode)
    out %al, %dx

    #ver o modo que esta
    mov $0x0, %ah
    movb $0xf, %ah
    int $0x10

    movb $'y' , %al;       #character to print
	movb $0x0e, %ah;       #bios service code to print
	int  $0x10;     #interrupt 0x10 (video interrupt)

    movb 0, %bh;        #page number
	movw $0x100, %cx;        #x coordinate
	movw $0x100, %dx;        #y coordinate

	movb $0x2, %al;        #color
	movb $0x0c, %ah;        #bios service code to plot pixel

	int $0x10;     #interrupt 0x10 (video interrupt)

num_magico:
    . = _start + 510
    .byte 0x55
    .byte 0xaa

