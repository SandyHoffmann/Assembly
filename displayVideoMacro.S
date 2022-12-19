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

    desenhaPonto $4, $60, $0x5; # Desenha um ponto na posição 700
    desenhaPonto $6, $60, $0xE; # Desenha um ponto na posição 700

    desenha_xadrez:
        # Modo de vídeo 320x480 - 16 cores
        # 480 colunas
        # tamanho de cada coluna = 320/16 = 20
        # tamanho do quadrado = 20x20
        # 480/20 = 24

        # Desenha o xadrez
        xor %bx, %bx; # Contador de linhas

        movb $0, %bx; # Contador de linhas
        movw $0, %cx; # Contador de colunas
        movw $0, %ax; # Contador de quadrados

        # definindo stack
        movw %sp, %bp
        movw %bx, -2(%bp)
        movw %cx, -4(%bp)
        movw %bx, -6(%bp)
        movw %ax, -8(%bp)

        loop_desenha_coluna:

            movw -2(%bp), %bx; # Carrega o contador de linhas
            movw -4(%bp), %cx; # Carrega o contador de colunas

            desenhaPonto %bx, %cx, $0x2; # Desenha um ponto na posição 700

            add $1, %cx; # Incrementa o contador de linhas

            movw %cx, -4(%bp); # Salva o contador de linhas

            cmp $32, %cx; # Verifica se o contador de colunas chegou no final
            jl loop_desenha_coluna; # Se não chegou, volta pro loop
            
        loop_desenha_linha:
                
                movw -6(%bp), %bx; # Carrega o contador de linhas
    
                add $1, %bx; # Incrementa o contador de linhas
    
                movw %bx, -6(%bp); # Salva o contador de linhas

                movw %bx, -2(%bp); # Salva o contador de linhas

                movw $1, %cx; # Contador de colunas

                movw %cx, -4(%bp); # Salva o contador de colunas

                cmp $32, %bx; # Verifica se o contador de linhas chegou no final

                jl loop_desenha_coluna; # Se não chegou, volta pro loop

                movw -8(%bp), %ax; # Carrega o contador de quadrados

                add $1, %ax; # Incrementa o contador de quadrados

                movw %ax, -8(%bp); # Salva o contador de quadrados
                
                cmp $6, %ax; # Verifica se o contador de quadrados chegou no final

                jl loop_desenha_coluna; # Se não chegou, volta pro loop


    popw %ds


loop_end:
	. = _start + 510      #mov to 510th byte from 0 pos
    .byte 0x55            #append boot signature
    .byte 0xaa            #append boot signature 
	int  $0x10            #interrupt the cpu now
