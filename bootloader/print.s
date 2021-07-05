print:
    push si
    push ax

    mov si, ax
    mov ah, 0x0E
    print_loop:
        lodsb
        test al, al
        jz end_print_loop
        int 0x10
        jmp print_loop
    end_print_loop:

    pop ax
    pop si
    ret

print_number:
    push bx
    mov bx, ax

    ; print '0x'
    mov ah, 0x0E
    mov al, '0'
    int 0x10
    mov al, 'x'
    int 0x10

    ; first 4 bits
    mov al, bh
    shr al, 4
    call hex_char
    int 0x10

    ; second 4 bits
    mov al, bh
    call hex_char
    int 0x10

    ; third 4 bits
    mov al, bl
    shr al, 4
    call hex_char
    int 0x10

    ; last 4 bits
    mov al, bl
    call hex_char
    int 0x10

    mov al, ' '
    int 0x10

    pop bx
    ret

hex_char:
    and al, 0x0F
    add al, '0'
    cmp al, '9'
    jle end_hex_char
    add al, 7
    end_hex_char:
    ret

screen_init:
    pusha
    ; Set background and foreground colour
    mov ah, 0x06    ; Clear / scroll screen up function
    xor al, al      ; Number of lines by which to scroll up
                    ; (0x00 = clear entire window)
    xor cx, cx
    mov dx, 0x184F
    mov bh, 0x0B
    int 0x10

    ; move cursor to 0th row, 0th column, 0th page
    mov ah, 0x02
    xor bh, bh
    xor dx, dx
    int 0x10

    popa
    ret
