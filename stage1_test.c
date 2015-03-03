#include "types.h"
#include "stat.h"
#include "user.h"
#include "signal.h"

// int signal(int signum, sighandler_t handler)
// {
// 	// int a = signum;
// 	// a++;
// 	// __asm__ ("movl %esp,-0xc(%ebp) \n\t");
// 	// printf(1, "sig esp = %d\n", a);
// 	// __asm__ ("movl %ebp,-0xc(%ebp) \n\t");
// 	// printf(1, "sig ebp = %d\n", a);
// 	// __asm__ ("movl %ss,-0xc(%ebp) \n\t");
// 	// printf(1, "ss = %d\n", a);

// 	// sighandler_t b = handler;
// 	// // b = handler;
// 	// // c = b;
// 	// __asm
// 	// {
// 	// 	movl   $0x17,%eax 
// 	// 	push   %eax
// 	// } 
// 	// asm
// 	// (
// 	// 	"movl   $0x17,%eax \n\t" 
// 	// 	"push   %eax \n\t"
// 	// );
// 	// asm
// 	// (
// 	// 	"movl   $0x17,0x0c(%ebp) \n\t" 
// 	// 	// "movl   $0x17,0x08(%ebp) \n\t" 
// 	// 	// "movl   $0x17,%eax \n\t" 
// 	// );
// 	// int sn = signum;
// 	// sn = sn;
// 	// uint hl = (uint)handler;
// 	// hl = hl;
// 	regis(signum, handler);
// 	// regis(signum);
	
// 	return (int)(handler);
// }



void handle_signal(int signum)
{
	printf(1, "Caught signal %d...\n", signum);
	if (signum == SIGFPE)
		printf(1, "TEST PASSED\n");
	else
		printf(1, "TEST FAILED: wrong signal sent.\n");
	exit();
}

int main(int argc, char *argv[])
{
	// int begin, end;
	// int i, mul = 1;
	// begin = uptime();
	// for(i = 0; i < 10000; i++)
	// {
	// 	mul *= 3;
	// }
	// end = uptime();
	// printf(1, "time cost = %d\n", end = begin);
	// cprintf("%d", %eax);
	int x = 5;
	int y = 0;

	// __asm__ ("movl %ebp,0x1c(%esp) \n\t");
	// printf(1, "main ebp = %d\n", x);
	// __asm__ ("movl %esp,0x1c(%esp) \n\t");
	// printf(1, "main esp = %d\n", x);

	signal(SIGFPE, handle_signal);
	// asm
	// (
	// 	"movl   $0x17,%eax \n\t" 
	// 	"push   %eax \n\t"
	// );
	x = x / y;

	printf(1, "TEST FAILED: no signal sent.\n");
	
	exit();
}