#include "types.h"
#include "stat.h"
#include "user.h"
#include "signal.h"
static int count = 100000;

void handle_signal(int signum)
{
	--count;
	
	/*move the old ebp down to the address after the return IP(divide 0)*/
	__asm__ ("movl 0x0(%ebp),%eax\n\t");
	__asm__ ("movl %eax,0x8(%ebp)\n\t");
	__asm__ ("addl $0x8,%ebp\n\t");

	if(!count) // if it is the 100000 times, modified the return IP to the next instruction of divide 0
	{
		__asm__ ("movl $0x7d,4(%ebp)\n\t");
	}

	__asm__ ("movl %ebp,%esp\n\t"); // modified the esp (needed because we modified the stack manually)
}


int main(int argc, char *argv[])
{
	int x = 5;
	int y = 0;
	int begin, end; // variables for recording the begin and finish time
	int counts = count; // counts = the total count of trap

	signal(SIGFPE, handle_signal);

	begin = uptime(); // get the begin time
	
	x = x / y;
	
	end = uptime(); // get the end time

	int total = (end - begin) * 10000; // calculate the total time(us)
	printf(1, "Traps Performed: %d times\n", counts);
	printf(1, "Total Elapsed Time: %d us\n", total);
	printf(1, "Average Time Per Trap: %d ns\n", total * 1000 / counts); // show the average time(ns)

	exit();
}
