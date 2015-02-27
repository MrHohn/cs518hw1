
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
    __asm__ ("movl $0x63,4(%ebp)\n\t");
   3:	c7 45 04 63 00 00 00 	movl   $0x63,0x4(%ebp)

   a:	5d                   	pop    %ebp
   b:	c3                   	ret    

0000000c <main>:
#include "restorer.h"

void handle_signal(int);

int main(void)
{
   c:	55                   	push   %ebp
   d:	89 e5                	mov    %esp,%ebp
   f:	83 e4 f0             	and    $0xfffffff0,%esp
  12:	83 ec 20             	sub    $0x20,%esp
    register int ecx asm ("%ecx");
    // restorer();
    signal(-1, (sighandler_t*) restorer);   // save the address of restorer function inside the kernel.
  15:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  1c:	00 
  1d:	c7 04 24 ff ff ff ff 	movl   $0xffffffff,(%esp)
  24:	e8 93 03 00 00       	call   3bc <signal>
    signal(SIGFPE, handle_signal);         // register the actual signal for divide by zero.
  29:	c7 44 24 04 a5 00 00 	movl   $0xa5,0x4(%esp)
  30:	00 
  31:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  38:	e8 7f 03 00 00       	call   3bc <signal>

    int x = 5;
  3d:	c7 44 24 1c 05 00 00 	movl   $0x5,0x1c(%esp)
  44:	00 
    int y = 0;
  45:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
  4c:	00 

    ecx = 5;
  4d:	b9 05 00 00 00       	mov    $0x5,%ecx
    x = x / y;
  52:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  56:	89 c2                	mov    %eax,%edx
  58:	c1 fa 1f             	sar    $0x1f,%edx
  5b:	f7 7c 24 18          	idivl  0x18(%esp)
  5f:	89 44 24 1c          	mov    %eax,0x1c(%esp)

    if (ecx == 5)
  63:	89 c8                	mov    %ecx,%eax
  65:	83 f8 05             	cmp    $0x5,%eax
  68:	75 1c                	jne    86 <main+0x7a>
        printf(1, "TEST PASSED: Final value of ecx is %d...\n", ecx);
  6a:	89 c8                	mov    %ecx,%eax
  6c:	89 44 24 08          	mov    %eax,0x8(%esp)
  70:	c7 44 24 04 60 08 00 	movl   $0x860,0x4(%esp)
  77:	00 
  78:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  7f:	e8 17 04 00 00       	call   49b <printf>
  84:	eb 1a                	jmp    a0 <main+0x94>
    else
        printf(1, "TEST FAILED: Final value of ecx is %d...\n", ecx);
  86:	89 c8                	mov    %ecx,%eax
  88:	89 44 24 08          	mov    %eax,0x8(%esp)
  8c:	c7 44 24 04 8c 08 00 	movl   $0x88c,0x4(%esp)
  93:	00 
  94:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  9b:	e8 fb 03 00 00       	call   49b <printf>

    exit();
  a0:	e8 6f 02 00 00       	call   314 <exit>

000000a5 <handle_signal>:
}

void handle_signal(int signum)
{
  a5:	55                   	push   %ebp
  a6:	89 e5                	mov    %esp,%ebp
    // printf(1, "in handler\n");
    // exit();

    __asm__ ("movl $0x0,%ecx\n\t");
  a8:	b9 00 00 00 00       	mov    $0x0,%ecx
	// Add your code to skip the return ip here
    // __asm__ ("movl $0x0,4(%ebp)\n\t");
  ad:	5d                   	pop    %ebp
  ae:	c3                   	ret    
  af:	90                   	nop

000000b0 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  b0:	55                   	push   %ebp
  b1:	89 e5                	mov    %esp,%ebp
  b3:	57                   	push   %edi
  b4:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  b5:	8b 4d 08             	mov    0x8(%ebp),%ecx
  b8:	8b 55 10             	mov    0x10(%ebp),%edx
  bb:	8b 45 0c             	mov    0xc(%ebp),%eax
  be:	89 cb                	mov    %ecx,%ebx
  c0:	89 df                	mov    %ebx,%edi
  c2:	89 d1                	mov    %edx,%ecx
  c4:	fc                   	cld    
  c5:	f3 aa                	rep stos %al,%es:(%edi)
  c7:	89 ca                	mov    %ecx,%edx
  c9:	89 fb                	mov    %edi,%ebx
  cb:	89 5d 08             	mov    %ebx,0x8(%ebp)
  ce:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  d1:	5b                   	pop    %ebx
  d2:	5f                   	pop    %edi
  d3:	5d                   	pop    %ebp
  d4:	c3                   	ret    

000000d5 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  d5:	55                   	push   %ebp
  d6:	89 e5                	mov    %esp,%ebp
  d8:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  db:	8b 45 08             	mov    0x8(%ebp),%eax
  de:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  e1:	90                   	nop
  e2:	8b 45 0c             	mov    0xc(%ebp),%eax
  e5:	0f b6 10             	movzbl (%eax),%edx
  e8:	8b 45 08             	mov    0x8(%ebp),%eax
  eb:	88 10                	mov    %dl,(%eax)
  ed:	8b 45 08             	mov    0x8(%ebp),%eax
  f0:	0f b6 00             	movzbl (%eax),%eax
  f3:	84 c0                	test   %al,%al
  f5:	0f 95 c0             	setne  %al
  f8:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  fc:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
 100:	84 c0                	test   %al,%al
 102:	75 de                	jne    e2 <strcpy+0xd>
    ;
  return os;
 104:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 107:	c9                   	leave  
 108:	c3                   	ret    

00000109 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 109:	55                   	push   %ebp
 10a:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 10c:	eb 08                	jmp    116 <strcmp+0xd>
    p++, q++;
 10e:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 112:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 116:	8b 45 08             	mov    0x8(%ebp),%eax
 119:	0f b6 00             	movzbl (%eax),%eax
 11c:	84 c0                	test   %al,%al
 11e:	74 10                	je     130 <strcmp+0x27>
 120:	8b 45 08             	mov    0x8(%ebp),%eax
 123:	0f b6 10             	movzbl (%eax),%edx
 126:	8b 45 0c             	mov    0xc(%ebp),%eax
 129:	0f b6 00             	movzbl (%eax),%eax
 12c:	38 c2                	cmp    %al,%dl
 12e:	74 de                	je     10e <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 130:	8b 45 08             	mov    0x8(%ebp),%eax
 133:	0f b6 00             	movzbl (%eax),%eax
 136:	0f b6 d0             	movzbl %al,%edx
 139:	8b 45 0c             	mov    0xc(%ebp),%eax
 13c:	0f b6 00             	movzbl (%eax),%eax
 13f:	0f b6 c0             	movzbl %al,%eax
 142:	89 d1                	mov    %edx,%ecx
 144:	29 c1                	sub    %eax,%ecx
 146:	89 c8                	mov    %ecx,%eax
}
 148:	5d                   	pop    %ebp
 149:	c3                   	ret    

0000014a <strlen>:

uint
strlen(char *s)
{
 14a:	55                   	push   %ebp
 14b:	89 e5                	mov    %esp,%ebp
 14d:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 150:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 157:	eb 04                	jmp    15d <strlen+0x13>
 159:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 15d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 160:	03 45 08             	add    0x8(%ebp),%eax
 163:	0f b6 00             	movzbl (%eax),%eax
 166:	84 c0                	test   %al,%al
 168:	75 ef                	jne    159 <strlen+0xf>
    ;
  return n;
 16a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 16d:	c9                   	leave  
 16e:	c3                   	ret    

0000016f <memset>:

void*
memset(void *dst, int c, uint n)
{
 16f:	55                   	push   %ebp
 170:	89 e5                	mov    %esp,%ebp
 172:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
 175:	8b 45 10             	mov    0x10(%ebp),%eax
 178:	89 44 24 08          	mov    %eax,0x8(%esp)
 17c:	8b 45 0c             	mov    0xc(%ebp),%eax
 17f:	89 44 24 04          	mov    %eax,0x4(%esp)
 183:	8b 45 08             	mov    0x8(%ebp),%eax
 186:	89 04 24             	mov    %eax,(%esp)
 189:	e8 22 ff ff ff       	call   b0 <stosb>
  return dst;
 18e:	8b 45 08             	mov    0x8(%ebp),%eax
}
 191:	c9                   	leave  
 192:	c3                   	ret    

00000193 <strchr>:

char*
strchr(const char *s, char c)
{
 193:	55                   	push   %ebp
 194:	89 e5                	mov    %esp,%ebp
 196:	83 ec 04             	sub    $0x4,%esp
 199:	8b 45 0c             	mov    0xc(%ebp),%eax
 19c:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 19f:	eb 14                	jmp    1b5 <strchr+0x22>
    if(*s == c)
 1a1:	8b 45 08             	mov    0x8(%ebp),%eax
 1a4:	0f b6 00             	movzbl (%eax),%eax
 1a7:	3a 45 fc             	cmp    -0x4(%ebp),%al
 1aa:	75 05                	jne    1b1 <strchr+0x1e>
      return (char*)s;
 1ac:	8b 45 08             	mov    0x8(%ebp),%eax
 1af:	eb 13                	jmp    1c4 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 1b1:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 1b5:	8b 45 08             	mov    0x8(%ebp),%eax
 1b8:	0f b6 00             	movzbl (%eax),%eax
 1bb:	84 c0                	test   %al,%al
 1bd:	75 e2                	jne    1a1 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 1bf:	b8 00 00 00 00       	mov    $0x0,%eax
}
 1c4:	c9                   	leave  
 1c5:	c3                   	ret    

000001c6 <gets>:

char*
gets(char *buf, int max)
{
 1c6:	55                   	push   %ebp
 1c7:	89 e5                	mov    %esp,%ebp
 1c9:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1cc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 1d3:	eb 44                	jmp    219 <gets+0x53>
    cc = read(0, &c, 1);
 1d5:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 1dc:	00 
 1dd:	8d 45 ef             	lea    -0x11(%ebp),%eax
 1e0:	89 44 24 04          	mov    %eax,0x4(%esp)
 1e4:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 1eb:	e8 3c 01 00 00       	call   32c <read>
 1f0:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 1f3:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 1f7:	7e 2d                	jle    226 <gets+0x60>
      break;
    buf[i++] = c;
 1f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1fc:	03 45 08             	add    0x8(%ebp),%eax
 1ff:	0f b6 55 ef          	movzbl -0x11(%ebp),%edx
 203:	88 10                	mov    %dl,(%eax)
 205:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(c == '\n' || c == '\r')
 209:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 20d:	3c 0a                	cmp    $0xa,%al
 20f:	74 16                	je     227 <gets+0x61>
 211:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 215:	3c 0d                	cmp    $0xd,%al
 217:	74 0e                	je     227 <gets+0x61>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 219:	8b 45 f4             	mov    -0xc(%ebp),%eax
 21c:	83 c0 01             	add    $0x1,%eax
 21f:	3b 45 0c             	cmp    0xc(%ebp),%eax
 222:	7c b1                	jl     1d5 <gets+0xf>
 224:	eb 01                	jmp    227 <gets+0x61>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 226:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 227:	8b 45 f4             	mov    -0xc(%ebp),%eax
 22a:	03 45 08             	add    0x8(%ebp),%eax
 22d:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 230:	8b 45 08             	mov    0x8(%ebp),%eax
}
 233:	c9                   	leave  
 234:	c3                   	ret    

00000235 <stat>:

int
stat(char *n, struct stat *st)
{
 235:	55                   	push   %ebp
 236:	89 e5                	mov    %esp,%ebp
 238:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 23b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 242:	00 
 243:	8b 45 08             	mov    0x8(%ebp),%eax
 246:	89 04 24             	mov    %eax,(%esp)
 249:	e8 06 01 00 00       	call   354 <open>
 24e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 251:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 255:	79 07                	jns    25e <stat+0x29>
    return -1;
 257:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 25c:	eb 23                	jmp    281 <stat+0x4c>
  r = fstat(fd, st);
 25e:	8b 45 0c             	mov    0xc(%ebp),%eax
 261:	89 44 24 04          	mov    %eax,0x4(%esp)
 265:	8b 45 f4             	mov    -0xc(%ebp),%eax
 268:	89 04 24             	mov    %eax,(%esp)
 26b:	e8 fc 00 00 00       	call   36c <fstat>
 270:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 273:	8b 45 f4             	mov    -0xc(%ebp),%eax
 276:	89 04 24             	mov    %eax,(%esp)
 279:	e8 be 00 00 00       	call   33c <close>
  return r;
 27e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 281:	c9                   	leave  
 282:	c3                   	ret    

00000283 <atoi>:

int
atoi(const char *s)
{
 283:	55                   	push   %ebp
 284:	89 e5                	mov    %esp,%ebp
 286:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 289:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 290:	eb 23                	jmp    2b5 <atoi+0x32>
    n = n*10 + *s++ - '0';
 292:	8b 55 fc             	mov    -0x4(%ebp),%edx
 295:	89 d0                	mov    %edx,%eax
 297:	c1 e0 02             	shl    $0x2,%eax
 29a:	01 d0                	add    %edx,%eax
 29c:	01 c0                	add    %eax,%eax
 29e:	89 c2                	mov    %eax,%edx
 2a0:	8b 45 08             	mov    0x8(%ebp),%eax
 2a3:	0f b6 00             	movzbl (%eax),%eax
 2a6:	0f be c0             	movsbl %al,%eax
 2a9:	01 d0                	add    %edx,%eax
 2ab:	83 e8 30             	sub    $0x30,%eax
 2ae:	89 45 fc             	mov    %eax,-0x4(%ebp)
 2b1:	83 45 08 01          	addl   $0x1,0x8(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2b5:	8b 45 08             	mov    0x8(%ebp),%eax
 2b8:	0f b6 00             	movzbl (%eax),%eax
 2bb:	3c 2f                	cmp    $0x2f,%al
 2bd:	7e 0a                	jle    2c9 <atoi+0x46>
 2bf:	8b 45 08             	mov    0x8(%ebp),%eax
 2c2:	0f b6 00             	movzbl (%eax),%eax
 2c5:	3c 39                	cmp    $0x39,%al
 2c7:	7e c9                	jle    292 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 2c9:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 2cc:	c9                   	leave  
 2cd:	c3                   	ret    

000002ce <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 2ce:	55                   	push   %ebp
 2cf:	89 e5                	mov    %esp,%ebp
 2d1:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 2d4:	8b 45 08             	mov    0x8(%ebp),%eax
 2d7:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 2da:	8b 45 0c             	mov    0xc(%ebp),%eax
 2dd:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 2e0:	eb 13                	jmp    2f5 <memmove+0x27>
    *dst++ = *src++;
 2e2:	8b 45 f8             	mov    -0x8(%ebp),%eax
 2e5:	0f b6 10             	movzbl (%eax),%edx
 2e8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 2eb:	88 10                	mov    %dl,(%eax)
 2ed:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 2f1:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2f5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
 2f9:	0f 9f c0             	setg   %al
 2fc:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
 300:	84 c0                	test   %al,%al
 302:	75 de                	jne    2e2 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 304:	8b 45 08             	mov    0x8(%ebp),%eax
}
 307:	c9                   	leave  
 308:	c3                   	ret    
 309:	90                   	nop
 30a:	90                   	nop
 30b:	90                   	nop

0000030c <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 30c:	b8 01 00 00 00       	mov    $0x1,%eax
 311:	cd 40                	int    $0x40
 313:	c3                   	ret    

00000314 <exit>:
SYSCALL(exit)
 314:	b8 02 00 00 00       	mov    $0x2,%eax
 319:	cd 40                	int    $0x40
 31b:	c3                   	ret    

0000031c <wait>:
SYSCALL(wait)
 31c:	b8 03 00 00 00       	mov    $0x3,%eax
 321:	cd 40                	int    $0x40
 323:	c3                   	ret    

00000324 <pipe>:
SYSCALL(pipe)
 324:	b8 04 00 00 00       	mov    $0x4,%eax
 329:	cd 40                	int    $0x40
 32b:	c3                   	ret    

0000032c <read>:
SYSCALL(read)
 32c:	b8 05 00 00 00       	mov    $0x5,%eax
 331:	cd 40                	int    $0x40
 333:	c3                   	ret    

00000334 <write>:
SYSCALL(write)
 334:	b8 10 00 00 00       	mov    $0x10,%eax
 339:	cd 40                	int    $0x40
 33b:	c3                   	ret    

0000033c <close>:
SYSCALL(close)
 33c:	b8 15 00 00 00       	mov    $0x15,%eax
 341:	cd 40                	int    $0x40
 343:	c3                   	ret    

00000344 <kill>:
SYSCALL(kill)
 344:	b8 06 00 00 00       	mov    $0x6,%eax
 349:	cd 40                	int    $0x40
 34b:	c3                   	ret    

0000034c <exec>:
SYSCALL(exec)
 34c:	b8 07 00 00 00       	mov    $0x7,%eax
 351:	cd 40                	int    $0x40
 353:	c3                   	ret    

00000354 <open>:
SYSCALL(open)
 354:	b8 0f 00 00 00       	mov    $0xf,%eax
 359:	cd 40                	int    $0x40
 35b:	c3                   	ret    

0000035c <mknod>:
SYSCALL(mknod)
 35c:	b8 11 00 00 00       	mov    $0x11,%eax
 361:	cd 40                	int    $0x40
 363:	c3                   	ret    

00000364 <unlink>:
SYSCALL(unlink)
 364:	b8 12 00 00 00       	mov    $0x12,%eax
 369:	cd 40                	int    $0x40
 36b:	c3                   	ret    

0000036c <fstat>:
SYSCALL(fstat)
 36c:	b8 08 00 00 00       	mov    $0x8,%eax
 371:	cd 40                	int    $0x40
 373:	c3                   	ret    

00000374 <link>:
SYSCALL(link)
 374:	b8 13 00 00 00       	mov    $0x13,%eax
 379:	cd 40                	int    $0x40
 37b:	c3                   	ret    

0000037c <mkdir>:
SYSCALL(mkdir)
 37c:	b8 14 00 00 00       	mov    $0x14,%eax
 381:	cd 40                	int    $0x40
 383:	c3                   	ret    

00000384 <chdir>:
SYSCALL(chdir)
 384:	b8 09 00 00 00       	mov    $0x9,%eax
 389:	cd 40                	int    $0x40
 38b:	c3                   	ret    

0000038c <dup>:
SYSCALL(dup)
 38c:	b8 0a 00 00 00       	mov    $0xa,%eax
 391:	cd 40                	int    $0x40
 393:	c3                   	ret    

00000394 <getpid>:
SYSCALL(getpid)
 394:	b8 0b 00 00 00       	mov    $0xb,%eax
 399:	cd 40                	int    $0x40
 39b:	c3                   	ret    

0000039c <sbrk>:
SYSCALL(sbrk)
 39c:	b8 0c 00 00 00       	mov    $0xc,%eax
 3a1:	cd 40                	int    $0x40
 3a3:	c3                   	ret    

000003a4 <sleep>:
SYSCALL(sleep)
 3a4:	b8 0d 00 00 00       	mov    $0xd,%eax
 3a9:	cd 40                	int    $0x40
 3ab:	c3                   	ret    

000003ac <uptime>:
SYSCALL(uptime)
 3ac:	b8 0e 00 00 00       	mov    $0xe,%eax
 3b1:	cd 40                	int    $0x40
 3b3:	c3                   	ret    

000003b4 <halt>:
SYSCALL(halt)
 3b4:	b8 16 00 00 00       	mov    $0x16,%eax
 3b9:	cd 40                	int    $0x40
 3bb:	c3                   	ret    

000003bc <signal>:
 3bc:	b8 17 00 00 00       	mov    $0x17,%eax
 3c1:	cd 40                	int    $0x40
 3c3:	c3                   	ret    

000003c4 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 3c4:	55                   	push   %ebp
 3c5:	89 e5                	mov    %esp,%ebp
 3c7:	83 ec 28             	sub    $0x28,%esp
 3ca:	8b 45 0c             	mov    0xc(%ebp),%eax
 3cd:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 3d0:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 3d7:	00 
 3d8:	8d 45 f4             	lea    -0xc(%ebp),%eax
 3db:	89 44 24 04          	mov    %eax,0x4(%esp)
 3df:	8b 45 08             	mov    0x8(%ebp),%eax
 3e2:	89 04 24             	mov    %eax,(%esp)
 3e5:	e8 4a ff ff ff       	call   334 <write>
}
 3ea:	c9                   	leave  
 3eb:	c3                   	ret    

000003ec <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 3ec:	55                   	push   %ebp
 3ed:	89 e5                	mov    %esp,%ebp
 3ef:	83 ec 48             	sub    $0x48,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 3f2:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 3f9:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 3fd:	74 17                	je     416 <printint+0x2a>
 3ff:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 403:	79 11                	jns    416 <printint+0x2a>
    neg = 1;
 405:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 40c:	8b 45 0c             	mov    0xc(%ebp),%eax
 40f:	f7 d8                	neg    %eax
 411:	89 45 ec             	mov    %eax,-0x14(%ebp)
 414:	eb 06                	jmp    41c <printint+0x30>
  } else {
    x = xx;
 416:	8b 45 0c             	mov    0xc(%ebp),%eax
 419:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 41c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 423:	8b 4d 10             	mov    0x10(%ebp),%ecx
 426:	8b 45 ec             	mov    -0x14(%ebp),%eax
 429:	ba 00 00 00 00       	mov    $0x0,%edx
 42e:	f7 f1                	div    %ecx
 430:	89 d0                	mov    %edx,%eax
 432:	0f b6 90 3c 0b 00 00 	movzbl 0xb3c(%eax),%edx
 439:	8d 45 dc             	lea    -0x24(%ebp),%eax
 43c:	03 45 f4             	add    -0xc(%ebp),%eax
 43f:	88 10                	mov    %dl,(%eax)
 441:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  }while((x /= base) != 0);
 445:	8b 55 10             	mov    0x10(%ebp),%edx
 448:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 44b:	8b 45 ec             	mov    -0x14(%ebp),%eax
 44e:	ba 00 00 00 00       	mov    $0x0,%edx
 453:	f7 75 d4             	divl   -0x2c(%ebp)
 456:	89 45 ec             	mov    %eax,-0x14(%ebp)
 459:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 45d:	75 c4                	jne    423 <printint+0x37>
  if(neg)
 45f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 463:	74 2a                	je     48f <printint+0xa3>
    buf[i++] = '-';
 465:	8d 45 dc             	lea    -0x24(%ebp),%eax
 468:	03 45 f4             	add    -0xc(%ebp),%eax
 46b:	c6 00 2d             	movb   $0x2d,(%eax)
 46e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)

  while(--i >= 0)
 472:	eb 1b                	jmp    48f <printint+0xa3>
    putc(fd, buf[i]);
 474:	8d 45 dc             	lea    -0x24(%ebp),%eax
 477:	03 45 f4             	add    -0xc(%ebp),%eax
 47a:	0f b6 00             	movzbl (%eax),%eax
 47d:	0f be c0             	movsbl %al,%eax
 480:	89 44 24 04          	mov    %eax,0x4(%esp)
 484:	8b 45 08             	mov    0x8(%ebp),%eax
 487:	89 04 24             	mov    %eax,(%esp)
 48a:	e8 35 ff ff ff       	call   3c4 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 48f:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 493:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 497:	79 db                	jns    474 <printint+0x88>
    putc(fd, buf[i]);
}
 499:	c9                   	leave  
 49a:	c3                   	ret    

0000049b <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 49b:	55                   	push   %ebp
 49c:	89 e5                	mov    %esp,%ebp
 49e:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 4a1:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 4a8:	8d 45 0c             	lea    0xc(%ebp),%eax
 4ab:	83 c0 04             	add    $0x4,%eax
 4ae:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 4b1:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 4b8:	e9 7d 01 00 00       	jmp    63a <printf+0x19f>
    c = fmt[i] & 0xff;
 4bd:	8b 55 0c             	mov    0xc(%ebp),%edx
 4c0:	8b 45 f0             	mov    -0x10(%ebp),%eax
 4c3:	01 d0                	add    %edx,%eax
 4c5:	0f b6 00             	movzbl (%eax),%eax
 4c8:	0f be c0             	movsbl %al,%eax
 4cb:	25 ff 00 00 00       	and    $0xff,%eax
 4d0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 4d3:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 4d7:	75 2c                	jne    505 <printf+0x6a>
      if(c == '%'){
 4d9:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 4dd:	75 0c                	jne    4eb <printf+0x50>
        state = '%';
 4df:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 4e6:	e9 4b 01 00 00       	jmp    636 <printf+0x19b>
      } else {
        putc(fd, c);
 4eb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 4ee:	0f be c0             	movsbl %al,%eax
 4f1:	89 44 24 04          	mov    %eax,0x4(%esp)
 4f5:	8b 45 08             	mov    0x8(%ebp),%eax
 4f8:	89 04 24             	mov    %eax,(%esp)
 4fb:	e8 c4 fe ff ff       	call   3c4 <putc>
 500:	e9 31 01 00 00       	jmp    636 <printf+0x19b>
      }
    } else if(state == '%'){
 505:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 509:	0f 85 27 01 00 00    	jne    636 <printf+0x19b>
      if(c == 'd'){
 50f:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 513:	75 2d                	jne    542 <printf+0xa7>
        printint(fd, *ap, 10, 1);
 515:	8b 45 e8             	mov    -0x18(%ebp),%eax
 518:	8b 00                	mov    (%eax),%eax
 51a:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 521:	00 
 522:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 529:	00 
 52a:	89 44 24 04          	mov    %eax,0x4(%esp)
 52e:	8b 45 08             	mov    0x8(%ebp),%eax
 531:	89 04 24             	mov    %eax,(%esp)
 534:	e8 b3 fe ff ff       	call   3ec <printint>
        ap++;
 539:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 53d:	e9 ed 00 00 00       	jmp    62f <printf+0x194>
      } else if(c == 'x' || c == 'p'){
 542:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 546:	74 06                	je     54e <printf+0xb3>
 548:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 54c:	75 2d                	jne    57b <printf+0xe0>
        printint(fd, *ap, 16, 0);
 54e:	8b 45 e8             	mov    -0x18(%ebp),%eax
 551:	8b 00                	mov    (%eax),%eax
 553:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 55a:	00 
 55b:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 562:	00 
 563:	89 44 24 04          	mov    %eax,0x4(%esp)
 567:	8b 45 08             	mov    0x8(%ebp),%eax
 56a:	89 04 24             	mov    %eax,(%esp)
 56d:	e8 7a fe ff ff       	call   3ec <printint>
        ap++;
 572:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 576:	e9 b4 00 00 00       	jmp    62f <printf+0x194>
      } else if(c == 's'){
 57b:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 57f:	75 46                	jne    5c7 <printf+0x12c>
        s = (char*)*ap;
 581:	8b 45 e8             	mov    -0x18(%ebp),%eax
 584:	8b 00                	mov    (%eax),%eax
 586:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 589:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 58d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 591:	75 27                	jne    5ba <printf+0x11f>
          s = "(null)";
 593:	c7 45 f4 b6 08 00 00 	movl   $0x8b6,-0xc(%ebp)
        while(*s != 0){
 59a:	eb 1e                	jmp    5ba <printf+0x11f>
          putc(fd, *s);
 59c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 59f:	0f b6 00             	movzbl (%eax),%eax
 5a2:	0f be c0             	movsbl %al,%eax
 5a5:	89 44 24 04          	mov    %eax,0x4(%esp)
 5a9:	8b 45 08             	mov    0x8(%ebp),%eax
 5ac:	89 04 24             	mov    %eax,(%esp)
 5af:	e8 10 fe ff ff       	call   3c4 <putc>
          s++;
 5b4:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 5b8:	eb 01                	jmp    5bb <printf+0x120>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 5ba:	90                   	nop
 5bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5be:	0f b6 00             	movzbl (%eax),%eax
 5c1:	84 c0                	test   %al,%al
 5c3:	75 d7                	jne    59c <printf+0x101>
 5c5:	eb 68                	jmp    62f <printf+0x194>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5c7:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 5cb:	75 1d                	jne    5ea <printf+0x14f>
        putc(fd, *ap);
 5cd:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5d0:	8b 00                	mov    (%eax),%eax
 5d2:	0f be c0             	movsbl %al,%eax
 5d5:	89 44 24 04          	mov    %eax,0x4(%esp)
 5d9:	8b 45 08             	mov    0x8(%ebp),%eax
 5dc:	89 04 24             	mov    %eax,(%esp)
 5df:	e8 e0 fd ff ff       	call   3c4 <putc>
        ap++;
 5e4:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5e8:	eb 45                	jmp    62f <printf+0x194>
      } else if(c == '%'){
 5ea:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 5ee:	75 17                	jne    607 <printf+0x16c>
        putc(fd, c);
 5f0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5f3:	0f be c0             	movsbl %al,%eax
 5f6:	89 44 24 04          	mov    %eax,0x4(%esp)
 5fa:	8b 45 08             	mov    0x8(%ebp),%eax
 5fd:	89 04 24             	mov    %eax,(%esp)
 600:	e8 bf fd ff ff       	call   3c4 <putc>
 605:	eb 28                	jmp    62f <printf+0x194>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 607:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 60e:	00 
 60f:	8b 45 08             	mov    0x8(%ebp),%eax
 612:	89 04 24             	mov    %eax,(%esp)
 615:	e8 aa fd ff ff       	call   3c4 <putc>
        putc(fd, c);
 61a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 61d:	0f be c0             	movsbl %al,%eax
 620:	89 44 24 04          	mov    %eax,0x4(%esp)
 624:	8b 45 08             	mov    0x8(%ebp),%eax
 627:	89 04 24             	mov    %eax,(%esp)
 62a:	e8 95 fd ff ff       	call   3c4 <putc>
      }
      state = 0;
 62f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 636:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 63a:	8b 55 0c             	mov    0xc(%ebp),%edx
 63d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 640:	01 d0                	add    %edx,%eax
 642:	0f b6 00             	movzbl (%eax),%eax
 645:	84 c0                	test   %al,%al
 647:	0f 85 70 fe ff ff    	jne    4bd <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 64d:	c9                   	leave  
 64e:	c3                   	ret    
 64f:	90                   	nop

00000650 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 650:	55                   	push   %ebp
 651:	89 e5                	mov    %esp,%ebp
 653:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 656:	8b 45 08             	mov    0x8(%ebp),%eax
 659:	83 e8 08             	sub    $0x8,%eax
 65c:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 65f:	a1 58 0b 00 00       	mov    0xb58,%eax
 664:	89 45 fc             	mov    %eax,-0x4(%ebp)
 667:	eb 24                	jmp    68d <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 669:	8b 45 fc             	mov    -0x4(%ebp),%eax
 66c:	8b 00                	mov    (%eax),%eax
 66e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 671:	77 12                	ja     685 <free+0x35>
 673:	8b 45 f8             	mov    -0x8(%ebp),%eax
 676:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 679:	77 24                	ja     69f <free+0x4f>
 67b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 67e:	8b 00                	mov    (%eax),%eax
 680:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 683:	77 1a                	ja     69f <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 685:	8b 45 fc             	mov    -0x4(%ebp),%eax
 688:	8b 00                	mov    (%eax),%eax
 68a:	89 45 fc             	mov    %eax,-0x4(%ebp)
 68d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 690:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 693:	76 d4                	jbe    669 <free+0x19>
 695:	8b 45 fc             	mov    -0x4(%ebp),%eax
 698:	8b 00                	mov    (%eax),%eax
 69a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 69d:	76 ca                	jbe    669 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 69f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6a2:	8b 40 04             	mov    0x4(%eax),%eax
 6a5:	c1 e0 03             	shl    $0x3,%eax
 6a8:	89 c2                	mov    %eax,%edx
 6aa:	03 55 f8             	add    -0x8(%ebp),%edx
 6ad:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6b0:	8b 00                	mov    (%eax),%eax
 6b2:	39 c2                	cmp    %eax,%edx
 6b4:	75 24                	jne    6da <free+0x8a>
    bp->s.size += p->s.ptr->s.size;
 6b6:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6b9:	8b 50 04             	mov    0x4(%eax),%edx
 6bc:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6bf:	8b 00                	mov    (%eax),%eax
 6c1:	8b 40 04             	mov    0x4(%eax),%eax
 6c4:	01 c2                	add    %eax,%edx
 6c6:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6c9:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 6cc:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6cf:	8b 00                	mov    (%eax),%eax
 6d1:	8b 10                	mov    (%eax),%edx
 6d3:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6d6:	89 10                	mov    %edx,(%eax)
 6d8:	eb 0a                	jmp    6e4 <free+0x94>
  } else
    bp->s.ptr = p->s.ptr;
 6da:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6dd:	8b 10                	mov    (%eax),%edx
 6df:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6e2:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 6e4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6e7:	8b 40 04             	mov    0x4(%eax),%eax
 6ea:	c1 e0 03             	shl    $0x3,%eax
 6ed:	03 45 fc             	add    -0x4(%ebp),%eax
 6f0:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6f3:	75 20                	jne    715 <free+0xc5>
    p->s.size += bp->s.size;
 6f5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6f8:	8b 50 04             	mov    0x4(%eax),%edx
 6fb:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6fe:	8b 40 04             	mov    0x4(%eax),%eax
 701:	01 c2                	add    %eax,%edx
 703:	8b 45 fc             	mov    -0x4(%ebp),%eax
 706:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 709:	8b 45 f8             	mov    -0x8(%ebp),%eax
 70c:	8b 10                	mov    (%eax),%edx
 70e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 711:	89 10                	mov    %edx,(%eax)
 713:	eb 08                	jmp    71d <free+0xcd>
  } else
    p->s.ptr = bp;
 715:	8b 45 fc             	mov    -0x4(%ebp),%eax
 718:	8b 55 f8             	mov    -0x8(%ebp),%edx
 71b:	89 10                	mov    %edx,(%eax)
  freep = p;
 71d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 720:	a3 58 0b 00 00       	mov    %eax,0xb58
}
 725:	c9                   	leave  
 726:	c3                   	ret    

00000727 <morecore>:

static Header*
morecore(uint nu)
{
 727:	55                   	push   %ebp
 728:	89 e5                	mov    %esp,%ebp
 72a:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 72d:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 734:	77 07                	ja     73d <morecore+0x16>
    nu = 4096;
 736:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 73d:	8b 45 08             	mov    0x8(%ebp),%eax
 740:	c1 e0 03             	shl    $0x3,%eax
 743:	89 04 24             	mov    %eax,(%esp)
 746:	e8 51 fc ff ff       	call   39c <sbrk>
 74b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 74e:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 752:	75 07                	jne    75b <morecore+0x34>
    return 0;
 754:	b8 00 00 00 00       	mov    $0x0,%eax
 759:	eb 22                	jmp    77d <morecore+0x56>
  hp = (Header*)p;
 75b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 75e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 761:	8b 45 f0             	mov    -0x10(%ebp),%eax
 764:	8b 55 08             	mov    0x8(%ebp),%edx
 767:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 76a:	8b 45 f0             	mov    -0x10(%ebp),%eax
 76d:	83 c0 08             	add    $0x8,%eax
 770:	89 04 24             	mov    %eax,(%esp)
 773:	e8 d8 fe ff ff       	call   650 <free>
  return freep;
 778:	a1 58 0b 00 00       	mov    0xb58,%eax
}
 77d:	c9                   	leave  
 77e:	c3                   	ret    

0000077f <malloc>:

void*
malloc(uint nbytes)
{
 77f:	55                   	push   %ebp
 780:	89 e5                	mov    %esp,%ebp
 782:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 785:	8b 45 08             	mov    0x8(%ebp),%eax
 788:	83 c0 07             	add    $0x7,%eax
 78b:	c1 e8 03             	shr    $0x3,%eax
 78e:	83 c0 01             	add    $0x1,%eax
 791:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 794:	a1 58 0b 00 00       	mov    0xb58,%eax
 799:	89 45 f0             	mov    %eax,-0x10(%ebp)
 79c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 7a0:	75 23                	jne    7c5 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 7a2:	c7 45 f0 50 0b 00 00 	movl   $0xb50,-0x10(%ebp)
 7a9:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7ac:	a3 58 0b 00 00       	mov    %eax,0xb58
 7b1:	a1 58 0b 00 00       	mov    0xb58,%eax
 7b6:	a3 50 0b 00 00       	mov    %eax,0xb50
    base.s.size = 0;
 7bb:	c7 05 54 0b 00 00 00 	movl   $0x0,0xb54
 7c2:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7c5:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7c8:	8b 00                	mov    (%eax),%eax
 7ca:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 7cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7d0:	8b 40 04             	mov    0x4(%eax),%eax
 7d3:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 7d6:	72 4d                	jb     825 <malloc+0xa6>
      if(p->s.size == nunits)
 7d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7db:	8b 40 04             	mov    0x4(%eax),%eax
 7de:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 7e1:	75 0c                	jne    7ef <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 7e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7e6:	8b 10                	mov    (%eax),%edx
 7e8:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7eb:	89 10                	mov    %edx,(%eax)
 7ed:	eb 26                	jmp    815 <malloc+0x96>
      else {
        p->s.size -= nunits;
 7ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7f2:	8b 40 04             	mov    0x4(%eax),%eax
 7f5:	89 c2                	mov    %eax,%edx
 7f7:	2b 55 ec             	sub    -0x14(%ebp),%edx
 7fa:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7fd:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 800:	8b 45 f4             	mov    -0xc(%ebp),%eax
 803:	8b 40 04             	mov    0x4(%eax),%eax
 806:	c1 e0 03             	shl    $0x3,%eax
 809:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 80c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 80f:	8b 55 ec             	mov    -0x14(%ebp),%edx
 812:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 815:	8b 45 f0             	mov    -0x10(%ebp),%eax
 818:	a3 58 0b 00 00       	mov    %eax,0xb58
      return (void*)(p + 1);
 81d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 820:	83 c0 08             	add    $0x8,%eax
 823:	eb 38                	jmp    85d <malloc+0xde>
    }
    if(p == freep)
 825:	a1 58 0b 00 00       	mov    0xb58,%eax
 82a:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 82d:	75 1b                	jne    84a <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 82f:	8b 45 ec             	mov    -0x14(%ebp),%eax
 832:	89 04 24             	mov    %eax,(%esp)
 835:	e8 ed fe ff ff       	call   727 <morecore>
 83a:	89 45 f4             	mov    %eax,-0xc(%ebp)
 83d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 841:	75 07                	jne    84a <malloc+0xcb>
        return 0;
 843:	b8 00 00 00 00       	mov    $0x0,%eax
 848:	eb 13                	jmp    85d <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 84a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 84d:	89 45 f0             	mov    %eax,-0x10(%ebp)
 850:	8b 45 f4             	mov    -0xc(%ebp),%eax
 853:	8b 00                	mov    (%eax),%eax
 855:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 858:	e9 70 ff ff ff       	jmp    7cd <malloc+0x4e>
}
 85d:	c9                   	leave  
 85e:	c3                   	ret    
