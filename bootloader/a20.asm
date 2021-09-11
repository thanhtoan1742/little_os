%ifndef A20_S
%define A20_S

[bits 16]
; Function: check_a20
;
; Purpose: to check the status of the a20 line in a completely
; self-contained state-preserving way. The function can be
; modified as necessary by removing push's at the beginning and
; their respective pop's at the end if complete self-containment
; is not required.
;
; Returns: 0 in ax if the a20 line is disabled (memory wraps
; around) 1 in ax if the a20 line is enabled (memory does not wrap
; around)
check_a20:
    pushf
    push ds
    push es
    push di
    push si

    cli

    xor ax, ax ; ax = 0
    mov es, ax

    not ax ; ax = 0xFFFF
    mov ds, ax

    mov di, 0x0500
    mov si, 0x0510

    mov al, byte [es:di]
    push ax

    mov al, byte [ds:si]
    push ax

    mov byte [es:di], 0x00
    mov byte [ds:si], 0xFF

    cmp byte [es:di], 0xFF

    pop ax
    mov byte [ds:si], al

    pop ax
    mov byte [es:di], al

    mov ax, 0
    je check_a20_exit

    mov ax, 1

    check_a20_exit:
    pop si
    pop di
    pop es
    pop ds
    popf

    sti
    ret

enable_a20:
    push ax
    call check_a20
    cmp ax, 0
    jne enable_a20_exit

    call enable_a20_keyboard

    enable_a20_exit:
    pop ax
    ret

; copied from the internet
enable_a20_keyboard:
    cli

    ; send command: disable keyboard
    call a20_wait_command
    mov al, 0xAD
    out 0x64, al

    ; send command: read from input
    call a20_wait_command
    mov al, 0xD0
    out 0x64, al

    ; read input from keyboard and save to eax
    call a20_wait_data
    in al, 0x60
    push eax

    ; send command: write to output
    call a20_wait_command
    mov al, 0xD1
    out 0x64, al

    ; write input back, with bit no.2 set
    call a20_wait_command
    pop eax
    or al, 2
    out 0x60, al

    ; send command: enable keyboard
    call a20_wait_command
    mov al, 0xAE
    out 0x64, al

    call a20_wait_command

    sti
    ret

; wait until keyboard ready for command
a20_wait_command:
    in al, 0x64
    test al, 2
    jnz a20_wait_command
    ret


; wait until keyboard ready for data
a20_wait_data:
    in al, 0x64
    test al, 1
    jz a20_wait_data
    ret

%endif ; A20_S
