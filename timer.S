.code16                   #generate 16-bit code
.text                     #executable code location
	.globl _start;
_start:                   #code entry point
	movb $10, %bl
	call loop1

loop1:
	movb $'x' , %al;     
	movb $0x0e, %ah; 
	int  $0x10;     

	dec %bl;
	jz loop_end;
	jmp loop1;
	#fazer timer
	#movw $0, %ax;
	#int $0x1a;


loop_end:
	. = _start + 510        #mov to 510th byte from 0 pos
  .byte 0x55              	#append boot signature
  .byte 0xaa              	#append boot signature      

