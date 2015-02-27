#ifndef XV6_SIGNAL
#define XV6_SIGNAL
#define SIGFPE   0
// You should define anything signal related that needs to be shared between
// kernel and userspace here

// At a minimum you must define the signal constants themselves
// as well as a sighandler_t type.


typedef void(sighandler_t)(int);
// int signal(int signum, sighandler_t handler);



#endif