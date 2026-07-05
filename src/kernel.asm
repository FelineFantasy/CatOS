[org 0x1000]

%macro PRINT 1
    mov si, %1
%%loop:
    lodsb
    test al, al
    jz %%done
    mov ah, 0x0E
    int 0x10
    jmp %%loop
%%done:
%endmacro

%macro CLEAR_SCREEN 0
    mov ah, 0x00
    mov al, 0x03
    int 0x10
%endmacro

kernel_main:
    xor ax, ax
    mov ds, ax
    mov es, ax

    CLEAR_SCREEN

    PRINT welcome
    PRINT author
    PRINT press_key

    mov ah, 0x00
    int 0x16

    CLEAR_SCREEN

hang:
    cli
    hlt
    jmp hang

welcome   db "Welcome to my OS!", 0x0D, 0x0A, 0
author    db "Created by FelineFantasy", 0x0D, 0x0A, 0
press_key db 0x0D, 0x0A, "Press any key to continue...", 0x0D, 0x0A, 0