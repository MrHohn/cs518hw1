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

	// printf(1, "The clock cycle now is: %d\n", end);	
	printf(1, "Traps Performed: %d times\n", counts);
	printf(1, "Total Elapsed Time: %d us\n", (end - begin) * 4348);
	printf(1, "Average Time Per Trap: %d us\n", (end - begin) / counts);

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