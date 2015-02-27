
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
    // __asm__ ("ret \n\t");
    // printf(1, "in restorer\n");
    // exit();
    // __asm__ ("jmp 78 <main+0x57>\n\t");
    // __asm__ ("jmp 78\n\t");
    __asm__ ("movl $0x66,4(%ebp)\n\t");
   3:	c7 45 04 66 00 00 00 	movl   $0x66,0x4(%ebp)
    __asm__ ("movl 8(%ebp),%ecx\n\t");
   a:	8b 4d 08             	mov    0x8(%ebp),%ecx
    // __asm__ ("movl $0x5,%ecx\n\t");
   d:	5d                   	pop    %ebp
   e:	c3                   	ret    

0000000f <main>:
#include "restorer.h"

void handle_signal(int);

int main(void)
{
   f:	55                   	push   %ebp
  10:	89 e5                	mov    %esp,%ebp
  12:	83 e4 f0             	and    $0xfffffff0,%esp
  15:	83 ec 20             	sub    $0x20,%esp
    register int ecx asm ("%ecx");
    // restorer();
    signal(-1, (sighandler_t*) restorer);   // save the address of restorer function inside the kernel.
  18:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  1f:	00 
  20:	c7 04 24 ff ff ff ff 	movl   $0xffffffff,(%esp)
  27:	e8 94 03 00 00       	call   3c0 <signal>
    signal(SIGFPE, handle_signal);         // register the actual signal for divide by zero.
  2c:	c7 44 24 04 a8 00 00 	movl   $0xa8,0x4(%esp)
  33:	00 
  34:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  3b:	e8 80 03 00 00       	call   3c0 <signal>

    int x = 5;
  40:	c7 44 24 1c 05 00 00 	movl   $0x5,0x1c(%esp)
  47:	00 
    int y = 0;
  48:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
  4f:	00 

    ecx = 5;
  50:	b9 05 00 00 00       	mov    $0x5,%ecx
    x = x / y;
  55:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  59:	89 c2                	mov    %eax,%edx
  5b:	c1 fa 1f             	sar    $0x1f,%edx
  5e:	f7 7c 24 18          	idivl  0x18(%esp)
  62:	89 44 24 1c          	mov    %eax,0x1c(%esp)

    if (ecx == 5)
  66:	89 c8                	mov    %ecx,%eax
  68:	83 f8 05             	cmp    $0x5,%eax
  6b:	75 1c                	jne    89 <main+0x7a>
        printf(1, "TEST PASSED: Final value of ecx is %d...\n", ecx);
  6d:	89 c8                	mov    %ecx,%eax
  6f:	89 44 24 08          	mov    %eax,0x8(%esp)
  73:	c7 44 24 04 64 08 00 	movl   $0x864,0x4(%esp)
  7a:	00 
  7b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  82:	e8 18 04 00 00       	call   49f <printf>
  87:	eb 1a                	jmp    a3 <main+0x94>
    else
        printf(1, "TEST FAILED: Final value of ecx is %d...\n", ecx);
  89:	89 c8                	mov    %ecx,%eax
  8b:	89 44 24 08          	mov    %eax,0x8(%esp)
  8f:	c7 44 24 04 90 08 00 	movl   $0x890,0x4(%esp)
  96:	00 
  97:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  9e:	e8 fc 03 00 00       	call   49f <printf>

    exit();
  a3:	e8 70 02 00 00       	call   318 <exit>

000000a8 <handle_signal>:
}

void handle_signal(int signum)
{
  a8:	55                   	push   %ebp
  a9:	89 e5                	mov    %esp,%ebp
    // printf(1, "in handler\n");
    // exit();

    __asm__ ("movl $0x0,%ecx\n\t");
  ab:	b9 00 00 00 00       	mov    $0x0,%ecx
	// Add your code to skip the return ip here
    // __asm__ ("movl $0x0,4(%ebp)\n\t");
  b0:	5d                   	pop    %ebp
  b1:	c3                   	ret    
  b2:	90                   	nop
  b3:	90                   	nop

000000b4 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  b4:	55                   	push   %ebp
  b5:	89 e5                	mov    %esp,%ebp
  b7:	57                   	push   %edi
  b8:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  b9:	8b 4d 08             	mov    0x8(%ebp),%ecx
  bc:	8b 55 10             	mov    0x10(%ebp),%edx
  bf:	8b 45 0c             	mov    0xc(%ebp),%eax
  c2:	89 cb                	mov    %ecx,%ebx
  c4:	89 df                	mov    %ebx,%edi
  c6:	89 d1                	mov    %edx,%ecx
  c8:	fc                   	cld    
  c9:	f3 aa                	rep stos %al,%es:(%edi)
  cb:	89 ca                	mov    %ecx,%edx
  cd:	89 fb                	mov    %edi,%ebx
  cf:	89 5d 08             	mov    %ebx,0x8(%ebp)
  d2:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  d5:	5b                   	pop    %ebx
  d6:	5f                   	pop    %edi
  d7:	5d                   	pop    %ebp
  d8:	c3                   	ret    

000000d9 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  d9:	55                   	push   %ebp
  da:	89 e5                	mov    %esp,%ebp
  dc:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  df:	8b 45 08             	mov    0x8(%ebp),%eax
  e2:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  e5:	90                   	nop
  e6:	8b 45 0c             	mov    0xc(%ebp),%eax
  e9:	0f b6 10             	movzbl (%eax),%edx
  ec:	8b 45 08             	mov    0x8(%ebp),%eax
  ef:	88 10                	mov    %dl,(%eax)
  f1:	8b 45 08             	mov    0x8(%ebp),%eax
  f4:	0f b6 00             	movzbl (%eax),%eax
  f7:	84 c0                	test   %al,%al
  f9:	0f 95 c0             	setne  %al
  fc:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 100:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
 104:	84 c0                	test   %al,%al
 106:	75 de                	jne    e6 <strcpy+0xd>
    ;
  return os;
 108:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 10b:	c9                   	leave  
 10c:	c3                   	ret    

0000010d <strcmp>:

int
strcmp(const char *p, const char *q)
{
 10d:	55                   	push   %ebp
 10e:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 110:	eb 08                	jmp    11a <strcmp+0xd>
    p++, q++;
 112:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 116:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 11a:	8b 45 08             	mov    0x8(%ebp),%eax
 11d:	0f b6 00             	movzbl (%eax),%eax
 120:	84 c0                	test   %al,%al
 122:	74 10                	je     134 <strcmp+0x27>
 124:	8b 45 08             	mov    0x8(%ebp),%eax
 127:	0f b6 10             	movzbl (%eax),%edx
 12a:	8b 45 0c             	mov    0xc(%ebp),%eax
 12d:	0f b6 00             	movzbl (%eax),%eax
 130:	38 c2                	cmp    %al,%dl
 132:	74 de                	je     112 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 134:	8b 45 08             	mov    0x8(%ebp),%eax
 137:	0f b6 00             	movzbl (%eax),%eax
 13a:	0f b6 d0             	movzbl %al,%edx
 13d:	8b 45 0c             	mov    0xc(%ebp),%eax
 140:	0f b6 00             	movzbl (%eax),%eax
 143:	0f b6 c0             	movzbl %al,%eax
 146:	89 d1                	mov    %edx,%ecx
 148:	29 c1                	sub    %eax,%ecx
 14a:	89 c8                	mov    %ecx,%eax
}
 14c:	5d                   	pop    %ebp
 14d:	c3                   	ret    

0000014e <strlen>:

uint
strlen(char *s)
{
 14e:	55                   	push   %ebp
 14f:	89 e5                	mov    %esp,%ebp
 151:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 154:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 15b:	eb 04                	jmp    161 <strlen+0x13>
 15d:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 161:	8b 45 fc             	mov    -0x4(%ebp),%eax
 164:	03 45 08             	add    0x8(%ebp),%eax
 167:	0f b6 00             	movzbl (%eax),%eax
 16a:	84 c0                	test   %al,%al
 16c:	75 ef                	jne    15d <strlen+0xf>
    ;
  return n;
 16e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 171:	c9                   	leave  
 172:	c3                   	ret    

00000173 <memset>:

void*
memset(void *dst, int c, uint n)
{
 173:	55                   	push   %ebp
 174:	89 e5                	mov    %esp,%ebp
 176:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
 179:	8b 45 10             	mov    0x10(%ebp),%eax
 17c:	89 44 24 08          	mov    %eax,0x8(%esp)
 180:	8b 45 0c             	mov    0xc(%ebp),%eax
 183:	89 44 24 04          	mov    %eax,0x4(%esp)
 187:	8b 45 08             	mov    0x8(%ebp),%eax
 18a:	89 04 24             	mov    %eax,(%esp)
 18d:	e8 22 ff ff ff       	call   b4 <stosb>
  return dst;
 192:	8b 45 08             	mov    0x8(%ebp),%eax
}
 195:	c9                   	leave  
 196:	c3                   	ret    

00000197 <strchr>:

char*
strchr(const char *s, char c)
{
 197:	55                   	push   %ebp
 198:	89 e5                	mov    %esp,%ebp
 19a:	83 ec 04             	sub    $0x4,%esp
 19d:	8b 45 0c             	mov    0xc(%ebp),%eax
 1a0:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 1a3:	eb 14                	jmp    1b9 <strchr+0x22>
    if(*s == c)
 1a5:	8b 45 08             	mov    0x8(%ebp),%eax
 1a8:	0f b6 00             	movzbl (%eax),%eax
 1ab:	3a 45 fc             	cmp    -0x4(%ebp),%al
 1ae:	75 05                	jne    1b5 <strchr+0x1e>
      return (char*)s;
 1b0:	8b 45 08             	mov    0x8(%ebp),%eax
 1b3:	eb 13                	jmp    1c8 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 1b5:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 1b9:	8b 45 08             	mov    0x8(%ebp),%eax
 1bc:	0f b6 00             	movzbl (%eax),%eax
 1bf:	84 c0                	test   %al,%al
 1c1:	75 e2                	jne    1a5 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 1c3:	b8 00 00 00 00       	mov    $0x0,%eax
}
 1c8:	c9                   	leave  
 1c9:	c3                   	ret    

000001ca <gets>:

char*
gets(char *buf, int max)
{
 1ca:	55                   	push   %ebp
 1cb:	89 e5                	mov    %esp,%ebp
 1cd:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1d0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 1d7:	eb 44                	jmp    21d <gets+0x53>
    cc = read(0, &c, 1);
 1d9:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 1e0:	00 
 1e1:	8d 45 ef             	lea    -0x11(%ebp),%eax
 1e4:	89 44 24 04          	mov    %eax,0x4(%esp)
 1e8:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 1ef:	e8 3c 01 00 00       	call   330 <read>
 1f4:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 1f7:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 1fb:	7e 2d                	jle    22a <gets+0x60>
      break;
    buf[i++] = c;
 1fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
 200:	03 45 08             	add    0x8(%ebp),%eax
 203:	0f b6 55 ef          	movzbl -0x11(%ebp),%edx
 207:	88 10                	mov    %dl,(%eax)
 209:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(c == '\n' || c == '\r')
 20d:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 211:	3c 0a                	cmp    $0xa,%al
 213:	74 16                	je     22b <gets+0x61>
 215:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 219:	3c 0d                	cmp    $0xd,%al
 21b:	74 0e                	je     22b <gets+0x61>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 21d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 220:	83 c0 01             	add    $0x1,%eax
 223:	3b 45 0c             	cmp    0xc(%ebp),%eax
 226:	7c b1                	jl     1d9 <gets+0xf>
 228:	eb 01                	jmp    22b <gets+0x61>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 22a:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 22b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 22e:	03 45 08             	add    0x8(%ebp),%eax
 231:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 234:	8b 45 08             	mov    0x8(%ebp),%eax
}
 237:	c9                   	leave  
 238:	c3                   	ret    

00000239 <stat>:

int
stat(char *n, struct stat *st)
{
 239:	55                   	push   %ebp
 23a:	89 e5                	mov    %esp,%ebp
 23c:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 23f:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 246:	00 
 247:	8b 45 08             	mov    0x8(%ebp),%eax
 24a:	89 04 24             	mov    %eax,(%esp)
 24d:	e8 06 01 00 00       	call   358 <open>
 252:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 255:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 259:	79 07                	jns    262 <stat+0x29>
    return -1;
 25b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 260:	eb 23                	jmp    285 <stat+0x4c>
  r = fstat(fd, st);
 262:	8b 45 0c             	mov    0xc(%ebp),%eax
 265:	89 44 24 04          	mov    %eax,0x4(%esp)
 269:	8b 45 f4             	mov    -0xc(%ebp),%eax
 26c:	89 04 24             	mov    %eax,(%esp)
 26f:	e8 fc 00 00 00       	call   370 <fstat>
 274:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 277:	8b 45 f4             	mov    -0xc(%ebp),%eax
 27a:	89 04 24             	mov    %eax,(%esp)
 27d:	e8 be 00 00 00       	call   340 <close>
  return r;
 282:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 285:	c9                   	leave  
 286:	c3                   	ret    

00000287 <atoi>:

int
atoi(const char *s)
{
 287:	55                   	push   %ebp
 288:	89 e5                	mov    %esp,%ebp
 28a:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 28d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 294:	eb 23                	jmp    2b9 <atoi+0x32>
    n = n*10 + *s++ - '0';
 296:	8b 55 fc             	mov    -0x4(%ebp),%edx
 299:	89 d0                	mov    %edx,%eax
 29b:	c1 e0 02             	shl    $0x2,%eax
 29e:	01 d0                	add    %edx,%eax
 2a0:	01 c0                	add    %eax,%eax
 2a2:	89 c2                	mov    %eax,%edx
 2a4:	8b 45 08             	mov    0x8(%ebp),%eax
 2a7:	0f b6 00             	movzbl (%eax),%eax
 2aa:	0f be c0             	movsbl %al,%eax
 2ad:	01 d0                	add    %edx,%eax
 2af:	83 e8 30             	sub    $0x30,%eax
 2b2:	89 45 fc             	mov    %eax,-0x4(%ebp)
 2b5:	83 45 08 01          	addl   $0x1,0x8(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2b9:	8b 45 08             	mov    0x8(%ebp),%eax
 2bc:	0f b6 00             	movzbl (%eax),%eax
 2bf:	3c 2f                	cmp    $0x2f,%al
 2c1:	7e 0a                	jle    2cd <atoi+0x46>
 2c3:	8b 45 08             	mov    0x8(%ebp),%eax
 2c6:	0f b6 00             	movzbl (%eax),%eax
 2c9:	3c 39                	cmp    $0x39,%al
 2cb:	7e c9                	jle    296 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 2cd:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 2d0:	c9                   	leave  
 2d1:	c3                   	ret    

000002d2 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 2d2:	55                   	push   %ebp
 2d3:	89 e5                	mov    %esp,%ebp
 2d5:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 2d8:	8b 45 08             	mov    0x8(%ebp),%eax
 2db:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 2de:	8b 45 0c             	mov    0xc(%ebp),%eax
 2e1:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 2e4:	eb 13                	jmp    2f9 <memmove+0x27>
    *dst++ = *src++;
 2e6:	8b 45 f8             	mov    -0x8(%ebp),%eax
 2e9:	0f b6 10             	movzbl (%eax),%edx
 2ec:	8b 45 fc             	mov    -0x4(%ebp),%eax
 2ef:	88 10                	mov    %dl,(%eax)
 2f1:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 2f5:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2f9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
 2fd:	0f 9f c0             	setg   %al
 300:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
 304:	84 c0                	test   %al,%al
 306:	75 de                	jne    2e6 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 308:	8b 45 08             	mov    0x8(%ebp),%eax
}
 30b:	c9                   	leave  
 30c:	c3                   	ret    
 30d:	90                   	nop
 30e:	90                   	nop
 30f:	90                   	nop

00000310 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 310:	b8 01 00 00 00       	mov    $0x1,%eax
 315:	cd 40                	int    $0x40
 317:	c3                   	ret    

00000318 <exit>:
SYSCALL(exit)
 318:	b8 02 00 00 00       	mov    $0x2,%eax
 31d:	cd 40                	int    $0x40
 31f:	c3                   	ret    

00000320 <wait>:
SYSCALL(wait)
 320:	b8 03 00 00 00       	mov    $0x3,%eax
 325:	cd 40                	int    $0x40
 327:	c3                   	ret    

00000328 <pipe>:
SYSCALL(pipe)
 328:	b8 04 00 00 00       	mov    $0x4,%eax
 32d:	cd 40                	int    $0x40
 32f:	c3                   	ret    

00000330 <read>:
SYSCALL(read)
 330:	b8 05 00 00 00       	mov    $0x5,%eax
 335:	cd 40                	int    $0x40
 337:	c3                   	ret    

00000338 <write>:
SYSCALL(write)
 338:	b8 10 00 00 00       	mov    $0x10,%eax
 33d:	cd 40                	int    $0x40
 33f:	c3                   	ret    

00000340 <close>:
SYSCALL(close)
 340:	b8 15 00 00 00       	mov    $0x15,%eax
 345:	cd 40                	int    $0x40
 347:	c3                   	ret    

00000348 <kill>:
SYSCALL(kill)
 348:	b8 06 00 00 00       	mov    $0x6,%eax
 34d:	cd 40                	int    $0x40
 34f:	c3                   	ret    

00000350 <exec>:
SYSCALL(exec)
 350:	b8 07 00 00 00       	mov    $0x7,%eax
 355:	cd 40                	int    $0x40
 357:	c3                   	ret    

00000358 <open>:
SYSCALL(open)
 358:	b8 0f 00 00 00       	mov    $0xf,%eax
 35d:	cd 40                	int    $0x40
 35f:	c3                   	ret    

00000360 <mknod>:
SYSCALL(mknod)
 360:	b8 11 00 00 00       	mov    $0x11,%eax
 365:	cd 40                	int    $0x40
 367:	c3                   	ret    

00000368 <unlink>:
SYSCALL(unlink)
 368:	b8 12 00 00 00       	mov    $0x12,%eax
 36d:	cd 40                	int    $0x40
 36f:	c3                   	ret    

00000370 <fstat>:
SYSCALL(fstat)
 370:	b8 08 00 00 00       	mov    $0x8,%eax
 375:	cd 40                	int    $0x40
 377:	c3                   	ret    

00000378 <link>:
SYSCALL(link)
 378:	b8 13 00 00 00       	mov    $0x13,%eax
 37d:	cd 40                	int    $0x40
 37f:	c3                   	ret    

00000380 <mkdir>:
SYSCALL(mkdir)
 380:	b8 14 00 00 00       	mov    $0x14,%eax
 385:	cd 40                	int    $0x40
 387:	c3                   	ret    

00000388 <chdir>:
SYSCALL(chdir)
 388:	b8 09 00 00 00       	mov    $0x9,%eax
 38d:	cd 40                	int    $0x40
 38f:	c3                   	ret    

00000390 <dup>:
SYSCALL(dup)
 390:	b8 0a 00 00 00       	mov    $0xa,%eax
 395:	cd 40                	int    $0x40
 397:	c3                   	ret    

00000398 <getpid>:
SYSCALL(getpid)
 398:	b8 0b 00 00 00       	mov    $0xb,%eax
 39d:	cd 40                	int    $0x40
 39f:	c3                   	ret    

000003a0 <sbrk>:
SYSCALL(sbrk)
 3a0:	b8 0c 00 00 00       	mov    $0xc,%eax
 3a5:	cd 40                	int    $0x40
 3a7:	c3                   	ret    

000003a8 <sleep>:
SYSCALL(sleep)
 3a8:	b8 0d 00 00 00       	mov    $0xd,%eax
 3ad:	cd 40                	int    $0x40
 3af:	c3                   	ret    

000003b0 <uptime>:
SYSCALL(uptime)
 3b0:	b8 0e 00 00 00       	mov    $0xe,%eax
 3b5:	cd 40                	int    $0x40
 3b7:	c3                   	ret    

000003b8 <halt>:
SYSCALL(halt)
 3b8:	b8 16 00 00 00       	mov    $0x16,%eax
 3bd:	cd 40                	int    $0x40
 3bf:	c3                   	ret    

000003c0 <signal>:
 3c0:	b8 17 00 00 00       	mov    $0x17,%eax
 3c5:	cd 40                	int    $0x40
 3c7:	c3                   	ret    

000003c8 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 3c8:	55                   	push   %ebp
 3c9:	89 e5                	mov    %esp,%ebp
 3cb:	83 ec 28             	sub    $0x28,%esp
 3ce:	8b 45 0c             	mov    0xc(%ebp),%eax
 3d1:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 3d4:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 3db:	00 
 3dc:	8d 45 f4             	lea    -0xc(%ebp),%eax
 3df:	89 44 24 04          	mov    %eax,0x4(%esp)
 3e3:	8b 45 08             	mov    0x8(%ebp),%eax
 3e6:	89 04 24             	mov    %eax,(%esp)
 3e9:	e8 4a ff ff ff       	call   338 <write>
}
 3ee:	c9                   	leave  
 3ef:	c3                   	ret    

000003f0 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 3f0:	55                   	push   %ebp
 3f1:	89 e5                	mov    %esp,%ebp
 3f3:	83 ec 48             	sub    $0x48,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 3f6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 3fd:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 401:	74 17                	je     41a <printint+0x2a>
 403:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 407:	79 11                	jns    41a <printint+0x2a>
    neg = 1;
 409:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 410:	8b 45 0c             	mov    0xc(%ebp),%eax
 413:	f7 d8                	neg    %eax
 415:	89 45 ec             	mov    %eax,-0x14(%ebp)
 418:	eb 06                	jmp    420 <printint+0x30>
  } else {
    x = xx;
 41a:	8b 45 0c             	mov    0xc(%ebp),%eax
 41d:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 420:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 427:	8b 4d 10             	mov    0x10(%ebp),%ecx
 42a:	8b 45 ec             	mov    -0x14(%ebp),%eax
 42d:	ba 00 00 00 00       	mov    $0x0,%edx
 432:	f7 f1                	div    %ecx
 434:	89 d0                	mov    %edx,%eax
 436:	0f b6 90 40 0b 00 00 	movzbl 0xb40(%eax),%edx
 43d:	8d 45 dc             	lea    -0x24(%ebp),%eax
 440:	03 45 f4             	add    -0xc(%ebp),%eax
 443:	88 10                	mov    %dl,(%eax)
 445:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  }while((x /= base) != 0);
 449:	8b 55 10             	mov    0x10(%ebp),%edx
 44c:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 44f:	8b 45 ec             	mov    -0x14(%ebp),%eax
 452:	ba 00 00 00 00       	mov    $0x0,%edx
 457:	f7 75 d4             	divl   -0x2c(%ebp)
 45a:	89 45 ec             	mov    %eax,-0x14(%ebp)
 45d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 461:	75 c4                	jne    427 <printint+0x37>
  if(neg)
 463:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 467:	74 2a                	je     493 <printint+0xa3>
    buf[i++] = '-';
 469:	8d 45 dc             	lea    -0x24(%ebp),%eax
 46c:	03 45 f4             	add    -0xc(%ebp),%eax
 46f:	c6 00 2d             	movb   $0x2d,(%eax)
 472:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)

  while(--i >= 0)
 476:	eb 1b                	jmp    493 <printint+0xa3>
    putc(fd, buf[i]);
 478:	8d 45 dc             	lea    -0x24(%ebp),%eax
 47b:	03 45 f4             	add    -0xc(%ebp),%eax
 47e:	0f b6 00             	movzbl (%eax),%eax
 481:	0f be c0             	movsbl %al,%eax
 484:	89 44 24 04          	mov    %eax,0x4(%esp)
 488:	8b 45 08             	mov    0x8(%ebp),%eax
 48b:	89 04 24             	mov    %eax,(%esp)
 48e:	e8 35 ff ff ff       	call   3c8 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 493:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 497:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 49b:	79 db                	jns    478 <printint+0x88>
    putc(fd, buf[i]);
}
 49d:	c9                   	leave  
 49e:	c3                   	ret    

0000049f <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 49f:	55                   	push   %ebp
 4a0:	89 e5                	mov    %esp,%ebp
 4a2:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 4a5:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 4ac:	8d 45 0c             	lea    0xc(%ebp),%eax
 4af:	83 c0 04             	add    $0x4,%eax
 4b2:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 4b5:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 4bc:	e9 7d 01 00 00       	jmp    63e <printf+0x19f>
    c = fmt[i] & 0xff;
 4c1:	8b 55 0c             	mov    0xc(%ebp),%edx
 4c4:	8b 45 f0             	mov    -0x10(%ebp),%eax
 4c7:	01 d0                	add    %edx,%eax
 4c9:	0f b6 00             	movzbl (%eax),%eax
 4cc:	0f be c0             	movsbl %al,%eax
 4cf:	25 ff 00 00 00       	and    $0xff,%eax
 4d4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 4d7:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 4db:	75 2c                	jne    509 <printf+0x6a>
      if(c == '%'){
 4dd:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 4e1:	75 0c                	jne    4ef <printf+0x50>
        state = '%';
 4e3:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 4ea:	e9 4b 01 00 00       	jmp    63a <printf+0x19b>
      } else {
        putc(fd, c);
 4ef:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 4f2:	0f be c0             	movsbl %al,%eax
 4f5:	89 44 24 04          	mov    %eax,0x4(%esp)
 4f9:	8b 45 08             	mov    0x8(%ebp),%eax
 4fc:	89 04 24             	mov    %eax,(%esp)
 4ff:	e8 c4 fe ff ff       	call   3c8 <putc>
 504:	e9 31 01 00 00       	jmp    63a <printf+0x19b>
      }
    } else if(state == '%'){
 509:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 50d:	0f 85 27 01 00 00    	jne    63a <printf+0x19b>
      if(c == 'd'){
 513:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 517:	75 2d                	jne    546 <printf+0xa7>
        printint(fd, *ap, 10, 1);
 519:	8b 45 e8             	mov    -0x18(%ebp),%eax
 51c:	8b 00                	mov    (%eax),%eax
 51e:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 525:	00 
 526:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 52d:	00 
 52e:	89 44 24 04          	mov    %eax,0x4(%esp)
 532:	8b 45 08             	mov    0x8(%ebp),%eax
 535:	89 04 24             	mov    %eax,(%esp)
 538:	e8 b3 fe ff ff       	call   3f0 <printint>
        ap++;
 53d:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 541:	e9 ed 00 00 00       	jmp    633 <printf+0x194>
      } else if(c == 'x' || c == 'p'){
 546:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 54a:	74 06                	je     552 <printf+0xb3>
 54c:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 550:	75 2d                	jne    57f <printf+0xe0>
        printint(fd, *ap, 16, 0);
 552:	8b 45 e8             	mov    -0x18(%ebp),%eax
 555:	8b 00                	mov    (%eax),%eax
 557:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 55e:	00 
 55f:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 566:	00 
 567:	89 44 24 04          	mov    %eax,0x4(%esp)
 56b:	8b 45 08             	mov    0x8(%ebp),%eax
 56e:	89 04 24             	mov    %eax,(%esp)
 571:	e8 7a fe ff ff       	call   3f0 <printint>
        ap++;
 576:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 57a:	e9 b4 00 00 00       	jmp    633 <printf+0x194>
      } else if(c == 's'){
 57f:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 583:	75 46                	jne    5cb <printf+0x12c>
        s = (char*)*ap;
 585:	8b 45 e8             	mov    -0x18(%ebp),%eax
 588:	8b 00                	mov    (%eax),%eax
 58a:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 58d:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 591:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 595:	75 27                	jne    5be <printf+0x11f>
          s = "(null)";
 597:	c7 45 f4 ba 08 00 00 	movl   $0x8ba,-0xc(%ebp)
        while(*s != 0){
 59e:	eb 1e                	jmp    5be <printf+0x11f>
          putc(fd, *s);
 5a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5a3:	0f b6 00             	movzbl (%eax),%eax
 5a6:	0f be c0             	movsbl %al,%eax
 5a9:	89 44 24 04          	mov    %eax,0x4(%esp)
 5ad:	8b 45 08             	mov    0x8(%ebp),%eax
 5b0:	89 04 24             	mov    %eax,(%esp)
 5b3:	e8 10 fe ff ff       	call   3c8 <putc>
          s++;
 5b8:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 5bc:	eb 01                	jmp    5bf <printf+0x120>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 5be:	90                   	nop
 5bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5c2:	0f b6 00             	movzbl (%eax),%eax
 5c5:	84 c0                	test   %al,%al
 5c7:	75 d7                	jne    5a0 <printf+0x101>
 5c9:	eb 68                	jmp    633 <printf+0x194>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5cb:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 5cf:	75 1d                	jne    5ee <printf+0x14f>
        putc(fd, *ap);
 5d1:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5d4:	8b 00                	mov    (%eax),%eax
 5d6:	0f be c0             	movsbl %al,%eax
 5d9:	89 44 24 04          	mov    %eax,0x4(%esp)
 5dd:	8b 45 08             	mov    0x8(%ebp),%eax
 5e0:	89 04 24             	mov    %eax,(%esp)
 5e3:	e8 e0 fd ff ff       	call   3c8 <putc>
        ap++;
 5e8:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5ec:	eb 45                	jmp    633 <printf+0x194>
      } else if(c == '%'){
 5ee:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 5f2:	75 17                	jne    60b <printf+0x16c>
        putc(fd, c);
 5f4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5f7:	0f be c0             	movsbl %al,%eax
 5fa:	89 44 24 04          	mov    %eax,0x4(%esp)
 5fe:	8b 45 08             	mov    0x8(%ebp),%eax
 601:	89 04 24             	mov    %eax,(%esp)
 604:	e8 bf fd ff ff       	call   3c8 <putc>
 609:	eb 28                	jmp    633 <printf+0x194>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 60b:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 612:	00 
 613:	8b 45 08             	mov    0x8(%ebp),%eax
 616:	89 04 24             	mov    %eax,(%esp)
 619:	e8 aa fd ff ff       	call   3c8 <putc>
        putc(fd, c);
 61e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 621:	0f be c0             	movsbl %al,%eax
 624:	89 44 24 04          	mov    %eax,0x4(%esp)
 628:	8b 45 08             	mov    0x8(%ebp),%eax
 62b:	89 04 24             	mov    %eax,(%esp)
 62e:	e8 95 fd ff ff       	call   3c8 <putc>
      }
      state = 0;
 633:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 63a:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 63e:	8b 55 0c             	mov    0xc(%ebp),%edx
 641:	8b 45 f0             	mov    -0x10(%ebp),%eax
 644:	01 d0                	add    %edx,%eax
 646:	0f b6 00             	movzbl (%eax),%eax
 649:	84 c0                	test   %al,%al
 64b:	0f 85 70 fe ff ff    	jne    4c1 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 651:	c9                   	leave  
 652:	c3                   	ret    
 653:	90                   	nop

00000654 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 654:	55                   	push   %ebp
 655:	89 e5                	mov    %esp,%ebp
 657:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 65a:	8b 45 08             	mov    0x8(%ebp),%eax
 65d:	83 e8 08             	sub    $0x8,%eax
 660:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 663:	a1 5c 0b 00 00       	mov    0xb5c,%eax
 668:	89 45 fc             	mov    %eax,-0x4(%ebp)
 66b:	eb 24                	jmp    691 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 66d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 670:	8b 00                	mov    (%eax),%eax
 672:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 675:	77 12                	ja     689 <free+0x35>
 677:	8b 45 f8             	mov    -0x8(%ebp),%eax
 67a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 67d:	77 24                	ja     6a3 <free+0x4f>
 67f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 682:	8b 00                	mov    (%eax),%eax
 684:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 687:	77 1a                	ja     6a3 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 689:	8b 45 fc             	mov    -0x4(%ebp),%eax
 68c:	8b 00                	mov    (%eax),%eax
 68e:	89 45 fc             	mov    %eax,-0x4(%ebp)
 691:	8b 45 f8             	mov    -0x8(%ebp),%eax
 694:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 697:	76 d4                	jbe    66d <free+0x19>
 699:	8b 45 fc             	mov    -0x4(%ebp),%eax
 69c:	8b 00                	mov    (%eax),%eax
 69e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6a1:	76 ca                	jbe    66d <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 6a3:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6a6:	8b 40 04             	mov    0x4(%eax),%eax
 6a9:	c1 e0 03             	shl    $0x3,%eax
 6ac:	89 c2                	mov    %eax,%edx
 6ae:	03 55 f8             	add    -0x8(%ebp),%edx
 6b1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6b4:	8b 00                	mov    (%eax),%eax
 6b6:	39 c2                	cmp    %eax,%edx
 6b8:	75 24                	jne    6de <free+0x8a>
    bp->s.size += p->s.ptr->s.size;
 6ba:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6bd:	8b 50 04             	mov    0x4(%eax),%edx
 6c0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6c3:	8b 00                	mov    (%eax),%eax
 6c5:	8b 40 04             	mov    0x4(%eax),%eax
 6c8:	01 c2                	add    %eax,%edx
 6ca:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6cd:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 6d0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6d3:	8b 00                	mov    (%eax),%eax
 6d5:	8b 10                	mov    (%eax),%edx
 6d7:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6da:	89 10                	mov    %edx,(%eax)
 6dc:	eb 0a                	jmp    6e8 <free+0x94>
  } else
    bp->s.ptr = p->s.ptr;
 6de:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6e1:	8b 10                	mov    (%eax),%edx
 6e3:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6e6:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 6e8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6eb:	8b 40 04             	mov    0x4(%eax),%eax
 6ee:	c1 e0 03             	shl    $0x3,%eax
 6f1:	03 45 fc             	add    -0x4(%ebp),%eax
 6f4:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6f7:	75 20                	jne    719 <free+0xc5>
    p->s.size += bp->s.size;
 6f9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6fc:	8b 50 04             	mov    0x4(%eax),%edx
 6ff:	8b 45 f8             	mov    -0x8(%ebp),%eax
 702:	8b 40 04             	mov    0x4(%eax),%eax
 705:	01 c2                	add    %eax,%edx
 707:	8b 45 fc             	mov    -0x4(%ebp),%eax
 70a:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 70d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 710:	8b 10                	mov    (%eax),%edx
 712:	8b 45 fc             	mov    -0x4(%ebp),%eax
 715:	89 10                	mov    %edx,(%eax)
 717:	eb 08                	jmp    721 <free+0xcd>
  } else
    p->s.ptr = bp;
 719:	8b 45 fc             	mov    -0x4(%ebp),%eax
 71c:	8b 55 f8             	mov    -0x8(%ebp),%edx
 71f:	89 10                	mov    %edx,(%eax)
  freep = p;
 721:	8b 45 fc             	mov    -0x4(%ebp),%eax
 724:	a3 5c 0b 00 00       	mov    %eax,0xb5c
}
 729:	c9                   	leave  
 72a:	c3                   	ret    

0000072b <morecore>:

static Header*
morecore(uint nu)
{
 72b:	55                   	push   %ebp
 72c:	89 e5                	mov    %esp,%ebp
 72e:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 731:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 738:	77 07                	ja     741 <morecore+0x16>
    nu = 4096;
 73a:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 741:	8b 45 08             	mov    0x8(%ebp),%eax
 744:	c1 e0 03             	shl    $0x3,%eax
 747:	89 04 24             	mov    %eax,(%esp)
 74a:	e8 51 fc ff ff       	call   3a0 <sbrk>
 74f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 752:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 756:	75 07                	jne    75f <morecore+0x34>
    return 0;
 758:	b8 00 00 00 00       	mov    $0x0,%eax
 75d:	eb 22                	jmp    781 <morecore+0x56>
  hp = (Header*)p;
 75f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 762:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 765:	8b 45 f0             	mov    -0x10(%ebp),%eax
 768:	8b 55 08             	mov    0x8(%ebp),%edx
 76b:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 76e:	8b 45 f0             	mov    -0x10(%ebp),%eax
 771:	83 c0 08             	add    $0x8,%eax
 774:	89 04 24             	mov    %eax,(%esp)
 777:	e8 d8 fe ff ff       	call   654 <free>
  return freep;
 77c:	a1 5c 0b 00 00       	mov    0xb5c,%eax
}
 781:	c9                   	leave  
 782:	c3                   	ret    

00000783 <malloc>:

void*
malloc(uint nbytes)
{
 783:	55                   	push   %ebp
 784:	89 e5                	mov    %esp,%ebp
 786:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 789:	8b 45 08             	mov    0x8(%ebp),%eax
 78c:	83 c0 07             	add    $0x7,%eax
 78f:	c1 e8 03             	shr    $0x3,%eax
 792:	83 c0 01             	add    $0x1,%eax
 795:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 798:	a1 5c 0b 00 00       	mov    0xb5c,%eax
 79d:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7a0:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 7a4:	75 23                	jne    7c9 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 7a6:	c7 45 f0 54 0b 00 00 	movl   $0xb54,-0x10(%ebp)
 7ad:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7b0:	a3 5c 0b 00 00       	mov    %eax,0xb5c
 7b5:	a1 5c 0b 00 00       	mov    0xb5c,%eax
 7ba:	a3 54 0b 00 00       	mov    %eax,0xb54
    base.s.size = 0;
 7bf:	c7 05 58 0b 00 00 00 	movl   $0x0,0xb58
 7c6:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7c9:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7cc:	8b 00                	mov    (%eax),%eax
 7ce:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 7d1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7d4:	8b 40 04             	mov    0x4(%eax),%eax
 7d7:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 7da:	72 4d                	jb     829 <malloc+0xa6>
      if(p->s.size == nunits)
 7dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7df:	8b 40 04             	mov    0x4(%eax),%eax
 7e2:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 7e5:	75 0c                	jne    7f3 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 7e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7ea:	8b 10                	mov    (%eax),%edx
 7ec:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7ef:	89 10                	mov    %edx,(%eax)
 7f1:	eb 26                	jmp    819 <malloc+0x96>
      else {
        p->s.size -= nunits;
 7f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7f6:	8b 40 04             	mov    0x4(%eax),%eax
 7f9:	89 c2                	mov    %eax,%edx
 7fb:	2b 55 ec             	sub    -0x14(%ebp),%edx
 7fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
 801:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 804:	8b 45 f4             	mov    -0xc(%ebp),%eax
 807:	8b 40 04             	mov    0x4(%eax),%eax
 80a:	c1 e0 03             	shl    $0x3,%eax
 80d:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 810:	8b 45 f4             	mov    -0xc(%ebp),%eax
 813:	8b 55 ec             	mov    -0x14(%ebp),%edx
 816:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 819:	8b 45 f0             	mov    -0x10(%ebp),%eax
 81c:	a3 5c 0b 00 00       	mov    %eax,0xb5c
      return (void*)(p + 1);
 821:	8b 45 f4             	mov    -0xc(%ebp),%eax
 824:	83 c0 08             	add    $0x8,%eax
 827:	eb 38                	jmp    861 <malloc+0xde>
    }
    if(p == freep)
 829:	a1 5c 0b 00 00       	mov    0xb5c,%eax
 82e:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 831:	75 1b                	jne    84e <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 833:	8b 45 ec             	mov    -0x14(%ebp),%eax
 836:	89 04 24             	mov    %eax,(%esp)
 839:	e8 ed fe ff ff       	call   72b <morecore>
 83e:	89 45 f4             	mov    %eax,-0xc(%ebp)
 841:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 845:	75 07                	jne    84e <malloc+0xcb>
        return 0;
 847:	b8 00 00 00 00       	mov    $0x0,%eax
 84c:	eb 13                	jmp    861 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 84e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 851:	89 45 f0             	mov    %eax,-0x10(%ebp)
 854:	8b 45 f4             	mov    -0xc(%ebp),%eax
 857:	8b 00                	mov    (%eax),%eax
 859:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 85c:	e9 70 ff ff ff       	jmp    7d1 <malloc+0x4e>
}
 861:	c9                   	leave  
 862:	c3                   	ret    
