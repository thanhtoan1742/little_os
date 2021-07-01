#include "io.h"
#include "frame_buffer.h"

int kmain()
{
    frame_buffer_write(0, 'C', FRAME_BUFFER_COLOR_LIGHT_RED, FRAME_BUFFER_COLOR_BLACK);
    frame_buffer_write(1, 'A', FRAME_BUFFER_COLOR_LIGHT_BLUE, FRAME_BUFFER_COLOR_BLACK);
    frame_buffer_write(2, 'F', FRAME_BUFFER_COLOR_LIGHT_GREEN, FRAME_BUFFER_COLOR_BLACK);
    frame_buffer_write(3, 'E', FRAME_BUFFER_COLOR_LIGHT_BROWN, FRAME_BUFFER_COLOR_BLACK);
    
    // frame_buffer_move_cursor(0x20);
    char message[14];
    message[0] = 'I';
    message[1] = ' ';
    message[2] = 'l';
    message[3] = 'i';
    message[4] = 'k';
    message[5] = 'e';
    message[6] = ' ';
    message[7] = 'c';
    message[8] = 'o';
    message[9] = 'f';
    message[10] = 'f';
    message[11] = 'e';
    message[12] = 'e';
    message[13] = '\0';
    frame_buffer_write_str((const char*)(message), 13);

    return 0xCAFE;
}
