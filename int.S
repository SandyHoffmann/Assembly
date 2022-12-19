.code16
.text
.globl _start

_start:
    jmp _boot

.macro mWriteString str
    leaw  \str, %si
    call   WriteString
.endm

.func WriteString
WriteString:
    lodsb
    orb %al, %al
    jz WriteString_done

    movb $0xe, %ah
    movw $9, %bx
    int $0x10

    jmp WriteString

    WriteString_done:
    retw
.endfunc

msgHello: .asciz "Hello in my boot loader!\n\r"

myInterrupt:
    mWriteString msgHello
    hlt

// Смещение вектора 0x65
.set off_x65, 0x65*4
old_off_x65: .long 0
old_seg_x65: .long 0

_boot:
    cli

    movw $0x07C0, %ax
    movw %ax, %ds
    movw %ax, %ss
    movw %ax, %sp

    movw $0x0, %ax
    movw %ax, %es

    // Сохраняем старый вектор
    movw %es:off_x65, %ax
    movw %ax, old_off_x65
    movw %es:off_x65 + 2, %ax
    movw %ax, old_seg_x65

    // Записываем новый вектор
    movw $myInterrupt, %ax
    movw %ax, %es:off_x65
    push %ds
    pop %ax
    movw %ax, %es:off_x65+2

    sti

    int $0x65

    . = _start + 510
    .byte 0x55
    .byte 0xAA
