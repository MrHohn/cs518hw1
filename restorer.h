// #include "signal.h"
#include "user.h"

// You must define an inline asm function here to solve stage3.
void restorer(int unused)
{	

    // __asm__ ("movl 0x8(%ebp),%edx\n\t");
    // __asm__ ("movl 0xc(%ebp),%ecx\n\t");
    // __asm__ ("movl 0x10(%ebp),%eax\n\t");
    // __asm__ ("movl %ecx,0x4(%ebp)\n\t");
    // __asm__ ("movl 0x0(%ebp),%ecx\n\t");
    // __asm__ ("movl %ecx,0xc(%ebp)\n\t");
    // __asm__ ("movl 0x4(%ebp),%ecx\n\t");
    // __asm__ ("add $0xc,%ebp\n\t");
    // __asm__ ("movl $0x89,4(%ebp)\n\t");

    // __asm__ ("movl %ebp,%esp\n\t");
    // __asm__ ("pop %ebp\n\t");
    // __asm__ ("ret\n\t");
    



    __asm__ ("movl 0x4(%ebp),%edx\n\t");
    __asm__ ("movl 0x8(%ebp),%ecx\n\t");
    __asm__ ("movl 0xc(%ebp),%eax\n\t");
    __asm__ ("add $0x10,%ebp\n\t");

    __asm__ ("movl %ebp,%esp\n\t");
    __asm__ ("pop %ebp\n\t");
    __asm__ ("ret\n\t");
}