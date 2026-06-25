[org 0x7c00]

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

start:
    PRINT welcome
    PRINT author

hang:
	cli
    hlt
    jmp hang

welcome db "Welcome to my OS!", 0x0D, 0x0A, 0
author  db "Created by FelineFantasy", 0x0D, 0x0A, 0

times 510 - ($ - $$) db 0
dw 0xaa55