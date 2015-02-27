// #include "signal.h"
#include "user.h"

// You must define an inline asm function here to solve stage3.
void restorer(int unused)
{	
	// unused = 1;
    // __asm__ ("movl $0x0,%ecx \n\t");
    // __asm__ ("ret \n\t");
    printf(1, "in restorer\n");
    exit();
}