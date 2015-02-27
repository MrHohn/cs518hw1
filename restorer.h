// #include "signal.h"
#include "user.h"

// You must define an inline asm function here to solve stage3.
void restorer(int unused)
{	
	// unused = 1;
    // __asm__ ("movl $0x0,%ecx \n\t");
    // __asm__ ("ret \n\t");
    // printf(1, "in restorer\n");
    // exit();
    // __asm__ ("jmp 78 <main+0x57>\n\t");
    // __asm__ ("jmp 78\n\t");
    __asm__ ("movl $0x66,4(%ebp)\n\t");
    __asm__ ("movl 8(%ebp),%ecx\n\t");
    // __asm__ ("movl $0x5,%ecx\n\t");
}