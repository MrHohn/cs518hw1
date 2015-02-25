#include "types.h"
#include "stat.h"
#include "user.h"
#include "signal.h"
static int count = 10000;

int signal(int signum, sighandler_t handler)
{
	asm
	(
		"movl   $0x17,0x0c(%ebp) \n\t" 

	);

	return 1;
}

void handle_signal(int signum)
{

}

int main(int argc, char *argv[])
{
	int x = 5;
	int y = 0;
	int begin, end;
	int counts = count;

	signal(SIGFPE, handle_signal);
	begin = uptime();
	while(count--){
		x = x / y;
	}
	end = uptime();
	
	printf(1, "Traps Performed: %d\n", counts);
	printf(1, "Total Elapsed Time: %d\n", end - begin);
	printf(1, "Average Time Per Trap: %d\n", (end - begin) / counts);

	exit();
}