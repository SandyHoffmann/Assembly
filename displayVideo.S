.code16                   #generate 16-bit code
.text                     #executable code location
	.globl _start;
_start:                   #code entry point

    mov $0x0, %ah
    mov $0x12, %al
    int $0x10

	 # indo para o segmento 0xa000 (memória grafica)
    pushw %ds
    movw $0xa000, %ax
    movw %ax, %ds 

	# Conta para setar o bit = linha * 320 + coluna
	# * 320 = depende da resolução

	# exemplo: 2 * 320 = 640 + 60 = 700
	movw $700, %bx; # Aponto pro bit na posição desejada
	mov (%bx), %al # Carrego o latch

	mov $0x3ce, %dx; # Graphics 1 and 2 Address Register
	movb $0x8, %al;	
	out %al, %dx;

	mov $0x3cf, %dx; # Bit Mask Register
	movb $0x1, %al; # Seto o bit 0
	out %al, %dx;

	mov $0x3c4, %dx; # Sequencer Address Register
	movb $0x2, %al;	# Map Mask Register
	out %al, %dx;

	mov $0x3c5, %dx; # Sequencer Data Register
	movb $0x2, %al; # Seto os 4 bits para cor
	out %al, %dx;

	movw $0x0, (%bx) # Limpo o mapa de bits

	mov $0x5, %al; # Cor esperada
	out %al, %dx; # Escrevo a cor
	movw $0xff, (%bx)  # Escrevo o mapa de bits

	popw %ds




loop_end:
	. = _start + 510      #mov to 510th byte from 0 pos
    .byte 0x55            #append boot signature
    .byte 0xaa            #append boot signature 
	int  $0x10            #interrupt the cpu now
