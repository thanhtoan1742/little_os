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
mov ax, bootsector_load_message
call rm_print

call enable_a20
jmp $

call switch_to_pm

[bits 32]
pm_begin:

mov eax, pm_load_message
call pm_print
jmp $

[bits 16]





bootsector_load_message:
    db "boot sector loaded", 10, 13, 0

pm_load_message:
    db "switched to protected mode", 10, 13, 0

%include "rm_screen.s"
; %include "load_disk.s"
%include "a20.s"
%include "switch_to_protected_mode.s"
%include "pm_screen.s"

times 0x1FE - ($ - $$) db 0
dw 0xAA55


; second sector, start at disk_address (0x9000)
disk_message:
    db "disk loaded", 1, 13, 0
