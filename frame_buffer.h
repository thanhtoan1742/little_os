#ifndef FRAME_BUFFER_H_
#define FRAME_BUFFER_H_

#include "common.h"

// Colors
#define FRAME_BUFFER_COLOR_BLACK            0x0
#define FRAME_BUFFER_COLOR_BLUE 	        0x1
#define FRAME_BUFFER_COLOR_GREEN 	        0x2
#define FRAME_BUFFER_COLOR_CYAN 	        0x3
#define FRAME_BUFFER_COLOR_RED 	            0x4
#define FRAME_BUFFER_COLOR_MAGENTA 	        0x5
#define FRAME_BUFFER_COLOR_BROWN 	        0x6
#define FRAME_BUFFER_COLOR_LIGHT_GREY 	    0x7
#define FRAME_BUFFER_COLOR_DARK_GREY 	    0x8
#define FRAME_BUFFER_COLOR_LIGHT_BLUE 	    0x9
#define FRAME_BUFFER_COLOR_LIGHT_GREEN 	    0xA
#define FRAME_BUFFER_COLOR_LIGHT_CYAN 	    0xB
#define FRAME_BUFFER_COLOR_LIGHT_RED 	    0xC
#define FRAME_BUFFER_COLOR_LIGHT_MAGENTA 	0xD
#define FRAME_BUFFER_COLOR_LIGHT_BROWN 	    0xE
#define FRAME_BUFFER_COLOR_WHITE 	        0xF

// The I/O ports
#define FRAME_BUFFER_COMMAND_PORT           0x3D4
#define FRAME_BUFFER_DATA_PORT              0x3D5

// The I/O port commands
#define FRAME_BUFFER_HIGH_BYTE_COMMAND      14
#define FRAME_BUFFER_LOW_BYTE_COMMAND       15

void frame_buffer_write(ushort index, char character,
    char foreground_color, char back_ground_color);

void frame_buffer_write_str(const char* buffer, ushort length);

void frame_buffer_move_cursor(ushort pos);

ushort frame_buffer_get_cursor_position();

#endif // FRAME_BUFFER_H_
