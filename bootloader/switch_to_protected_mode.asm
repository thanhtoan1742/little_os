%ifndef SWITCH_TO_PROTECTED_MODE_S
%define SWITCH_TO_PROTECTED_MODE_S

%include "gdt.asm"
%include "idt.asm"
%include "a20.asm"
%include "load_disk.asm"

; TODO: need investigation
PM_STACK_BASE equ 0x9000
KERNEL_ADDRESS equ 0x100000

[bits 16]
switch_to_pm:

call enable_a20

cli
; switch to 32 bits protected mode
mov eax, cr0
or eax, 0x1
mov cr0, eax

; flush prefetched queue
jmp pm_init

pm_init:
lgdt [gdt_descriptor]   ; load gdt
lidt [idt]   			; load idt

mov ebp, PM_STACK_BASE
mov esp, ebp

mov ax, DATA_SEG
mov ds, ax
mov es, ax
mov fs, ax
mov gs, ax
mov ss, ax

; jump back to begin protected mode
jmp CODE_SEG:PM_BEGIN

[bits 32]
PM_BEGIN:
mov eax, KERNEL_ADDRESS
jmp eax

%endif ; SWITCH_TO_PROTECTED_MODE_S
