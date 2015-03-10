// You must define an inline asm function here to solve stage3.

void restorer(int unused)
{	
    __asm__ ("movl 0x8(%ebp),%edx\n\t"); // restore edx
    __asm__ ("movl 0xc(%ebp),%ecx\n\t"); // restore ecx
    __asm__ ("movl 0x10(%ebp),%eax\n\t"); // restore eax
    __asm__ ("add $0x14,%ebp\n\t"); // discard the useless address

    __asm__ ("movl %ebp,%esp\n\t"); // update the esp
}