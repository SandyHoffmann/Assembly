#include <fcntl.h>
#include <sys/unistd.h>

#include <sys/io.h>
#include <sys/ioctl.h>
#include <linux/parport.h>
#include <linux/ppdev.h>

#include <stdio.h>
#include <stdlib.h>

#define BASEPORT 0x60 /* lp1 */

int main()
{
 /* Get access to the ports */
 if (ioperm(BASEPORT, 5, 1)) {perror("ioperm"); exit(1);}
 /* Set the data signals (D0−7) of the port to all low (0) */
 outb(0xF4, 0x64);
 outb(0xF3, 0x60);
 printf("status: %d\n", inb(0xE9));

 outb(0xF5, 0x64);
//  outb(0, BASEPORT);
 /* Sleep for a while (100 ms) */
 usleep(100000);
 /* Read from the status port (BASE+1) and display the result */
 printf("status: %d\n", inb(BASEPORT + 1));
 /* We don't need the ports anymore */
 if (ioperm(BASEPORT, 3, 0)) {perror("ioperm"); exit(1);}
 exit(0);
}




// int main()
// {
// printf("comecou ");

// ioperm(0x60, 5, 1);

// printf(" 1 - Escrever no port 0x60 ");
// unsigned char ack;
// outb(0xD4, 0x64);                    // tell the controller to address the mouse
// outb(0xF3, 0x60);                    // write the mouse command code to the controller's data port
// while(!(inb(0x64) & 1)){
//     asm("pause"); // wait until we can read
// }   
// ack = inb(0x60);                     // read back acknowledge. This should be 0xFA
// outb(0xD4, 0x64);                    // tell the controller to address the mouse
// outb(100, 0x60);                     // write the parameter to the controller's data port
// while(!(inb(0x64) & 1)){
//     asm("pause"); // wait until we can read
// } 
// ack = inb(0x60);                     // read back acknowledge. This should be 0xFA
// exit(0);
// return 0;
// }