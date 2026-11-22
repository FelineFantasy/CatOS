; =============================================================================
; reset.asm — system reset routines (16-bit Real Mode)
; =============================================================================

; ---------------------------------------------
; warm_reboot — sets the BIOS warm-boot flag and
; jumps to the reset vector, so the BIOS skips
; the full POST.
; ---------------------------------------------
%ifdef NEED_WARM_REBOOT
warm_reboot:
    cli
    xor ax, ax
    mov ds, ax
    mov word [0x0472], 0x1234
    jmp 0xFFFF:0x0000
%endif

; ---------------------------------------------
; cold_reboot — clears the warm-boot flag and
; jumps to the reset vector, asking the BIOS for
; a cold POST. This is not a physical power cycle.
; ---------------------------------------------
%ifdef NEED_COLD_REBOOT
cold_reboot:
    cli
    xor ax, ax
    mov ds, ax
    mov word [0x0472], 0x0000
    jmp 0xFFFF:0x0000
%endif
