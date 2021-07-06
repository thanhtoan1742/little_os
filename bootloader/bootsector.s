[bits 16]
[org 0x7C00]
; BIOS loaded dx with the disk number

call rm_init
call rm_screen_init

mov ax, bootsector_load_message
call rm_print

call enable_a20

; jmp $

call switch_to_pm

[bits 32]
BEGIN_PM:
jmp $




bootsector_load_message:
    db "boot sector loaded", 10, 13, 0

%include "rm_init.s"
%include "rm_screen.s"
%include "load_disk.s"
%include "a20.s"
%include "switch_to_protected_mode.s"

times 0x1FE - ($ - $$) db 0
dw 0xAA55


; second sector, start at disk_address (0x9000)
disk_message:
    db "disk loaded", 1, 13, 0
