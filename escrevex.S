.code16                   #generate 16-bit code
.text                     #executable code location
	.globl _start;
_start:                   #code entry point

	push %ds;               #save data segment
	sub %ax, %ax;           #zero out %ax
	push %ax;               #push 0 onto stack

	mov $16, %ax;           #set %ax to 16
	mov %ax, %ds;           #set data segment to 0
	assume %ds:16;      #set data segment to 16-bit

loop1:
	movb $'y' , %al;       #character to print
	movb $0x0e, %ah;       #bios service code to print
	int  $0x10;     #interrupt 0x10 (video interrupt)

	dec %bl;
	jg loop1;
	jmp loop_end;


loop_end:
	. = _start + 510      #mov to 510th byte from 0 pos
    .byte 0x55            #append boot signature
    .byte 0xaa            #append boot signature 
	int  $0x10            #interrupt the cpu now
