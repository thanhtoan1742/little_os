[org 0x7C00]
[bits 16]
; BIOS loaded dl with the drive number

RM_STACK_BASE equ 0x8000

cli
; init segment register
mov ax, cs
mov ds, ax
mov es, ax
mov fs, ax
mov gs, ax
mov ss, ax

; define stack
mov bp, RM_STACK_BASE
mov sp, bp

sti

call rm_screen_init
mov ax, BOOTSECTOR_LOAD_MESSAGE
call rm_print

call load_disk

jmp switch_to_pm

BOOTSECTOR_LOAD_MESSAGE:
    db "boot sector loaded", 10, 13, 0

%include "rm_screen.asm"
%include "load_disk.asm"
%include "switch_to_protected_mode.asm"

times 0x1FE - ($ - $$) db 0
dw 0xAA55
