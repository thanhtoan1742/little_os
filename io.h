#ifndef INCLUDE_IO_H
#define INCLUDE_IO_H

#include "common.h"

/** outb:
 *  Sends the given data to the given I/O port. Defined in io.s
 *
 *  @param port The I/O port to send the data to
 *  @param data The data to send to the I/O port
 */
void outb(uint port, char data);


/** inb:
 *  Receives the given data to the given I/O port. Defined in io.s
 *
 *  @param port The I/O port to send the data to
 */
char inb(uint port);

#endif /* INCLUDE_IO_H */