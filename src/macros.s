
# print a char macro
.macro print_char char
    movb $\char, %al
    int $0x10
.endm
