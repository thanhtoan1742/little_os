%ifndef RM_INIT_S
%define RM_INIT_S

rm_init:
    cli

    ; init segment register
    mov ax, cs
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax

    ; define stack
    mov bp, [rm_stack_base]
    mov sp, bp
    ret

    sti

rm_stack_base:
    dw 0x8000

%endif ; RM_INIT_S
