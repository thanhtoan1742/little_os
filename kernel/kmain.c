#include "io.h"
#include "frame_buffer.h"
#include "serial_port.h"

int kmain()
{
    frame_buffer_put(0, 'C', FRAME_BUFFER_COLOR_LIGHT_RED, FRAME_BUFFER_COLOR_BLACK);
    frame_buffer_put(1, 'A', FRAME_BUFFER_COLOR_LIGHT_BLUE, FRAME_BUFFER_COLOR_BLACK);
    frame_buffer_put(2, 'F', FRAME_BUFFER_COLOR_LIGHT_GREEN, FRAME_BUFFER_COLOR_BLACK);
    frame_buffer_put(3, 'E', FRAME_BUFFER_COLOR_LIGHT_BROWN, FRAME_BUFFER_COLOR_BLACK);
    return 0xCAFE;
    
    frame_buffer_move_cursor(0x20);
    char message[] = "i like coffee";
    frame_buffer_write((const char*)(message), 13);

    serial_init(SERIAL_COM1_BASE);
    int i = 10;
    while (serial_received(SERIAL_COM1_BASE)) {
        frame_buffer_put(i, serial_get(SERIAL_COM1_BASE),
            FRAME_BUFFER_COLOR_LIGHT_BLUE, FRAME_BUFFER_COLOR_BLACK);
        ++i;
    }

    serial_put(SERIAL_COM1_BASE, 'C');
    serial_put(SERIAL_COM1_BASE, 'A');
    serial_put(SERIAL_COM1_BASE, 'F');
    serial_put(SERIAL_COM1_BASE, 'E');
    
    return 0xCAFE;
}
