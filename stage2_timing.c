#include "types.h"
#include "stat.h"
#include "user.h"
#include "signal.h"
static int count = 100000;

// int signal(int signum, sighandler_t handler)
// {
// 	regis(signum, handler);
	
// 	return (int)(handler);
// }

void handle_signal(int);


int main(int argc, char *argv[])
{
	int x = 5;
	int y = 0;
	int begin, end;
	int counts = count;

	// printf(1, "anything\n");

	signal(SIGFPE, handle_signal);

	// printf(1, "anything\n");
	
	begin = uptime();
	// printf(1, "The clock cycle now is: %d\n", begin);	
	x = x / y;
	end = uptime();
	// double dtotal = double(end - begin) * 4348 * 1000; 
	// double dtotal = (double)(end - begin) * 10000; 
	//time per timer IRQ = (10000000 / 2.3Ghz)s
	//                   = (10 / 2.3) ms
	//                   = (10000 / 2.3) us
	//                   = (10000000 / 2.3) ns
	// printf(1, "The clock cycle now is: %d\n", end);
	// int total = (int)dtotal;
	int total = (end - begin) * 10000;
	printf(1, "Traps Performed: %d times\n", counts);
	printf(1, "Total Elapsed Time: %d us\n", total);
	printf(1, "Average Time Per Trap: %d ns\n", total * 1000 / counts);

	exit();
}

void handle_signal(int signum)
{
	// printf(1, "inside self handler\n");
	// printf(1, "modify the return address\n");
	// printf(1, "count = %d\n", count);
	--count;
	if(!count)
	{
		__asm__ ("movl $0x50,4(%ebp)\n\t");
	}
}