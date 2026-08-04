kernel_start:

[org 0x1000]

%define NEED_CLEAR_SCREEN
%define NEED_PRINT_STRING
%define NEED_READ_KEY
%include "src/api/io.asm"

kernel_main:
    cld
    xor ax, ax
    mov ds, ax
    mov es, ax

    mov ss, ax
    mov sp, 0x0F00

    call clear_screen

    mov si, welcome
    call print_string

    mov si, author
    call print_string

    mov si, press_key
    call print_string

    call read_key

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

times 2048 - ($ - kernel_start) db 0