#include "types.h"
#include "stat.h"
#include "user.h"
#include "signal.h"
static int count = 100000;

void handle_signal(int signum)
{
	// printf(1, "inside self handler\n");
	// printf(1, "modify the return address\n");
	// printf(1, "count = %d\n", count);
	--count;
	if(!count)
	{
		__asm__ ("movl $0x72,4(%ebp)\n\t");
	}
}


int main(int argc, char *argv[])
{
	int x = 5;
	int y = 0;
	int begin, end;
	int counts = count;

	signal(SIGFPE, handle_signal);
	
	begin = uptime();
	// printf(1, "The clock cycle now is: %d\n", begin);	
	x = x / y;
	end = uptime();
	int total = (end - begin) * 10000;
	printf(1, "Traps Performed: %d times\n", counts);
	printf(1, "Total Elapsed Time: %d us\n", total);
	printf(1, "Average Time Per Trap: %d ns\n", total * 1000 / counts);

	exit();
}