#include "frame_buffer.h"
#include "io.h"

void frame_buffer_write(uint index, char character, char fg, char bg) 
{
    char *frame_buffer_ptr = (char *) 0x000B8000;
    frame_buffer_ptr[index << 1] = character;
    frame_buffer_ptr[(index << 1) | 1] = ((bg & 0xF) << 4) | (fg & 0xF);
}

void frame_buffer_write_str(const char *buffer, uint length) 
{
    uint cursor_pos = frame_buffer_get_cursor_position();
    uint i = 0;
    for (; i < length && buffer[i]; ++i) {
        frame_buffer_write(cursor_pos + i, buffer[i], 
            FRAME_BUFFER_COLOR_LIGHT_GREEN, FRAME_BUFFER_COLOR_BLACK);
    }
    frame_buffer_move_cursor(cursor_pos + i);
}

/** frame_buffer_move_cursor:
 *  Moves the cursor of the framebuffer to the given position
 *
 *  @param pos The new position of the cursor
 */
void frame_buffer_move_cursor(uint pos)
{
    outb(FRAME_BUFFER_COMMAND_PORT, FRAME_BUFFER_HIGH_BYTE_COMMAND);
    outb(FRAME_BUFFER_DATA_PORT,    ((pos >> 8) & 0x00FF));
    outb(FRAME_BUFFER_COMMAND_PORT, FRAME_BUFFER_LOW_BYTE_COMMAND);
    outb(FRAME_BUFFER_DATA_PORT,    pos & 0x00FF);
}

/** frame_buffer_get_cursor_position:
 *  Return position of the cursor of the framebuffer.
 */
uint frame_buffer_get_cursor_position()
{
    uint pos = 0;
    outb(FRAME_BUFFER_COMMAND_PORT, FRAME_BUFFER_HIGH_BYTE_COMMAND);
    pos = inb(FRAME_BUFFER_DATA_PORT);
    outb(FRAME_BUFFER_COMMAND_PORT, FRAME_BUFFER_LOW_BYTE_COMMAND);
    pos = (pos << 8) | inb(FRAME_BUFFER_DATA_PORT);
    return pos;
}
