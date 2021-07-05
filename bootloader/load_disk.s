load_disk:
    pusha

    mov ah, 0x02
    mov al, 1       ; read 1 sector
    ; dl is automaticly setted up
    ; mov dl, 0x80    ; first hard drive (this drive)
    mov dh, 0x00    ; head 0
    mov ch, 0x00    ; cylinder 0
    mov cl, 1       ; 2nd sector

    ; read to ES:BX
    mov bx, [disk_address]
    int 0x13

    jc disk_error

    popa
    ret

disk_error:
    push ax

    mov ax, disk_error_message
    call print

    mov ah, 0x01
    int 0x13
    call print_number

    mov ah, 0x10
    mov al, 10
    int 0x13

    pop ax
    ret

disk_error_message:
    db "disk error", 10, 13, 0

disk_address:
    dw 0x9000
