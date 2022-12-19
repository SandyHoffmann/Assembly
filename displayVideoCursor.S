.code16                   #generate 16-bit code
.text                     #executable code location
	.globl _start;
_start:                   #code entry point

    .macro desenhaPonto linha, coluna, cor

        # Calculando a posição do bit
        # Conta = (linha * 320) + coluna
        # 320 = Depende do modo de vídeo

        movw \linha, %ax; # Carrego a linha
        movw $320, %bx; # Carrego o valor de 320
        mul %bx; # Multiplico a linha por 320
        movw %ax, %bx; # Salvo o resultado

        movw \coluna, %ax; # Carrego a coluna
        add %ax, %bx; # Adiciono a coluna ao resultado
        movw %bx, %ax; # Salvo o resultado

        movw %ax, %bx; # Aponto pro bit na posição desejada
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

        mov \cor, %al; # Cor esperada
        out %al, %dx; # Escrevo a cor
        movw $0xff, (%bx)  # Escrevo o mapa de bits
    .endm

    mov $0x0, %ah
    mov $0x12, %al
    int $0x10

    movw $1, %ax
    int $0x33


    loop:
        movw $0x3, %ax
        int $0x33
        cmpw $0x1, %ax
        jne loop
        desenhaPonto $1, $60, $0xA; # Desenha um ponto na posição 700
        jmp loop

	 # indo para o segmento 0xa000 (memória grafica)
    pushw %ds
    movw $0xa000, %ax
    movw %ax, %ds 

    # Cores disponíveis
    # 0x0 = Preto
    # 0x1 = Azul
    # 0x2 = Verde
    # 0x3 = Ciano
    # 0x4 = Vermelho
    # 0x5 = Magenta
    # 0x6 = Marrom
    # 0x7 = Cinza
    # 0x8 = Cinza escuro
    # 0x9 = Azul claro
    # 0xA = Verde claro
    # 0xB = Ciano claro
    # 0xC = Vermelho claro
    # 0xD = Magenta claro
    # 0xE = Amarelo
    # 0xF = Branco

    desenhaPonto $1, $60, $0xA; # Desenha um ponto na posição 700
    desenhaPonto $1, $61, $0xA; # Desenha um ponto na posição 700

    #cursor


    #posicao cursor
    movb $0x2, %ah
    movw $0x5, %dx
    movb $0x0a, %dl
    movb $0x0, %bh
    int $0x33


    desenhaPonto %cx, %dx, $0xA; # Desenha um ponto na posição 700



    popw %ds


loop_end:
	. = _start + 510      #mov to 510th byte from 0 pos
    .byte 0x55            #append boot signature
    .byte 0xaa            #append boot signature 
	int  $0x10            #interrupt the cpu now
