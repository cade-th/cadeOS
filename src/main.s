.include "src/macros.s"

.code16
.section .text
.globl _start

_start:
    movb $0x0E, %ah
    print_char 'H'
    # ... (other print_char calls)

    # Set up disk read using int 0x13, function 0x02
    # We'll read one sector to 0x8000 in memory
    movw $0x8000, %ax
    movw %ax, %es
    xor %bx, %bx   # offset
    movb $0x02, %ah
    movb $0x01, %al  # number of sectors
    xor %ch, %ch  # cylinder number
    xor %cl, %cl  # sector number
    inc %cl      # sector numbers start with 1
    xor %dh, %dh # head number
    int $0x13

    # Jump to new code
    jmp 0x8000

    .fill 510 - (. - _start), 1, 0
    .word 0xAA55

