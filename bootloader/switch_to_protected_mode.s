%ifndef SWITCH_TO_PROTECTED_MODE_S
%define SWITCH_TO_PROTECTED_MODE_S

switch_to_protected_mode:
cli                     ; disable all interupt
lgdt [gdt_descriptor]   ; load gdt


; switch to 32 bits protected mode
mov eax, cr0
or eax, 0x1
mov cr0, eax

jmp CODE_SEG:init_protected_mode

[bits 32]
init_protected_mode:
mov ax, DATA_SEG
mov dx, ax
mov ss, ax
mov es, ax
mov fs, ax
mov gs, ax

mov ebp, 0x80000
mov esp, ebp

call begin_protected_mode

%include "gdt.s"

%endif ; SWITCH_TO_PROTECTED_MODE_S
