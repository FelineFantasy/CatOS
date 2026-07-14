print_string:
.print_loop:
    lodsb
    test al, al
    jz .done
    mov ah, 0x0E
    int 0x10
    jmp .print_loop
.done:
    ret

clear_screen:
    mov ah, 0x00
    mov al, 0x03
    int 0x10
    ret