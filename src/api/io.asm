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
