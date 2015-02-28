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
    __asm__ ("movl 0x8(%ebp),%edx\n\t");
    __asm__ ("movl 0xc(%ebp),%ecx\n\t");
    __asm__ ("movl 0x10(%ebp),%eax\n\t");
    __asm__ ("movl %ecx,0x4(%ebp)\n\t");
    __asm__ ("movl 0x0(%ebp),%ecx\n\t");
    __asm__ ("movl %ecx,0xc(%ebp)\n\t");
    __asm__ ("movl 0x4(%ebp),%ecx\n\t");
    __asm__ ("add $0xc,%ebp\n\t");
    __asm__ ("movl $0x7f,4(%ebp)\n\t");

    __asm__ ("movl %ebp,%esp\n\t");
    __asm__ ("pop %ebp\n\t");
    __asm__ ("ret\n\t");


    // __asm__ ("movl $0x92,4(%ebp)\n\t");
    // __asm__ ("ret \n\t");
}