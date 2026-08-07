; =============================================
; API: io.asm
; I/O functions with conditional inclusion
; =============================================

; ---------------------------------------------
; clear_screen — clears the screen and sets
; text mode (80x25)
; Uses: BIOS INT 0x10, AH=0x00, AL=0x03
; ---------------------------------------------
%ifdef NEED_CLEAR_SCREEN
clear_screen:
    mov ah, 0x00
    mov al, 0x03
    int 0x10
    ret
%endif

; ---------------------------------------------
; print_string — prints a null-terminated string
; Input: SI = string address
; Uses: BIOS INT 0x10, AH=0x0E
; ---------------------------------------------
%ifdef NEED_PRINT_STRING
print_string:
.loop:
    lodsb               ; load byte from SI into AL
    test al, al         ; check if end of string (0)
    jz .done
    mov ah, 0x0E        ; teletype output
    int 0x10
    jmp .loop
.done:
    ret
%endif

; ---------------------------------------------
; read_key — waits for a key press
; Output: AL = ASCII code of the key
; Uses: BIOS INT 0x16, AH=0x00
; ---------------------------------------------
%ifdef NEED_READ_KEY
read_key:
    mov ah, 0x00
    int 0x16
    ret
%endif

; ---------------------------------------------
; read_and_echo_char — reads a key with console echo
; Output: AL = ASCII code
; Features: handles Enter (newline) and
; Backspace (character deletion)
; Uses: BIOS INT 0x16, INT 0x10
; ---------------------------------------------
%ifdef NEED_READ_AND_ECHO_CHAR
read_and_echo_char:
    mov ah, 0x00
    int 0x16

    cmp al, 0x0D
    je .handle_enter

    cmp al, 0x08
    je .handle_backspace

    ; Normal character: output it
    mov ah, 0x0E
    mov bh, 0x00
    int 0x10
    ret

.handle_enter:
    ; Enter: newline (CR + LF)
    mov ah, 0x0E
    mov al, 0x0D
    int 0x10
    mov al, 0x0A
    int 0x10
    ret

.handle_backspace:
    ; Backspace: delete character (space + backspace)
    mov ah, 0x0E
    mov al, 0x08
    int 0x10

    mov al, ' '
    int 0x10

    mov al, 0x08
    int 0x10
    ret
%endif