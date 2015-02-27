#include "types.h"
#include "stat.h"
#include "user.h"
#include "signal.h"
// static int count = 10000;

int signal(int signum, sighandler_t handler)
{
	regis(signum, handler);
	
	return (int)(handler);
}

void handle_signal(int signum)
{
	printf(1, "inside self handler\n");
	printf(1, "modify the return address\n");

	__asm__ ("movl $0x92,4(%ebp)\n\t");
	// exit();
}

int main(int argc, char *argv[])
{
	int x = 5;
	int y = 0;
	// int begin, end;
	// int counts = count;

	signal(SIGFPE, handle_signal);
	// begin = uptime();
	// while(count--){
	x = x / y;
	// }
	// end = uptime();
	
	printf(1, "Traps Performed: XXXX\n");
	printf(1, "Total Elapsed Time: XXXX\n");
	printf(1, "Average Time Per Trap: XXXXX\n");

	// printf(1, "Traps Performed: %d\n", counts);
	// printf(1, "Total Elapsed Time: %d\n", end - begin);
	// printf(1, "Average Time Per Trap: %d\n", (end - begin) / counts);

	exit();
}