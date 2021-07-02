#include "serial_port.h"

#include "common.h"

int serial_init(uint port)
{
    outb(port + 1, 0x00);    // Disable all interrupts
    outb(port + 3, 0x80);    // Enable DLAB (set baud rate divisor)
    outb(port + 0, 0x03);    // Set divisor to 3 (lo byte) 38400 baud
    outb(port + 1, 0x00);    //                  (hi byte)
    outb(port + 3, 0x03);    // 8 bits, no parity, one stop bit
    outb(port + 2, 0xC7);    // Enable FIFO, clear them, with 14-byte threshold
    outb(port + 4, 0x0B);    // IRQs enabled, RTS/DSR set
    outb(port + 4, 0x1E);    // Set in loopback mode, test the serial chip

    // Check if serial is faulty (i.e: not same byte as sent)
    outb(port + 0, 0xAE);    // Test serial chip (send byte 0xAE and check if serial returns same byte)
    int ret = inb(port + 0) & 0xFF;
    if (ret != 0xAE)
    {
        return ret;
    }

    // If serial is not faulty set it in normal operation mode
    // (not-loopback with IRQs enabled and OUT#1 and OUT#2 bits enabled)
    outb(port + 4, 0x0F);
    return 0;	
}

int serial_received(uint port)
{
    return inb(port + 5) & 1;
}

char serial_get(uint port)
{
    while (serial_received(port) == 0) ;
    return inb(port);
}

int serial_transmit_empty(uint port)
{
   return inb(port + 5) & 0x20;
}
 
void serial_put(uint port, char data) 
{
    while (serial_transmit_empty(port) == 0);
    outb(port, data);
}

void serial_write(uint port, const char* data, uint length) 
{
    uint i = 0;
    for (; i < length && data[i]; ++i)
        serial_put(port, data[i]);
}