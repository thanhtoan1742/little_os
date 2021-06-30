#include "io.h"
#include "frame_buffer.h"

int kmain()
{
    frame_buffer_write(0, 'C', FRAME_BUFFER_COLOR_LIGHT_RED, FRAME_BUFFER_COLOR_BLACK);
    frame_buffer_write(1, 'A', FRAME_BUFFER_COLOR_LIGHT_BLUE, FRAME_BUFFER_COLOR_BLACK);
    frame_buffer_write(2, 'F', FRAME_BUFFER_COLOR_LIGHT_GREEN, FRAME_BUFFER_COLOR_BLACK);
    frame_buffer_write(3, 'E', FRAME_BUFFER_COLOR_LIGHT_BROWN, FRAME_BUFFER_COLOR_BLACK);

    return 0xCAFE;
}
