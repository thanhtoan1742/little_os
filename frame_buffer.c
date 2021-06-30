#include "frame_buffer.h"

#include "io.h"

void frame_buffer_write(int index, char character, char fg, char bg) 
{
    char *frame_buffer_ptr = (char *) 0x000B8000;
    frame_buffer_ptr[index << 1] = character;
    frame_buffer_ptr[(index << 1) | 1] = ((bg & 0xF) << 4) | (fg & 0xF);
}

void frame_buffer_move_cursor(unsigned short pos)
{
    outb(FRAME_BUFFER_COMMAND_PORT, FRAME_BUFFER_HIGH_BYTE_COMMAND);
    outb(FRAME_BUFFER_DATA_PORT,    ((pos >> 8) & 0x00FF));
    outb(FRAME_BUFFER_COMMAND_PORT, FRAME_BUFFER_LOW_BYTE_COMMAND);
    outb(FRAME_BUFFER_DATA_PORT,    pos & 0x00FF);
}
