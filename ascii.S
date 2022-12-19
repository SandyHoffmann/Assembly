.code16                   #generate 16-bit code
time:   dq      0
.text                     #executable code location
    .globl _start;
_start:                   #code entry point

    jmp mover_reg;        #jump to mover_reg
    printar: 
        movw $50, %ax; #move 0x001 to ax (0x880 + 0x001 = 0x881)

        movb $0x0e, %ah; #move 0x0e to ah (0x0e = 14)
        int  $0x10;     #interrupt 0x10 (video interrupt)
        movw $0x880, %ax; #move 0x880 to ax
        movw %ax, %ds;   #move ax to ds
        movb $48, %bl;  #move 48 to bl
        movb %bl, 0x001; #move bl to 0x001 (0x880 + 0x001 = 0x881)

        movw 0x001, %ax; #move 0x001 to ax (0x880 + 0x001 = 0x881)

        movb $0x0e, %ah; #move 0x0e to ah (0x0e = 14)
        int  $0x10;     #interrupt 0x10 (video interrupt)
        iret;

    mover_reg:
    
    #trocar endereço da interrupção 0x07 para procedure printar

    movw 0x07c0, %ax;
    movw %ax, %ds;

    movw 0x0708, %bx;  #move ax to ds 
    movw %bx, printar;    #move ax to ds

    int $0x90; #interrupt 0x10 (video interrupt) 
		jmp final;    #jump to final

    # movw 0x05, %cs;
    # movw printar, %dx; #move printar to dx


    final:
        # testing if the code reached the end returning number 1
        movw $48, %ax; #move 0x001 to ax (0x880 + 0x001 = 0x881)

        movb $0x0e, %ah; #move 0x0e to ah (0x0e = 14)
        int  $0x10;     #interrupt 0x10 (video interrupt)

        . = _start + 510      #mov to 510th byte from 0 pos
        .byte 0x55            #append boot signature
        .byte 0xaa            #append boot signature