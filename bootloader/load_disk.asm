%ifndef LOAD_DISK_S
%define LOAD_DISK_S

%include "rm_screen.asm"

[bits 16]
DISK_ADDRESS equ 0x9000
N_SECTOR_TO_READ equ 100

DISK_ERROR_MESSAGE:
    db "disk error", 10, 13, 0


load_disk:
    pusha

    mov ah, 0x02
    mov al, N_SECTOR_TO_READ
    ; dl is automaticly setted up
    ; mov dl, 0x80    ; first hard drive (this drive)
    mov dh, 0x00    ; head 0
    mov ch, 0x00    ; cylinder 0
    mov cl, 2       ; 2nd sector

    ; read to ES:BX
    mov bx, DISK_ADDRESS
    int 0x13

    jc disk_error

    popa
    ret

disk_error:
    push ax

    mov ax, DISK_ERROR_MESSAGE
    call rm_print

    mov ah, 0x01
    int 0x13
    call rm_print_hex

    mov ah, 0x10
    mov al, 10
    int 0x13

    pop ax
    ret

%endif ; LOAD_DISK_S
