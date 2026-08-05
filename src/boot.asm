[org 0x7c00]

start:
    mov [boot_drive], dl

    cli
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7C00
    sti

    mov ah, 0x02
    mov al, 4
    mov ch, 0
    mov cl, 2
    mov dh, 0
    mov dl, [boot_drive]
    mov bx, 0x1000
    int 0x13
    jc disk_error

    jmp 0x0000:0x1000

disk_error:
    mov si, panic_cat
    call print_string

.halt_system:
    cli
    hlt
    jmp .halt_system

boot_drive db 0
panic_cat  db 0x0D, 0x0A, "  /\_/\  ", 0x0D, 0x0A, " ( o.o ) > Disk read error!", 0x0D, 0x0A, "  > ^ <  ", 0x0D, 0x0A, 0

%define NEED_PRINT_STRING
%include "src/api/io.asm"

times 510 - ($ - $$) db 0
dw 0xAA55