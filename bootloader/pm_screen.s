%ifndef PM_SCREEN_S
%define PM_SCREEN_S

[bits 32]
VIDEO_MEMORY equ 0xB800

pm_print:
    pusha
    mov edx, VIDEO_MEMORY

    pm_print_loop:
        mov bl, [eax]
        cmp bl, 0
        je pm_print_end

        mov bh, 0x0B
        mov [edx], bx

        add ebx, 1
        add edx, 2
        jmp pm_print_loop

    pm_print_end:
    popa
    ret

%endif ; PM_SCREEN_S
