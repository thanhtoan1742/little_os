ENTRY(loader)               /* the name of the entry label */

SECTIONS 
{
    . = 1M;

    .text ALIGN(4K) :       /* align at 4 KB */
    {
        *(.text)            /* all text sections from all files */
    }

    .rodata ALIGN(4K) :     /* align at 4 KB */
    {
        *(.rodata)         /* all read-only data sections from all files */
    }

    .data ALIGN(4K) :       /* align at 4 KB */
    {
        *(.data)            /* all data sections from all files */
    }

    .bss ALIGN(4K) :        /* align at 4 KB */
    {
        *(.bss)             /* all bss sections from all files */
    }
}
