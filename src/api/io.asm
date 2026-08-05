%ifdef NEED_CLEAR_SCREEN
clear_screen:
    mov ah, 0x00
    mov al, 0x03
    int 0x10
    ret
%endif

%ifdef NEED_PRINT_STRING
print_string:
.loop:
    lodsb
    test al, al
    jz .done
    mov ah, 0x0E
    int 0x10
    jmp .loop
.done:
    ret
%endif

%ifdef NEED_READ_KEY
read_key:
    mov ah, 0x00
    int 0x16
    ret
%endif

%ifdef NEED_READ_AND_ECHO_CHAR
read_and_echo_char:
    mov ah, 0x00
    int 0x16

    cmp al, 0x0D
    je .handle_enter

    cmp al, 0x08
    je .handle_backspace

    mov ah, 0x0E
    mov bh, 0x00
    int 0x10
    ret

.handle_enter:
    mov ah, 0x0E
    mov al, 0x0D
    int 0x10
    mov al, 0x0A
    int 0x10
    ret

.handle_backspace:
    mov ah, 0x0E
    mov al, 0x08
    int 0x10

    mov al, ' '
    int 0x10

    mov al, 0x08
    int 0x10
    ret
%endif