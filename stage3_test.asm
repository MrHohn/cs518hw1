
_stage3_test:     file format elf32-i386


Disassembly of section .text:

00000000 <restorer>:
// #include "signal.h"
#include "user.h"

// You must define an inline asm function here to solve stage3.
void restorer(int unused)
{	
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
    // __asm__ ("ret\n\t");
    



    __asm__ ("movl 0x4(%ebp),%edx\n\t");
   3:	8b 55 04             	mov    0x4(%ebp),%edx
    __asm__ ("movl 0x8(%ebp),%ecx\n\t");
   6:	8b 4d 08             	mov    0x8(%ebp),%ecx
    __asm__ ("movl 0xc(%ebp),%eax\n\t");
   9:	8b 45 0c             	mov    0xc(%ebp),%eax
    __asm__ ("add $0x10,%ebp\n\t");
   c:	83 c5 10             	add    $0x10,%ebp

    __asm__ ("movl %ebp,%esp\n\t");
   f:	89 ec                	mov    %ebp,%esp
    // __asm__ ("pop %ebp\n\t");
    // __asm__ ("ret\n\t");
  11:	5d                   	pop    %ebp
  12:	c3                   	ret    

00000013 <handle_signal>:

// You must implement your restorer function in restorer.h
#include "restorer.h"

void handle_signal(int signum)
{
  13:	55                   	push   %ebp
  14:	89 e5                	mov    %esp,%ebp
    // printf(1, "in handler\n");
    // exit();

    __asm__ ("movl $0x0,%ecx\n\t");
  16:	b9 00 00 00 00       	mov    $0x0,%ecx
	// Add your code to skip the return ip here
    // __asm__ ("movl $0x0,4(%ebp)\n\t");
} 
  1b:	5d                   	pop    %ebp
  1c:	c3                   	ret    

0000001d <main>:

int main(void)
{
  1d:	55                   	push   %ebp
  1e:	89 e5                	mov    %esp,%ebp
  20:	83 e4 f0             	and    $0xfffffff0,%esp
  23:	83 ec 20             	sub    $0x20,%esp
    register int ecx asm ("%ecx");
    // restorer();
    signal(-1, (sighandler_t *) restorer);   // save the address of restorer function inside the kernel.
  26:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  2d:	00 
  2e:	c7 04 24 ff ff ff ff 	movl   $0xffffffff,(%esp)
  35:	e8 8a 03 00 00       	call   3c4 <signal>
    signal(SIGFPE, handle_signal);         // register the actual signal for divide by zero.
  3a:	c7 44 24 04 13 00 00 	movl   $0x13,0x4(%esp)
  41:	00 
  42:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  49:	e8 76 03 00 00       	call   3c4 <signal>

    int x = 5;
  4e:	c7 44 24 1c 05 00 00 	movl   $0x5,0x1c(%esp)
  55:	00 
    int y = 0;
  56:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
  5d:	00 

    ecx = 5;
  5e:	b9 05 00 00 00       	mov    $0x5,%ecx
    x = x / y;
  63:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  67:	89 c2                	mov    %eax,%edx
  69:	c1 fa 1f             	sar    $0x1f,%edx
  6c:	f7 7c 24 18          	idivl  0x18(%esp)
  70:	89 44 24 1c          	mov    %eax,0x1c(%esp)

    if (ecx == 5)
  74:	89 c8                	mov    %ecx,%eax
  76:	83 f8 05             	cmp    $0x5,%eax
  79:	75 1c                	jne    97 <main+0x7a>
        printf(1, "TEST PASSED: Final value of ecx is %d...\n", ecx);
  7b:	89 c8                	mov    %ecx,%eax
  7d:	89 44 24 08          	mov    %eax,0x8(%esp)
  81:	c7 44 24 04 68 08 00 	movl   $0x868,0x4(%esp)
  88:	00 
  89:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  90:	e8 0e 04 00 00       	call   4a3 <printf>
  95:	eb 1a                	jmp    b1 <main+0x94>
    else
        printf(1, "TEST FAILED: Final value of ecx is %d...\n", ecx);
  97:	89 c8                	mov    %ecx,%eax
  99:	89 44 24 08          	mov    %eax,0x8(%esp)
  9d:	c7 44 24 04 94 08 00 	movl   $0x894,0x4(%esp)
  a4:	00 
  a5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  ac:	e8 f2 03 00 00       	call   4a3 <printf>

    exit();
  b1:	e8 66 02 00 00       	call   31c <exit>
  b6:	90                   	nop
  b7:	90                   	nop

000000b8 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  b8:	55                   	push   %ebp
  b9:	89 e5                	mov    %esp,%ebp
  bb:	57                   	push   %edi
  bc:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  bd:	8b 4d 08             	mov    0x8(%ebp),%ecx
  c0:	8b 55 10             	mov    0x10(%ebp),%edx
  c3:	8b 45 0c             	mov    0xc(%ebp),%eax
  c6:	89 cb                	mov    %ecx,%ebx
  c8:	89 df                	mov    %ebx,%edi
  ca:	89 d1                	mov    %edx,%ecx
  cc:	fc                   	cld    
  cd:	f3 aa                	rep stos %al,%es:(%edi)
  cf:	89 ca                	mov    %ecx,%edx
  d1:	89 fb                	mov    %edi,%ebx
  d3:	89 5d 08             	mov    %ebx,0x8(%ebp)
  d6:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  d9:	5b                   	pop    %ebx
  da:	5f                   	pop    %edi
  db:	5d                   	pop    %ebp
  dc:	c3                   	ret    

000000dd <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  dd:	55                   	push   %ebp
  de:	89 e5                	mov    %esp,%ebp
  e0:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  e3:	8b 45 08             	mov    0x8(%ebp),%eax
  e6:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  e9:	90                   	nop
  ea:	8b 45 0c             	mov    0xc(%ebp),%eax
  ed:	0f b6 10             	movzbl (%eax),%edx
  f0:	8b 45 08             	mov    0x8(%ebp),%eax
  f3:	88 10                	mov    %dl,(%eax)
  f5:	8b 45 08             	mov    0x8(%ebp),%eax
  f8:	0f b6 00             	movzbl (%eax),%eax
  fb:	84 c0                	test   %al,%al
  fd:	0f 95 c0             	setne  %al
 100:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 104:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
 108:	84 c0                	test   %al,%al
 10a:	75 de                	jne    ea <strcpy+0xd>
    ;
  return os;
 10c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 10f:	c9                   	leave  
 110:	c3                   	ret    

00000111 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 111:	55                   	push   %ebp
 112:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 114:	eb 08                	jmp    11e <strcmp+0xd>
    p++, q++;
 116:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 11a:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 11e:	8b 45 08             	mov    0x8(%ebp),%eax
 121:	0f b6 00             	movzbl (%eax),%eax
 124:	84 c0                	test   %al,%al
 126:	74 10                	je     138 <strcmp+0x27>
 128:	8b 45 08             	mov    0x8(%ebp),%eax
 12b:	0f b6 10             	movzbl (%eax),%edx
 12e:	8b 45 0c             	mov    0xc(%ebp),%eax
 131:	0f b6 00             	movzbl (%eax),%eax
 134:	38 c2                	cmp    %al,%dl
 136:	74 de                	je     116 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 138:	8b 45 08             	mov    0x8(%ebp),%eax
 13b:	0f b6 00             	movzbl (%eax),%eax
 13e:	0f b6 d0             	movzbl %al,%edx
 141:	8b 45 0c             	mov    0xc(%ebp),%eax
 144:	0f b6 00             	movzbl (%eax),%eax
 147:	0f b6 c0             	movzbl %al,%eax
 14a:	89 d1                	mov    %edx,%ecx
 14c:	29 c1                	sub    %eax,%ecx
 14e:	89 c8                	mov    %ecx,%eax
}
 150:	5d                   	pop    %ebp
 151:	c3                   	ret    

00000152 <strlen>:

uint
strlen(char *s)
{
 152:	55                   	push   %ebp
 153:	89 e5                	mov    %esp,%ebp
 155:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 158:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 15f:	eb 04                	jmp    165 <strlen+0x13>
 161:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 165:	8b 45 fc             	mov    -0x4(%ebp),%eax
 168:	03 45 08             	add    0x8(%ebp),%eax
 16b:	0f b6 00             	movzbl (%eax),%eax
 16e:	84 c0                	test   %al,%al
 170:	75 ef                	jne    161 <strlen+0xf>
    ;
  return n;
 172:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 175:	c9                   	leave  
 176:	c3                   	ret    

00000177 <memset>:

void*
memset(void *dst, int c, uint n)
{
 177:	55                   	push   %ebp
 178:	89 e5                	mov    %esp,%ebp
 17a:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
 17d:	8b 45 10             	mov    0x10(%ebp),%eax
 180:	89 44 24 08          	mov    %eax,0x8(%esp)
 184:	8b 45 0c             	mov    0xc(%ebp),%eax
 187:	89 44 24 04          	mov    %eax,0x4(%esp)
 18b:	8b 45 08             	mov    0x8(%ebp),%eax
 18e:	89 04 24             	mov    %eax,(%esp)
 191:	e8 22 ff ff ff       	call   b8 <stosb>
  return dst;
 196:	8b 45 08             	mov    0x8(%ebp),%eax
}
 199:	c9                   	leave  
 19a:	c3                   	ret    

0000019b <strchr>:

char*
strchr(const char *s, char c)
{
 19b:	55                   	push   %ebp
 19c:	89 e5                	mov    %esp,%ebp
 19e:	83 ec 04             	sub    $0x4,%esp
 1a1:	8b 45 0c             	mov    0xc(%ebp),%eax
 1a4:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 1a7:	eb 14                	jmp    1bd <strchr+0x22>
    if(*s == c)
 1a9:	8b 45 08             	mov    0x8(%ebp),%eax
 1ac:	0f b6 00             	movzbl (%eax),%eax
 1af:	3a 45 fc             	cmp    -0x4(%ebp),%al
 1b2:	75 05                	jne    1b9 <strchr+0x1e>
      return (char*)s;
 1b4:	8b 45 08             	mov    0x8(%ebp),%eax
 1b7:	eb 13                	jmp    1cc <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 1b9:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 1bd:	8b 45 08             	mov    0x8(%ebp),%eax
 1c0:	0f b6 00             	movzbl (%eax),%eax
 1c3:	84 c0                	test   %al,%al
 1c5:	75 e2                	jne    1a9 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 1c7:	b8 00 00 00 00       	mov    $0x0,%eax
}
 1cc:	c9                   	leave  
 1cd:	c3                   	ret    

000001ce <gets>:

char*
gets(char *buf, int max)
{
 1ce:	55                   	push   %ebp
 1cf:	89 e5                	mov    %esp,%ebp
 1d1:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1d4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 1db:	eb 44                	jmp    221 <gets+0x53>
    cc = read(0, &c, 1);
 1dd:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 1e4:	00 
 1e5:	8d 45 ef             	lea    -0x11(%ebp),%eax
 1e8:	89 44 24 04          	mov    %eax,0x4(%esp)
 1ec:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 1f3:	e8 3c 01 00 00       	call   334 <read>
 1f8:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 1fb:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 1ff:	7e 2d                	jle    22e <gets+0x60>
      break;
    buf[i++] = c;
 201:	8b 45 f4             	mov    -0xc(%ebp),%eax
 204:	03 45 08             	add    0x8(%ebp),%eax
 207:	0f b6 55 ef          	movzbl -0x11(%ebp),%edx
 20b:	88 10                	mov    %dl,(%eax)
 20d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(c == '\n' || c == '\r')
 211:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 215:	3c 0a                	cmp    $0xa,%al
 217:	74 16                	je     22f <gets+0x61>
 219:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 21d:	3c 0d                	cmp    $0xd,%al
 21f:	74 0e                	je     22f <gets+0x61>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 221:	8b 45 f4             	mov    -0xc(%ebp),%eax
 224:	83 c0 01             	add    $0x1,%eax
 227:	3b 45 0c             	cmp    0xc(%ebp),%eax
 22a:	7c b1                	jl     1dd <gets+0xf>
 22c:	eb 01                	jmp    22f <gets+0x61>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 22e:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 22f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 232:	03 45 08             	add    0x8(%ebp),%eax
 235:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 238:	8b 45 08             	mov    0x8(%ebp),%eax
}
 23b:	c9                   	leave  
 23c:	c3                   	ret    

0000023d <stat>:

int
stat(char *n, struct stat *st)
{
 23d:	55                   	push   %ebp
 23e:	89 e5                	mov    %esp,%ebp
 240:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 243:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 24a:	00 
 24b:	8b 45 08             	mov    0x8(%ebp),%eax
 24e:	89 04 24             	mov    %eax,(%esp)
 251:	e8 06 01 00 00       	call   35c <open>
 256:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 259:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 25d:	79 07                	jns    266 <stat+0x29>
    return -1;
 25f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 264:	eb 23                	jmp    289 <stat+0x4c>
  r = fstat(fd, st);
 266:	8b 45 0c             	mov    0xc(%ebp),%eax
 269:	89 44 24 04          	mov    %eax,0x4(%esp)
 26d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 270:	89 04 24             	mov    %eax,(%esp)
 273:	e8 fc 00 00 00       	call   374 <fstat>
 278:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 27b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 27e:	89 04 24             	mov    %eax,(%esp)
 281:	e8 be 00 00 00       	call   344 <close>
  return r;
 286:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 289:	c9                   	leave  
 28a:	c3                   	ret    

0000028b <atoi>:

int
atoi(const char *s)
{
 28b:	55                   	push   %ebp
 28c:	89 e5                	mov    %esp,%ebp
 28e:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 291:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 298:	eb 23                	jmp    2bd <atoi+0x32>
    n = n*10 + *s++ - '0';
 29a:	8b 55 fc             	mov    -0x4(%ebp),%edx
 29d:	89 d0                	mov    %edx,%eax
 29f:	c1 e0 02             	shl    $0x2,%eax
 2a2:	01 d0                	add    %edx,%eax
 2a4:	01 c0                	add    %eax,%eax
 2a6:	89 c2                	mov    %eax,%edx
 2a8:	8b 45 08             	mov    0x8(%ebp),%eax
 2ab:	0f b6 00             	movzbl (%eax),%eax
 2ae:	0f be c0             	movsbl %al,%eax
 2b1:	01 d0                	add    %edx,%eax
 2b3:	83 e8 30             	sub    $0x30,%eax
 2b6:	89 45 fc             	mov    %eax,-0x4(%ebp)
 2b9:	83 45 08 01          	addl   $0x1,0x8(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2bd:	8b 45 08             	mov    0x8(%ebp),%eax
 2c0:	0f b6 00             	movzbl (%eax),%eax
 2c3:	3c 2f                	cmp    $0x2f,%al
 2c5:	7e 0a                	jle    2d1 <atoi+0x46>
 2c7:	8b 45 08             	mov    0x8(%ebp),%eax
 2ca:	0f b6 00             	movzbl (%eax),%eax
 2cd:	3c 39                	cmp    $0x39,%al
 2cf:	7e c9                	jle    29a <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 2d1:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 2d4:	c9                   	leave  
 2d5:	c3                   	ret    

000002d6 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 2d6:	55                   	push   %ebp
 2d7:	89 e5                	mov    %esp,%ebp
 2d9:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 2dc:	8b 45 08             	mov    0x8(%ebp),%eax
 2df:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 2e2:	8b 45 0c             	mov    0xc(%ebp),%eax
 2e5:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 2e8:	eb 13                	jmp    2fd <memmove+0x27>
    *dst++ = *src++;
 2ea:	8b 45 f8             	mov    -0x8(%ebp),%eax
 2ed:	0f b6 10             	movzbl (%eax),%edx
 2f0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 2f3:	88 10                	mov    %dl,(%eax)
 2f5:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 2f9:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2fd:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
 301:	0f 9f c0             	setg   %al
 304:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
 308:	84 c0                	test   %al,%al
 30a:	75 de                	jne    2ea <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 30c:	8b 45 08             	mov    0x8(%ebp),%eax
}
 30f:	c9                   	leave  
 310:	c3                   	ret    
 311:	90                   	nop
 312:	90                   	nop
 313:	90                   	nop

00000314 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 314:	b8 01 00 00 00       	mov    $0x1,%eax
 319:	cd 40                	int    $0x40
 31b:	c3                   	ret    

0000031c <exit>:
SYSCALL(exit)
 31c:	b8 02 00 00 00       	mov    $0x2,%eax
 321:	cd 40                	int    $0x40
 323:	c3                   	ret    

00000324 <wait>:
SYSCALL(wait)
 324:	b8 03 00 00 00       	mov    $0x3,%eax
 329:	cd 40                	int    $0x40
 32b:	c3                   	ret    

0000032c <pipe>:
SYSCALL(pipe)
 32c:	b8 04 00 00 00       	mov    $0x4,%eax
 331:	cd 40                	int    $0x40
 333:	c3                   	ret    

00000334 <read>:
SYSCALL(read)
 334:	b8 05 00 00 00       	mov    $0x5,%eax
 339:	cd 40                	int    $0x40
 33b:	c3                   	ret    

0000033c <write>:
SYSCALL(write)
 33c:	b8 10 00 00 00       	mov    $0x10,%eax
 341:	cd 40                	int    $0x40
 343:	c3                   	ret    

00000344 <close>:
SYSCALL(close)
 344:	b8 15 00 00 00       	mov    $0x15,%eax
 349:	cd 40                	int    $0x40
 34b:	c3                   	ret    

0000034c <kill>:
SYSCALL(kill)
 34c:	b8 06 00 00 00       	mov    $0x6,%eax
 351:	cd 40                	int    $0x40
 353:	c3                   	ret    

00000354 <exec>:
SYSCALL(exec)
 354:	b8 07 00 00 00       	mov    $0x7,%eax
 359:	cd 40                	int    $0x40
 35b:	c3                   	ret    

0000035c <open>:
SYSCALL(open)
 35c:	b8 0f 00 00 00       	mov    $0xf,%eax
 361:	cd 40                	int    $0x40
 363:	c3                   	ret    

00000364 <mknod>:
SYSCALL(mknod)
 364:	b8 11 00 00 00       	mov    $0x11,%eax
 369:	cd 40                	int    $0x40
 36b:	c3                   	ret    

0000036c <unlink>:
SYSCALL(unlink)
 36c:	b8 12 00 00 00       	mov    $0x12,%eax
 371:	cd 40                	int    $0x40
 373:	c3                   	ret    

00000374 <fstat>:
SYSCALL(fstat)
 374:	b8 08 00 00 00       	mov    $0x8,%eax
 379:	cd 40                	int    $0x40
 37b:	c3                   	ret    

0000037c <link>:
SYSCALL(link)
 37c:	b8 13 00 00 00       	mov    $0x13,%eax
 381:	cd 40                	int    $0x40
 383:	c3                   	ret    

00000384 <mkdir>:
SYSCALL(mkdir)
 384:	b8 14 00 00 00       	mov    $0x14,%eax
 389:	cd 40                	int    $0x40
 38b:	c3                   	ret    

0000038c <chdir>:
SYSCALL(chdir)
 38c:	b8 09 00 00 00       	mov    $0x9,%eax
 391:	cd 40                	int    $0x40
 393:	c3                   	ret    

00000394 <dup>:
SYSCALL(dup)
 394:	b8 0a 00 00 00       	mov    $0xa,%eax
 399:	cd 40                	int    $0x40
 39b:	c3                   	ret    

0000039c <getpid>:
SYSCALL(getpid)
 39c:	b8 0b 00 00 00       	mov    $0xb,%eax
 3a1:	cd 40                	int    $0x40
 3a3:	c3                   	ret    

000003a4 <sbrk>:
SYSCALL(sbrk)
 3a4:	b8 0c 00 00 00       	mov    $0xc,%eax
 3a9:	cd 40                	int    $0x40
 3ab:	c3                   	ret    

000003ac <sleep>:
SYSCALL(sleep)
 3ac:	b8 0d 00 00 00       	mov    $0xd,%eax
 3b1:	cd 40                	int    $0x40
 3b3:	c3                   	ret    

000003b4 <uptime>:
SYSCALL(uptime)
 3b4:	b8 0e 00 00 00       	mov    $0xe,%eax
 3b9:	cd 40                	int    $0x40
 3bb:	c3                   	ret    

000003bc <halt>:
SYSCALL(halt)
 3bc:	b8 16 00 00 00       	mov    $0x16,%eax
 3c1:	cd 40                	int    $0x40
 3c3:	c3                   	ret    

000003c4 <signal>:
 3c4:	b8 17 00 00 00       	mov    $0x17,%eax
 3c9:	cd 40                	int    $0x40
 3cb:	c3                   	ret    

000003cc <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 3cc:	55                   	push   %ebp
 3cd:	89 e5                	mov    %esp,%ebp
 3cf:	83 ec 28             	sub    $0x28,%esp
 3d2:	8b 45 0c             	mov    0xc(%ebp),%eax
 3d5:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 3d8:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 3df:	00 
 3e0:	8d 45 f4             	lea    -0xc(%ebp),%eax
 3e3:	89 44 24 04          	mov    %eax,0x4(%esp)
 3e7:	8b 45 08             	mov    0x8(%ebp),%eax
 3ea:	89 04 24             	mov    %eax,(%esp)
 3ed:	e8 4a ff ff ff       	call   33c <write>
}
 3f2:	c9                   	leave  
 3f3:	c3                   	ret    

000003f4 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 3f4:	55                   	push   %ebp
 3f5:	89 e5                	mov    %esp,%ebp
 3f7:	83 ec 48             	sub    $0x48,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 3fa:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 401:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 405:	74 17                	je     41e <printint+0x2a>
 407:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 40b:	79 11                	jns    41e <printint+0x2a>
    neg = 1;
 40d:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 414:	8b 45 0c             	mov    0xc(%ebp),%eax
 417:	f7 d8                	neg    %eax
 419:	89 45 ec             	mov    %eax,-0x14(%ebp)
 41c:	eb 06                	jmp    424 <printint+0x30>
  } else {
    x = xx;
 41e:	8b 45 0c             	mov    0xc(%ebp),%eax
 421:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 424:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 42b:	8b 4d 10             	mov    0x10(%ebp),%ecx
 42e:	8b 45 ec             	mov    -0x14(%ebp),%eax
 431:	ba 00 00 00 00       	mov    $0x0,%edx
 436:	f7 f1                	div    %ecx
 438:	89 d0                	mov    %edx,%eax
 43a:	0f b6 90 44 0b 00 00 	movzbl 0xb44(%eax),%edx
 441:	8d 45 dc             	lea    -0x24(%ebp),%eax
 444:	03 45 f4             	add    -0xc(%ebp),%eax
 447:	88 10                	mov    %dl,(%eax)
 449:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  }while((x /= base) != 0);
 44d:	8b 55 10             	mov    0x10(%ebp),%edx
 450:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 453:	8b 45 ec             	mov    -0x14(%ebp),%eax
 456:	ba 00 00 00 00       	mov    $0x0,%edx
 45b:	f7 75 d4             	divl   -0x2c(%ebp)
 45e:	89 45 ec             	mov    %eax,-0x14(%ebp)
 461:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 465:	75 c4                	jne    42b <printint+0x37>
  if(neg)
 467:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 46b:	74 2a                	je     497 <printint+0xa3>
    buf[i++] = '-';
 46d:	8d 45 dc             	lea    -0x24(%ebp),%eax
 470:	03 45 f4             	add    -0xc(%ebp),%eax
 473:	c6 00 2d             	movb   $0x2d,(%eax)
 476:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)

  while(--i >= 0)
 47a:	eb 1b                	jmp    497 <printint+0xa3>
    putc(fd, buf[i]);
 47c:	8d 45 dc             	lea    -0x24(%ebp),%eax
 47f:	03 45 f4             	add    -0xc(%ebp),%eax
 482:	0f b6 00             	movzbl (%eax),%eax
 485:	0f be c0             	movsbl %al,%eax
 488:	89 44 24 04          	mov    %eax,0x4(%esp)
 48c:	8b 45 08             	mov    0x8(%ebp),%eax
 48f:	89 04 24             	mov    %eax,(%esp)
 492:	e8 35 ff ff ff       	call   3cc <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 497:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 49b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 49f:	79 db                	jns    47c <printint+0x88>
    putc(fd, buf[i]);
}
 4a1:	c9                   	leave  
 4a2:	c3                   	ret    

000004a3 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 4a3:	55                   	push   %ebp
 4a4:	89 e5                	mov    %esp,%ebp
 4a6:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 4a9:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 4b0:	8d 45 0c             	lea    0xc(%ebp),%eax
 4b3:	83 c0 04             	add    $0x4,%eax
 4b6:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 4b9:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 4c0:	e9 7d 01 00 00       	jmp    642 <printf+0x19f>
    c = fmt[i] & 0xff;
 4c5:	8b 55 0c             	mov    0xc(%ebp),%edx
 4c8:	8b 45 f0             	mov    -0x10(%ebp),%eax
 4cb:	01 d0                	add    %edx,%eax
 4cd:	0f b6 00             	movzbl (%eax),%eax
 4d0:	0f be c0             	movsbl %al,%eax
 4d3:	25 ff 00 00 00       	and    $0xff,%eax
 4d8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 4db:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 4df:	75 2c                	jne    50d <printf+0x6a>
      if(c == '%'){
 4e1:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 4e5:	75 0c                	jne    4f3 <printf+0x50>
        state = '%';
 4e7:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 4ee:	e9 4b 01 00 00       	jmp    63e <printf+0x19b>
      } else {
        putc(fd, c);
 4f3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 4f6:	0f be c0             	movsbl %al,%eax
 4f9:	89 44 24 04          	mov    %eax,0x4(%esp)
 4fd:	8b 45 08             	mov    0x8(%ebp),%eax
 500:	89 04 24             	mov    %eax,(%esp)
 503:	e8 c4 fe ff ff       	call   3cc <putc>
 508:	e9 31 01 00 00       	jmp    63e <printf+0x19b>
      }
    } else if(state == '%'){
 50d:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 511:	0f 85 27 01 00 00    	jne    63e <printf+0x19b>
      if(c == 'd'){
 517:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 51b:	75 2d                	jne    54a <printf+0xa7>
        printint(fd, *ap, 10, 1);
 51d:	8b 45 e8             	mov    -0x18(%ebp),%eax
 520:	8b 00                	mov    (%eax),%eax
 522:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 529:	00 
 52a:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 531:	00 
 532:	89 44 24 04          	mov    %eax,0x4(%esp)
 536:	8b 45 08             	mov    0x8(%ebp),%eax
 539:	89 04 24             	mov    %eax,(%esp)
 53c:	e8 b3 fe ff ff       	call   3f4 <printint>
        ap++;
 541:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 545:	e9 ed 00 00 00       	jmp    637 <printf+0x194>
      } else if(c == 'x' || c == 'p'){
 54a:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 54e:	74 06                	je     556 <printf+0xb3>
 550:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 554:	75 2d                	jne    583 <printf+0xe0>
        printint(fd, *ap, 16, 0);
 556:	8b 45 e8             	mov    -0x18(%ebp),%eax
 559:	8b 00                	mov    (%eax),%eax
 55b:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 562:	00 
 563:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 56a:	00 
 56b:	89 44 24 04          	mov    %eax,0x4(%esp)
 56f:	8b 45 08             	mov    0x8(%ebp),%eax
 572:	89 04 24             	mov    %eax,(%esp)
 575:	e8 7a fe ff ff       	call   3f4 <printint>
        ap++;
 57a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 57e:	e9 b4 00 00 00       	jmp    637 <printf+0x194>
      } else if(c == 's'){
 583:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 587:	75 46                	jne    5cf <printf+0x12c>
        s = (char*)*ap;
 589:	8b 45 e8             	mov    -0x18(%ebp),%eax
 58c:	8b 00                	mov    (%eax),%eax
 58e:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 591:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 595:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 599:	75 27                	jne    5c2 <printf+0x11f>
          s = "(null)";
 59b:	c7 45 f4 be 08 00 00 	movl   $0x8be,-0xc(%ebp)
        while(*s != 0){
 5a2:	eb 1e                	jmp    5c2 <printf+0x11f>
          putc(fd, *s);
 5a4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5a7:	0f b6 00             	movzbl (%eax),%eax
 5aa:	0f be c0             	movsbl %al,%eax
 5ad:	89 44 24 04          	mov    %eax,0x4(%esp)
 5b1:	8b 45 08             	mov    0x8(%ebp),%eax
 5b4:	89 04 24             	mov    %eax,(%esp)
 5b7:	e8 10 fe ff ff       	call   3cc <putc>
          s++;
 5bc:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 5c0:	eb 01                	jmp    5c3 <printf+0x120>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 5c2:	90                   	nop
 5c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5c6:	0f b6 00             	movzbl (%eax),%eax
 5c9:	84 c0                	test   %al,%al
 5cb:	75 d7                	jne    5a4 <printf+0x101>
 5cd:	eb 68                	jmp    637 <printf+0x194>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5cf:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 5d3:	75 1d                	jne    5f2 <printf+0x14f>
        putc(fd, *ap);
 5d5:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5d8:	8b 00                	mov    (%eax),%eax
 5da:	0f be c0             	movsbl %al,%eax
 5dd:	89 44 24 04          	mov    %eax,0x4(%esp)
 5e1:	8b 45 08             	mov    0x8(%ebp),%eax
 5e4:	89 04 24             	mov    %eax,(%esp)
 5e7:	e8 e0 fd ff ff       	call   3cc <putc>
        ap++;
 5ec:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5f0:	eb 45                	jmp    637 <printf+0x194>
      } else if(c == '%'){
 5f2:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 5f6:	75 17                	jne    60f <printf+0x16c>
        putc(fd, c);
 5f8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5fb:	0f be c0             	movsbl %al,%eax
 5fe:	89 44 24 04          	mov    %eax,0x4(%esp)
 602:	8b 45 08             	mov    0x8(%ebp),%eax
 605:	89 04 24             	mov    %eax,(%esp)
 608:	e8 bf fd ff ff       	call   3cc <putc>
 60d:	eb 28                	jmp    637 <printf+0x194>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 60f:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 616:	00 
 617:	8b 45 08             	mov    0x8(%ebp),%eax
 61a:	89 04 24             	mov    %eax,(%esp)
 61d:	e8 aa fd ff ff       	call   3cc <putc>
        putc(fd, c);
 622:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 625:	0f be c0             	movsbl %al,%eax
 628:	89 44 24 04          	mov    %eax,0x4(%esp)
 62c:	8b 45 08             	mov    0x8(%ebp),%eax
 62f:	89 04 24             	mov    %eax,(%esp)
 632:	e8 95 fd ff ff       	call   3cc <putc>
      }
      state = 0;
 637:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 63e:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 642:	8b 55 0c             	mov    0xc(%ebp),%edx
 645:	8b 45 f0             	mov    -0x10(%ebp),%eax
 648:	01 d0                	add    %edx,%eax
 64a:	0f b6 00             	movzbl (%eax),%eax
 64d:	84 c0                	test   %al,%al
 64f:	0f 85 70 fe ff ff    	jne    4c5 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 655:	c9                   	leave  
 656:	c3                   	ret    
 657:	90                   	nop

00000658 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 658:	55                   	push   %ebp
 659:	89 e5                	mov    %esp,%ebp
 65b:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 65e:	8b 45 08             	mov    0x8(%ebp),%eax
 661:	83 e8 08             	sub    $0x8,%eax
 664:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 667:	a1 60 0b 00 00       	mov    0xb60,%eax
 66c:	89 45 fc             	mov    %eax,-0x4(%ebp)
 66f:	eb 24                	jmp    695 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 671:	8b 45 fc             	mov    -0x4(%ebp),%eax
 674:	8b 00                	mov    (%eax),%eax
 676:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 679:	77 12                	ja     68d <free+0x35>
 67b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 67e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 681:	77 24                	ja     6a7 <free+0x4f>
 683:	8b 45 fc             	mov    -0x4(%ebp),%eax
 686:	8b 00                	mov    (%eax),%eax
 688:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 68b:	77 1a                	ja     6a7 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 68d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 690:	8b 00                	mov    (%eax),%eax
 692:	89 45 fc             	mov    %eax,-0x4(%ebp)
 695:	8b 45 f8             	mov    -0x8(%ebp),%eax
 698:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 69b:	76 d4                	jbe    671 <free+0x19>
 69d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6a0:	8b 00                	mov    (%eax),%eax
 6a2:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6a5:	76 ca                	jbe    671 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 6a7:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6aa:	8b 40 04             	mov    0x4(%eax),%eax
 6ad:	c1 e0 03             	shl    $0x3,%eax
 6b0:	89 c2                	mov    %eax,%edx
 6b2:	03 55 f8             	add    -0x8(%ebp),%edx
 6b5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6b8:	8b 00                	mov    (%eax),%eax
 6ba:	39 c2                	cmp    %eax,%edx
 6bc:	75 24                	jne    6e2 <free+0x8a>
    bp->s.size += p->s.ptr->s.size;
 6be:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6c1:	8b 50 04             	mov    0x4(%eax),%edx
 6c4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6c7:	8b 00                	mov    (%eax),%eax
 6c9:	8b 40 04             	mov    0x4(%eax),%eax
 6cc:	01 c2                	add    %eax,%edx
 6ce:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6d1:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 6d4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6d7:	8b 00                	mov    (%eax),%eax
 6d9:	8b 10                	mov    (%eax),%edx
 6db:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6de:	89 10                	mov    %edx,(%eax)
 6e0:	eb 0a                	jmp    6ec <free+0x94>
  } else
    bp->s.ptr = p->s.ptr;
 6e2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6e5:	8b 10                	mov    (%eax),%edx
 6e7:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6ea:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 6ec:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ef:	8b 40 04             	mov    0x4(%eax),%eax
 6f2:	c1 e0 03             	shl    $0x3,%eax
 6f5:	03 45 fc             	add    -0x4(%ebp),%eax
 6f8:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6fb:	75 20                	jne    71d <free+0xc5>
    p->s.size += bp->s.size;
 6fd:	8b 45 fc             	mov    -0x4(%ebp),%eax
 700:	8b 50 04             	mov    0x4(%eax),%edx
 703:	8b 45 f8             	mov    -0x8(%ebp),%eax
 706:	8b 40 04             	mov    0x4(%eax),%eax
 709:	01 c2                	add    %eax,%edx
 70b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 70e:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 711:	8b 45 f8             	mov    -0x8(%ebp),%eax
 714:	8b 10                	mov    (%eax),%edx
 716:	8b 45 fc             	mov    -0x4(%ebp),%eax
 719:	89 10                	mov    %edx,(%eax)
 71b:	eb 08                	jmp    725 <free+0xcd>
  } else
    p->s.ptr = bp;
 71d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 720:	8b 55 f8             	mov    -0x8(%ebp),%edx
 723:	89 10                	mov    %edx,(%eax)
  freep = p;
 725:	8b 45 fc             	mov    -0x4(%ebp),%eax
 728:	a3 60 0b 00 00       	mov    %eax,0xb60
}
 72d:	c9                   	leave  
 72e:	c3                   	ret    

0000072f <morecore>:

static Header*
morecore(uint nu)
{
 72f:	55                   	push   %ebp
 730:	89 e5                	mov    %esp,%ebp
 732:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 735:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 73c:	77 07                	ja     745 <morecore+0x16>
    nu = 4096;
 73e:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 745:	8b 45 08             	mov    0x8(%ebp),%eax
 748:	c1 e0 03             	shl    $0x3,%eax
 74b:	89 04 24             	mov    %eax,(%esp)
 74e:	e8 51 fc ff ff       	call   3a4 <sbrk>
 753:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 756:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 75a:	75 07                	jne    763 <morecore+0x34>
    return 0;
 75c:	b8 00 00 00 00       	mov    $0x0,%eax
 761:	eb 22                	jmp    785 <morecore+0x56>
  hp = (Header*)p;
 763:	8b 45 f4             	mov    -0xc(%ebp),%eax
 766:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 769:	8b 45 f0             	mov    -0x10(%ebp),%eax
 76c:	8b 55 08             	mov    0x8(%ebp),%edx
 76f:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 772:	8b 45 f0             	mov    -0x10(%ebp),%eax
 775:	83 c0 08             	add    $0x8,%eax
 778:	89 04 24             	mov    %eax,(%esp)
 77b:	e8 d8 fe ff ff       	call   658 <free>
  return freep;
 780:	a1 60 0b 00 00       	mov    0xb60,%eax
}
 785:	c9                   	leave  
 786:	c3                   	ret    

00000787 <malloc>:

void*
malloc(uint nbytes)
{
 787:	55                   	push   %ebp
 788:	89 e5                	mov    %esp,%ebp
 78a:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 78d:	8b 45 08             	mov    0x8(%ebp),%eax
 790:	83 c0 07             	add    $0x7,%eax
 793:	c1 e8 03             	shr    $0x3,%eax
 796:	83 c0 01             	add    $0x1,%eax
 799:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 79c:	a1 60 0b 00 00       	mov    0xb60,%eax
 7a1:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7a4:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 7a8:	75 23                	jne    7cd <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 7aa:	c7 45 f0 58 0b 00 00 	movl   $0xb58,-0x10(%ebp)
 7b1:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7b4:	a3 60 0b 00 00       	mov    %eax,0xb60
 7b9:	a1 60 0b 00 00       	mov    0xb60,%eax
 7be:	a3 58 0b 00 00       	mov    %eax,0xb58
    base.s.size = 0;
 7c3:	c7 05 5c 0b 00 00 00 	movl   $0x0,0xb5c
 7ca:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7cd:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7d0:	8b 00                	mov    (%eax),%eax
 7d2:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 7d5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7d8:	8b 40 04             	mov    0x4(%eax),%eax
 7db:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 7de:	72 4d                	jb     82d <malloc+0xa6>
      if(p->s.size == nunits)
 7e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7e3:	8b 40 04             	mov    0x4(%eax),%eax
 7e6:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 7e9:	75 0c                	jne    7f7 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 7eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7ee:	8b 10                	mov    (%eax),%edx
 7f0:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7f3:	89 10                	mov    %edx,(%eax)
 7f5:	eb 26                	jmp    81d <malloc+0x96>
      else {
        p->s.size -= nunits;
 7f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7fa:	8b 40 04             	mov    0x4(%eax),%eax
 7fd:	89 c2                	mov    %eax,%edx
 7ff:	2b 55 ec             	sub    -0x14(%ebp),%edx
 802:	8b 45 f4             	mov    -0xc(%ebp),%eax
 805:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 808:	8b 45 f4             	mov    -0xc(%ebp),%eax
 80b:	8b 40 04             	mov    0x4(%eax),%eax
 80e:	c1 e0 03             	shl    $0x3,%eax
 811:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 814:	8b 45 f4             	mov    -0xc(%ebp),%eax
 817:	8b 55 ec             	mov    -0x14(%ebp),%edx
 81a:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 81d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 820:	a3 60 0b 00 00       	mov    %eax,0xb60
      return (void*)(p + 1);
 825:	8b 45 f4             	mov    -0xc(%ebp),%eax
 828:	83 c0 08             	add    $0x8,%eax
 82b:	eb 38                	jmp    865 <malloc+0xde>
    }
    if(p == freep)
 82d:	a1 60 0b 00 00       	mov    0xb60,%eax
 832:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 835:	75 1b                	jne    852 <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 837:	8b 45 ec             	mov    -0x14(%ebp),%eax
 83a:	89 04 24             	mov    %eax,(%esp)
 83d:	e8 ed fe ff ff       	call   72f <morecore>
 842:	89 45 f4             	mov    %eax,-0xc(%ebp)
 845:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 849:	75 07                	jne    852 <malloc+0xcb>
        return 0;
 84b:	b8 00 00 00 00       	mov    $0x0,%eax
 850:	eb 13                	jmp    865 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 852:	8b 45 f4             	mov    -0xc(%ebp),%eax
 855:	89 45 f0             	mov    %eax,-0x10(%ebp)
 858:	8b 45 f4             	mov    -0xc(%ebp),%eax
 85b:	8b 00                	mov    (%eax),%eax
 85d:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 860:	e9 70 ff ff ff       	jmp    7d5 <malloc+0x4e>
}
 865:	c9                   	leave  
 866:	c3                   	ret    
