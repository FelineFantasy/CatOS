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
    mov al, 1
    mov ch, 0
    mov cl, 2
    mov dh, 0
    mov dl, [boot_drive]
    mov bx, 0x1000
    int 0x13
    jc disk_error

    jmp 0x0000:0x1000

disk_error:
    mov ah, 0x00
    mov al, 0x03
    int 0x10

    mov si, panic_cat
    call print_string
    jmp $

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

boot_drive db 0

panic_cat:
    db "     /\_/\", 0x0D, 0x0A
    db "    ( o.o ) > Disk read error!", 0x0D, 0x0A
    db "     > ^ <", 0x0D, 0x0A, 0

times 510 - ($ - $$) db 0
dw 0xaa55