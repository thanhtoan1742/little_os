bits 16
org 0x7C00
; ax now contains 0xAA55
; dx now contain the disk number

; setup segment registers
; mov ax, cs
; mov ds, ax
; mov es, ax
; mov fs, ax
; mov gs, ax
; mov ss, ax

; define stack
mov bp, 0x8000
mov sp, bp

call screen_init

mov ax, bootsector_load_message
call print

call load_disk

mov ax, [disk_address]
call print

jmp $


bootsector_load_message:
    db "boot sector loaded", 10, 13, 0

%include "print.s"
%include "load_disk.s"


times 0x1FE - ($ - $$) db 0
dw 0xAA55



; second sector, start at disk_address (0x9000)
disk_message:
    db "disk loaded", 10, 13, 0

times 0x300 - ($ - $$) db 0

; this instruction at disk_address + 0x300 (0x9300)
mov ah, 0x0E
mov al, 'T'
int 0x10

jmp $
