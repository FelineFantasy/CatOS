[org 0x1000]

kernel_start:

kernel_main:
    cld
    xor ax, ax
    mov ds, ax
    mov es, ax

    mov ss, ax
    mov sp, 0x7F00

    call clear_screen

    mov si, banner
    call print_string

main_loop:
    mov si, menu
    call print_string

    call read_key
    push ax                 ; newline clobbers AL — keep the key
    call newline
    pop ax

    cmp al, '1'
    je .warm
    cmp al, '2'
    je .cold
    cmp al, '3'
    je .halt
    cmp al, 'h'
    je .help
    cmp al, 'H'
    je .help

    mov si, msg_unknown
    call print_string
    jmp main_loop

.help:
    mov si, msg_help
    call print_string
    jmp main_loop

.warm:
    mov si, msg_warm
    call print_string
    call warm_reboot
    jmp .halt_loop          ; safety net if the reset did not happen

.cold:
    mov si, msg_cold
    call print_string
    call cold_reboot
    jmp .halt_loop          ; safety net if the reset did not happen

.halt:
    mov si, msg_halt
    call print_string
.halt_loop:
    cli
    hlt
    jmp .halt_loop

banner db "  /\_/\   CatOS", 0x0D, 0x0A
       db " ( o.o )  reset test build", 0x0D, 0x0A
       db "  > ^ <", 0x0D, 0x0A, 0x0D, 0x0A, 0

menu db "1 - warm reboot", 0x0D, 0x0A
     db "2 - cold reboot", 0x0D, 0x0A
     db "3 - halt", 0x0D, 0x0A
     db "h - help", 0x0D, 0x0A, 0x0D, 0x0A
     db "> ", 0

msg_help db "warm reboot sets the BIOS warm-boot flag,", 0x0D, 0x0A
         db "cold reboot clears it (cold POST request).", 0x0D, 0x0A, 0

msg_unknown db "unknown key", 0x0D, 0x0A, 0

msg_warm db "warm rebooting...", 0x0D, 0x0A, 0
msg_cold db "cold rebooting...", 0x0D, 0x0A, 0
msg_halt db "system halted", 0x0D, 0x0A, 0

%define NEED_CLEAR_SCREEN
%define NEED_PRINT_STRING
%define NEED_NEWLINE
%define NEED_READ_KEY
%include "src/api/io.asm"

%define NEED_WARM_REBOOT
%define NEED_COLD_REBOOT
%include "src/api/reset.asm"

times 2048 - ($ - kernel_start) db 0
