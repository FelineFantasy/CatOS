[org 0x1000]

kernel_main:
    cld

    xor ax, ax
    mov ds, ax
    mov es, ax

    call clear_screen

    mov si, welcome
    call print_string

    mov si, author
    call print_string

    mov si, press_key
    call print_string

    mov ah, 0x00
    int 0x16

    call clear_screen

    mov si, stub_msg
    call print_string

hang:
    cli
    hlt
    jmp hang

welcome   db "Welcome to my OS!", 0x0D, 0x0A, 0
author    db "Created by FelineFantasy", 0x0D, 0x0A, 0
press_key db 0x0D, 0x0A, "Press any key to continue...", 0x0D, 0x0A, 0
stub_msg  db "soon...", 0x0D, 0x0A, 0

%include "src/functions.asm"