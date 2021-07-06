%ifndef SWITCH_TO_PROTECTED_MODE_S
%define SWITCH_TO_PROTECTED_MODE_S

%include "gdt.s"

PM_STACK_BASE equ 0x90000

[bits 16]
switch_to_pm:
cli                     ; disable all interupt
lgdt [gdt_descriptor]   ; load gdt


; switch to 32 bits protected mode
mov eax, cr0
or eax, 0x1
mov cr0, eax

; flush prefetched queue
jmp CODE_SEG:pm_init
nop
nop

[bits 32]
pm_init:
mov ax, DATA_SEG
mov dx, ax
mov ss, ax
mov es, ax
mov fs, ax
mov gs, ax

mov ebp, PM_STACK_BASE
mov esp, ebp

; jump back to begin protected mode
call pm_begin


%endif ; SWITCH_TO_PROTECTED_MODE_S
