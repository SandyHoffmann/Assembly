.code16

.text 

.globl _start


_start:

    pushw %ds
    movw $0xa0000, %ax
    movw %ax, %ds


    # 1
    movw $0x03c0, %dx 
    mov $0x10, %al 
    out %al, %dx

    movw $0x03c0, %dx 
    mov $0x41, %al 
    out %al, %dx

    #2
    movw $0x03c0, %dx 
    mov $0x11, %al 
    out %al, %dx

    movw $0x03c0, %dx 
    mov $0x00, %al 
    out %al, %dx

    #3
    movw $0x03c0, %dx 
    mov $0x12, %al 
    out %al, %dx

    movw $0x03c0, %dx 
    mov $0x0F, %al 
    out %al, %dx

    #4
    movw $0x03c0, %dx 
    mov $0x13, %al 
    out %al, %dx

    movw $0x03c0, %dx 
    mov $0x00, %al 
    out %al, %dx
    
    #5
    movw $0x03c0, %dx 
    mov $0x14, %al 
    out %al, %dx

    movw $0x03c0, %dx 
    mov $0x00, %al 
    out %al, %dx

    # 6 confuso
    movw $0x03c2, %dx 
    mov $0x63, %al 
    out %al, %dx

    #7
    movw $0x03c4, %dx 
    mov $0x01, %al 
    out %al, %dx

    movw $0x03c5, %dx 
    mov $0x01, %al 
    out %al, %dx

    #8
    movw $0x03c4, %dx 
    mov $0x03, %al 
    out %al, %dx

    movw $0x03c5, %dx 
    mov $0x00, %al 
    out %al, %dx

    #9
    movw $0x03c4, %dx 
    mov $0x04, %al 
    out %al, %dx

    movw $0x03c5, %dx 
    mov $0x0e, %al 
    out %al, %dx

    #10
    movw $0x03ce, %dx 
    mov $0x05, %al 
    out %al, %dx

    movw $0x03cf, %dx 
    mov $0x40, %al 
    out %al, %dx

    #11
    movw $0x03ce, %dx 
    mov $0x06, %al 
    out %al, %dx

    movw $0x03cf, %dx 
    mov $0x05, %al 
    out %al, %dx

    #12 ???
    movw $0x03d4, %dx 
    mov $0x00, %al 
    out %al, %dx

    movw $0x03d5, %dx 
    mov $0x5f, %al 
    out %al, %dx

    #13 ???
    movw $0x03d4, %dx 
    mov $0x01, %al 
    out %al, %dx

    movw $0x03d5, %dx 
    mov $0x4f, %al 
    out %al, %dx

    #14 ???
    movw $0x03d4, %dx 
    mov $0x02, %al 
    out %al, %dx

    movw $0x03d5, %dx 
    mov $0x50, %al 
    out %al, %dx

    #15 ???
    movw $0x03d4, %dx 
    mov $0x03, %al 
    out %al, %dx

    movw $0x03d5, %dx 
    mov $0x84, %al 
    out %al, %dx

    #16 ???
    movw $0x03d4, %dx 
    mov $0x04, %al 
    out %al, %dx

    movw $0x03d5, %dx 
    mov $0x54, %al 
    out %al, %dx

    #17 ???
    movw $0x03d4, %dx 
    mov $0x05, %al 
    out %al, %dx

    movw $0x03d5, %dx 
    mov $0x80, %al 
    out %al, %dx

    #18 ???
    movw $0x03d4, %dx 
    mov $0x06, %al 
    out %al, %dx

    movw $0x03d5, %dx 
    mov $0xbf, %al 
    out %al, %dx

    #19 ???
    movw $0x03d4, %dx 
    mov $0x07, %al 
    out %al, %dx

    movw $0x03d5, %dx 
    mov $0x1f, %al 
    out %al, %dx

    #20 ???
    movw $0x03d4, %dx 
    mov $0x08, %al 
    out %al, %dx

    movw $0x03d5, %dx 
    mov $0x00, %al 
    out %al, %dx

    #21 ???
    movw $0x03d4, %dx 
    mov $0x09, %al 
    out %al, %dx

    movw $0x03d5, %dx 
    mov $0x41, %al 
    out %al, %dx

    #22 ???
    movw $0x03d4, %dx 
    mov $0x10, %al 
    out %al, %dx

    movw $0x03d5, %dx 
    mov $0x9c, %al 
    out %al, %dx

    #23 ???
    movw $0x03d4, %dx 
    mov $0x11, %al 
    out %al, %dx

    movw $0x03d5, %dx 
    mov $0x0e, %al 
    out %al, %dx

    #24 ???
    movw $0x03d4, %dx 
    mov $0x12, %al 
    out %al, %dx

    movw $0x03d5, %dx 
    mov $0x8f, %al 
    out %al, %dx

    #25 ???
    movw $0x03d4, %dx 
    mov $0x13, %al 
    out %al, %dx

    movw $0x03d5, %dx 
    mov $0x28, %al 
    out %al, %dx

    #26 ???
    movw $0x03d4, %dx 
    mov $0x14, %al 
    out %al, %dx

    movw $0x03d5, %dx 
    mov $0x40, %al 
    out %al, %dx

    #27 ???
    movw $0x03d4, %dx 
    mov $0x15, %al 
    out %al, %dx

    movw $0x03d5, %dx 
    mov $0x96, %al 
    out %al, %dx

    #28 ???
    movw $0x03d4, %dx 
    mov $0x16, %al 
    out %al, %dx

    movw $0x03d5, %dx 
    mov $0xb9, %al 
    out %al, %dx

    #29 ???
    movw $0x03d4, %dx 
    mov $0x17, %al 
    out %al, %dx

    movw $0x03d5, %dx 
    mov $0xa3, %al 
    out %al, %dx

    popw %ds

    movw $0xb800, %ax
    movw %ax, %ds

    movw $818, %bx

    movb $65, %al
    movb %al, (%bx)

    inc %bx

    movb $0b00110001, %ah
    movb %ah, (%bx)


num_magico:
    . = _start + 510
    .byte 0x55
    .byte 0xaa