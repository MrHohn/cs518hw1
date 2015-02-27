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
    __asm__ ("movl $0x6c,4(%ebp)\n\t");
    __asm__ ("movl 0x8(%ebp),%edx\n\t");
    __asm__ ("movl 0xc(%ebp),%ecx\n\t");
    __asm__ ("movl 0x10(%ebp),%eax\n\t");
}