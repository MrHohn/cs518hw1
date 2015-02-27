
_shutdown:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "types.h"
#include "stat.h"
#include "user.h"

int main(int argc, char *argv[])
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 e4 f0             	and    $0xfffffff0,%esp
	halt();
   6:	e8 09 03 00 00       	call   314 <halt>
	exit();
   b:	e8 64 02 00 00       	call   274 <exit>

00000010 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  10:	55                   	push   %ebp
  11:	89 e5                	mov    %esp,%ebp
  13:	57                   	push   %edi
  14:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  15:	8b 4d 08             	mov    0x8(%ebp),%ecx
  18:	8b 55 10             	mov    0x10(%ebp),%edx
  1b:	8b 45 0c             	mov    0xc(%ebp),%eax
  1e:	89 cb                	mov    %ecx,%ebx
  20:	89 df                	mov    %ebx,%edi
  22:	89 d1                	mov    %edx,%ecx
  24:	fc                   	cld    
  25:	f3 aa                	rep stos %al,%es:(%edi)
  27:	89 ca                	mov    %ecx,%edx
  29:	89 fb                	mov    %edi,%ebx
  2b:	89 5d 08             	mov    %ebx,0x8(%ebp)
  2e:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  31:	5b                   	pop    %ebx
  32:	5f                   	pop    %edi
  33:	5d                   	pop    %ebp
  34:	c3                   	ret    

00000035 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  35:	55                   	push   %ebp
  36:	89 e5                	mov    %esp,%ebp
  38:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  3b:	8b 45 08             	mov    0x8(%ebp),%eax
  3e:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  41:	90                   	nop
  42:	8b 45 0c             	mov    0xc(%ebp),%eax
  45:	0f b6 10             	movzbl (%eax),%edx
  48:	8b 45 08             	mov    0x8(%ebp),%eax
  4b:	88 10                	mov    %dl,(%eax)
  4d:	8b 45 08             	mov    0x8(%ebp),%eax
  50:	0f b6 00             	movzbl (%eax),%eax
  53:	84 c0                	test   %al,%al
  55:	0f 95 c0             	setne  %al
  58:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  5c:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  60:	84 c0                	test   %al,%al
  62:	75 de                	jne    42 <strcpy+0xd>
    ;
  return os;
  64:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  67:	c9                   	leave  
  68:	c3                   	ret    

00000069 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  69:	55                   	push   %ebp
  6a:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  6c:	eb 08                	jmp    76 <strcmp+0xd>
    p++, q++;
  6e:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  72:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  76:	8b 45 08             	mov    0x8(%ebp),%eax
  79:	0f b6 00             	movzbl (%eax),%eax
  7c:	84 c0                	test   %al,%al
  7e:	74 10                	je     90 <strcmp+0x27>
  80:	8b 45 08             	mov    0x8(%ebp),%eax
  83:	0f b6 10             	movzbl (%eax),%edx
  86:	8b 45 0c             	mov    0xc(%ebp),%eax
  89:	0f b6 00             	movzbl (%eax),%eax
  8c:	38 c2                	cmp    %al,%dl
  8e:	74 de                	je     6e <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
  90:	8b 45 08             	mov    0x8(%ebp),%eax
  93:	0f b6 00             	movzbl (%eax),%eax
  96:	0f b6 d0             	movzbl %al,%edx
  99:	8b 45 0c             	mov    0xc(%ebp),%eax
  9c:	0f b6 00             	movzbl (%eax),%eax
  9f:	0f b6 c0             	movzbl %al,%eax
  a2:	89 d1                	mov    %edx,%ecx
  a4:	29 c1                	sub    %eax,%ecx
  a6:	89 c8                	mov    %ecx,%eax
}
  a8:	5d                   	pop    %ebp
  a9:	c3                   	ret    

000000aa <strlen>:

uint
strlen(char *s)
{
  aa:	55                   	push   %ebp
  ab:	89 e5                	mov    %esp,%ebp
  ad:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
  b0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  b7:	eb 04                	jmp    bd <strlen+0x13>
  b9:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  bd:	8b 45 fc             	mov    -0x4(%ebp),%eax
  c0:	03 45 08             	add    0x8(%ebp),%eax
  c3:	0f b6 00             	movzbl (%eax),%eax
  c6:	84 c0                	test   %al,%al
  c8:	75 ef                	jne    b9 <strlen+0xf>
    ;
  return n;
  ca:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  cd:	c9                   	leave  
  ce:	c3                   	ret    

000000cf <memset>:

void*
memset(void *dst, int c, uint n)
{
  cf:	55                   	push   %ebp
  d0:	89 e5                	mov    %esp,%ebp
  d2:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
  d5:	8b 45 10             	mov    0x10(%ebp),%eax
  d8:	89 44 24 08          	mov    %eax,0x8(%esp)
  dc:	8b 45 0c             	mov    0xc(%ebp),%eax
  df:	89 44 24 04          	mov    %eax,0x4(%esp)
  e3:	8b 45 08             	mov    0x8(%ebp),%eax
  e6:	89 04 24             	mov    %eax,(%esp)
  e9:	e8 22 ff ff ff       	call   10 <stosb>
  return dst;
  ee:	8b 45 08             	mov    0x8(%ebp),%eax
}
  f1:	c9                   	leave  
  f2:	c3                   	ret    

000000f3 <strchr>:

char*
strchr(const char *s, char c)
{
  f3:	55                   	push   %ebp
  f4:	89 e5                	mov    %esp,%ebp
  f6:	83 ec 04             	sub    $0x4,%esp
  f9:	8b 45 0c             	mov    0xc(%ebp),%eax
  fc:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
  ff:	eb 14                	jmp    115 <strchr+0x22>
    if(*s == c)
 101:	8b 45 08             	mov    0x8(%ebp),%eax
 104:	0f b6 00             	movzbl (%eax),%eax
 107:	3a 45 fc             	cmp    -0x4(%ebp),%al
 10a:	75 05                	jne    111 <strchr+0x1e>
      return (char*)s;
 10c:	8b 45 08             	mov    0x8(%ebp),%eax
 10f:	eb 13                	jmp    124 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 111:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 115:	8b 45 08             	mov    0x8(%ebp),%eax
 118:	0f b6 00             	movzbl (%eax),%eax
 11b:	84 c0                	test   %al,%al
 11d:	75 e2                	jne    101 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 11f:	b8 00 00 00 00       	mov    $0x0,%eax
}
 124:	c9                   	leave  
 125:	c3                   	ret    

00000126 <gets>:

char*
gets(char *buf, int max)
{
 126:	55                   	push   %ebp
 127:	89 e5                	mov    %esp,%ebp
 129:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 12c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 133:	eb 44                	jmp    179 <gets+0x53>
    cc = read(0, &c, 1);
 135:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 13c:	00 
 13d:	8d 45 ef             	lea    -0x11(%ebp),%eax
 140:	89 44 24 04          	mov    %eax,0x4(%esp)
 144:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 14b:	e8 3c 01 00 00       	call   28c <read>
 150:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 153:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 157:	7e 2d                	jle    186 <gets+0x60>
      break;
    buf[i++] = c;
 159:	8b 45 f4             	mov    -0xc(%ebp),%eax
 15c:	03 45 08             	add    0x8(%ebp),%eax
 15f:	0f b6 55 ef          	movzbl -0x11(%ebp),%edx
 163:	88 10                	mov    %dl,(%eax)
 165:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(c == '\n' || c == '\r')
 169:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 16d:	3c 0a                	cmp    $0xa,%al
 16f:	74 16                	je     187 <gets+0x61>
 171:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 175:	3c 0d                	cmp    $0xd,%al
 177:	74 0e                	je     187 <gets+0x61>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 179:	8b 45 f4             	mov    -0xc(%ebp),%eax
 17c:	83 c0 01             	add    $0x1,%eax
 17f:	3b 45 0c             	cmp    0xc(%ebp),%eax
 182:	7c b1                	jl     135 <gets+0xf>
 184:	eb 01                	jmp    187 <gets+0x61>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 186:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 187:	8b 45 f4             	mov    -0xc(%ebp),%eax
 18a:	03 45 08             	add    0x8(%ebp),%eax
 18d:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 190:	8b 45 08             	mov    0x8(%ebp),%eax
}
 193:	c9                   	leave  
 194:	c3                   	ret    

00000195 <stat>:

int
stat(char *n, struct stat *st)
{
 195:	55                   	push   %ebp
 196:	89 e5                	mov    %esp,%ebp
 198:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 19b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 1a2:	00 
 1a3:	8b 45 08             	mov    0x8(%ebp),%eax
 1a6:	89 04 24             	mov    %eax,(%esp)
 1a9:	e8 06 01 00 00       	call   2b4 <open>
 1ae:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 1b1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 1b5:	79 07                	jns    1be <stat+0x29>
    return -1;
 1b7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 1bc:	eb 23                	jmp    1e1 <stat+0x4c>
  r = fstat(fd, st);
 1be:	8b 45 0c             	mov    0xc(%ebp),%eax
 1c1:	89 44 24 04          	mov    %eax,0x4(%esp)
 1c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1c8:	89 04 24             	mov    %eax,(%esp)
 1cb:	e8 fc 00 00 00       	call   2cc <fstat>
 1d0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 1d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1d6:	89 04 24             	mov    %eax,(%esp)
 1d9:	e8 be 00 00 00       	call   29c <close>
  return r;
 1de:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 1e1:	c9                   	leave  
 1e2:	c3                   	ret    

000001e3 <atoi>:

int
atoi(const char *s)
{
 1e3:	55                   	push   %ebp
 1e4:	89 e5                	mov    %esp,%ebp
 1e6:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 1e9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 1f0:	eb 23                	jmp    215 <atoi+0x32>
    n = n*10 + *s++ - '0';
 1f2:	8b 55 fc             	mov    -0x4(%ebp),%edx
 1f5:	89 d0                	mov    %edx,%eax
 1f7:	c1 e0 02             	shl    $0x2,%eax
 1fa:	01 d0                	add    %edx,%eax
 1fc:	01 c0                	add    %eax,%eax
 1fe:	89 c2                	mov    %eax,%edx
 200:	8b 45 08             	mov    0x8(%ebp),%eax
 203:	0f b6 00             	movzbl (%eax),%eax
 206:	0f be c0             	movsbl %al,%eax
 209:	01 d0                	add    %edx,%eax
 20b:	83 e8 30             	sub    $0x30,%eax
 20e:	89 45 fc             	mov    %eax,-0x4(%ebp)
 211:	83 45 08 01          	addl   $0x1,0x8(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 215:	8b 45 08             	mov    0x8(%ebp),%eax
 218:	0f b6 00             	movzbl (%eax),%eax
 21b:	3c 2f                	cmp    $0x2f,%al
 21d:	7e 0a                	jle    229 <atoi+0x46>
 21f:	8b 45 08             	mov    0x8(%ebp),%eax
 222:	0f b6 00             	movzbl (%eax),%eax
 225:	3c 39                	cmp    $0x39,%al
 227:	7e c9                	jle    1f2 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 229:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 22c:	c9                   	leave  
 22d:	c3                   	ret    

0000022e <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 22e:	55                   	push   %ebp
 22f:	89 e5                	mov    %esp,%ebp
 231:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 234:	8b 45 08             	mov    0x8(%ebp),%eax
 237:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 23a:	8b 45 0c             	mov    0xc(%ebp),%eax
 23d:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 240:	eb 13                	jmp    255 <memmove+0x27>
    *dst++ = *src++;
 242:	8b 45 f8             	mov    -0x8(%ebp),%eax
 245:	0f b6 10             	movzbl (%eax),%edx
 248:	8b 45 fc             	mov    -0x4(%ebp),%eax
 24b:	88 10                	mov    %dl,(%eax)
 24d:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 251:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 255:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
 259:	0f 9f c0             	setg   %al
 25c:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
 260:	84 c0                	test   %al,%al
 262:	75 de                	jne    242 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 264:	8b 45 08             	mov    0x8(%ebp),%eax
}
 267:	c9                   	leave  
 268:	c3                   	ret    
 269:	90                   	nop
 26a:	90                   	nop
 26b:	90                   	nop

0000026c <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 26c:	b8 01 00 00 00       	mov    $0x1,%eax
 271:	cd 40                	int    $0x40
 273:	c3                   	ret    

00000274 <exit>:
SYSCALL(exit)
 274:	b8 02 00 00 00       	mov    $0x2,%eax
 279:	cd 40                	int    $0x40
 27b:	c3                   	ret    

0000027c <wait>:
SYSCALL(wait)
 27c:	b8 03 00 00 00       	mov    $0x3,%eax
 281:	cd 40                	int    $0x40
 283:	c3                   	ret    

00000284 <pipe>:
SYSCALL(pipe)
 284:	b8 04 00 00 00       	mov    $0x4,%eax
 289:	cd 40                	int    $0x40
 28b:	c3                   	ret    

0000028c <read>:
SYSCALL(read)
 28c:	b8 05 00 00 00       	mov    $0x5,%eax
 291:	cd 40                	int    $0x40
 293:	c3                   	ret    

00000294 <write>:
SYSCALL(write)
 294:	b8 10 00 00 00       	mov    $0x10,%eax
 299:	cd 40                	int    $0x40
 29b:	c3                   	ret    

0000029c <close>:
SYSCALL(close)
 29c:	b8 15 00 00 00       	mov    $0x15,%eax
 2a1:	cd 40                	int    $0x40
 2a3:	c3                   	ret    

000002a4 <kill>:
SYSCALL(kill)
 2a4:	b8 06 00 00 00       	mov    $0x6,%eax
 2a9:	cd 40                	int    $0x40
 2ab:	c3                   	ret    

000002ac <exec>:
SYSCALL(exec)
 2ac:	b8 07 00 00 00       	mov    $0x7,%eax
 2b1:	cd 40                	int    $0x40
 2b3:	c3                   	ret    

000002b4 <open>:
SYSCALL(open)
 2b4:	b8 0f 00 00 00       	mov    $0xf,%eax
 2b9:	cd 40                	int    $0x40
 2bb:	c3                   	ret    

000002bc <mknod>:
SYSCALL(mknod)
 2bc:	b8 11 00 00 00       	mov    $0x11,%eax
 2c1:	cd 40                	int    $0x40
 2c3:	c3                   	ret    

000002c4 <unlink>:
SYSCALL(unlink)
 2c4:	b8 12 00 00 00       	mov    $0x12,%eax
 2c9:	cd 40                	int    $0x40
 2cb:	c3                   	ret    

000002cc <fstat>:
SYSCALL(fstat)
 2cc:	b8 08 00 00 00       	mov    $0x8,%eax
 2d1:	cd 40                	int    $0x40
 2d3:	c3                   	ret    

000002d4 <link>:
SYSCALL(link)
 2d4:	b8 13 00 00 00       	mov    $0x13,%eax
 2d9:	cd 40                	int    $0x40
 2db:	c3                   	ret    

000002dc <mkdir>:
SYSCALL(mkdir)
 2dc:	b8 14 00 00 00       	mov    $0x14,%eax
 2e1:	cd 40                	int    $0x40
 2e3:	c3                   	ret    

000002e4 <chdir>:
SYSCALL(chdir)
 2e4:	b8 09 00 00 00       	mov    $0x9,%eax
 2e9:	cd 40                	int    $0x40
 2eb:	c3                   	ret    

000002ec <dup>:
SYSCALL(dup)
 2ec:	b8 0a 00 00 00       	mov    $0xa,%eax
 2f1:	cd 40                	int    $0x40
 2f3:	c3                   	ret    

000002f4 <getpid>:
SYSCALL(getpid)
 2f4:	b8 0b 00 00 00       	mov    $0xb,%eax
 2f9:	cd 40                	int    $0x40
 2fb:	c3                   	ret    

000002fc <sbrk>:
SYSCALL(sbrk)
 2fc:	b8 0c 00 00 00       	mov    $0xc,%eax
 301:	cd 40                	int    $0x40
 303:	c3                   	ret    

00000304 <sleep>:
SYSCALL(sleep)
 304:	b8 0d 00 00 00       	mov    $0xd,%eax
 309:	cd 40                	int    $0x40
 30b:	c3                   	ret    

0000030c <uptime>:
SYSCALL(uptime)
 30c:	b8 0e 00 00 00       	mov    $0xe,%eax
 311:	cd 40                	int    $0x40
 313:	c3                   	ret    

00000314 <halt>:
SYSCALL(halt)
 314:	b8 16 00 00 00       	mov    $0x16,%eax
 319:	cd 40                	int    $0x40
 31b:	c3                   	ret    

0000031c <signal>:
 31c:	b8 17 00 00 00       	mov    $0x17,%eax
 321:	cd 40                	int    $0x40
 323:	c3                   	ret    

00000324 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 324:	55                   	push   %ebp
 325:	89 e5                	mov    %esp,%ebp
 327:	83 ec 28             	sub    $0x28,%esp
 32a:	8b 45 0c             	mov    0xc(%ebp),%eax
 32d:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 330:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 337:	00 
 338:	8d 45 f4             	lea    -0xc(%ebp),%eax
 33b:	89 44 24 04          	mov    %eax,0x4(%esp)
 33f:	8b 45 08             	mov    0x8(%ebp),%eax
 342:	89 04 24             	mov    %eax,(%esp)
 345:	e8 4a ff ff ff       	call   294 <write>
}
 34a:	c9                   	leave  
 34b:	c3                   	ret    

0000034c <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 34c:	55                   	push   %ebp
 34d:	89 e5                	mov    %esp,%ebp
 34f:	83 ec 48             	sub    $0x48,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 352:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 359:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 35d:	74 17                	je     376 <printint+0x2a>
 35f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 363:	79 11                	jns    376 <printint+0x2a>
    neg = 1;
 365:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 36c:	8b 45 0c             	mov    0xc(%ebp),%eax
 36f:	f7 d8                	neg    %eax
 371:	89 45 ec             	mov    %eax,-0x14(%ebp)
 374:	eb 06                	jmp    37c <printint+0x30>
  } else {
    x = xx;
 376:	8b 45 0c             	mov    0xc(%ebp),%eax
 379:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 37c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 383:	8b 4d 10             	mov    0x10(%ebp),%ecx
 386:	8b 45 ec             	mov    -0x14(%ebp),%eax
 389:	ba 00 00 00 00       	mov    $0x0,%edx
 38e:	f7 f1                	div    %ecx
 390:	89 d0                	mov    %edx,%eax
 392:	0f b6 90 04 0a 00 00 	movzbl 0xa04(%eax),%edx
 399:	8d 45 dc             	lea    -0x24(%ebp),%eax
 39c:	03 45 f4             	add    -0xc(%ebp),%eax
 39f:	88 10                	mov    %dl,(%eax)
 3a1:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  }while((x /= base) != 0);
 3a5:	8b 55 10             	mov    0x10(%ebp),%edx
 3a8:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 3ab:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3ae:	ba 00 00 00 00       	mov    $0x0,%edx
 3b3:	f7 75 d4             	divl   -0x2c(%ebp)
 3b6:	89 45 ec             	mov    %eax,-0x14(%ebp)
 3b9:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 3bd:	75 c4                	jne    383 <printint+0x37>
  if(neg)
 3bf:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 3c3:	74 2a                	je     3ef <printint+0xa3>
    buf[i++] = '-';
 3c5:	8d 45 dc             	lea    -0x24(%ebp),%eax
 3c8:	03 45 f4             	add    -0xc(%ebp),%eax
 3cb:	c6 00 2d             	movb   $0x2d,(%eax)
 3ce:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)

  while(--i >= 0)
 3d2:	eb 1b                	jmp    3ef <printint+0xa3>
    putc(fd, buf[i]);
 3d4:	8d 45 dc             	lea    -0x24(%ebp),%eax
 3d7:	03 45 f4             	add    -0xc(%ebp),%eax
 3da:	0f b6 00             	movzbl (%eax),%eax
 3dd:	0f be c0             	movsbl %al,%eax
 3e0:	89 44 24 04          	mov    %eax,0x4(%esp)
 3e4:	8b 45 08             	mov    0x8(%ebp),%eax
 3e7:	89 04 24             	mov    %eax,(%esp)
 3ea:	e8 35 ff ff ff       	call   324 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 3ef:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 3f3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 3f7:	79 db                	jns    3d4 <printint+0x88>
    putc(fd, buf[i]);
}
 3f9:	c9                   	leave  
 3fa:	c3                   	ret    

000003fb <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 3fb:	55                   	push   %ebp
 3fc:	89 e5                	mov    %esp,%ebp
 3fe:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 401:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 408:	8d 45 0c             	lea    0xc(%ebp),%eax
 40b:	83 c0 04             	add    $0x4,%eax
 40e:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 411:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 418:	e9 7d 01 00 00       	jmp    59a <printf+0x19f>
    c = fmt[i] & 0xff;
 41d:	8b 55 0c             	mov    0xc(%ebp),%edx
 420:	8b 45 f0             	mov    -0x10(%ebp),%eax
 423:	01 d0                	add    %edx,%eax
 425:	0f b6 00             	movzbl (%eax),%eax
 428:	0f be c0             	movsbl %al,%eax
 42b:	25 ff 00 00 00       	and    $0xff,%eax
 430:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 433:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 437:	75 2c                	jne    465 <printf+0x6a>
      if(c == '%'){
 439:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 43d:	75 0c                	jne    44b <printf+0x50>
        state = '%';
 43f:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 446:	e9 4b 01 00 00       	jmp    596 <printf+0x19b>
      } else {
        putc(fd, c);
 44b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 44e:	0f be c0             	movsbl %al,%eax
 451:	89 44 24 04          	mov    %eax,0x4(%esp)
 455:	8b 45 08             	mov    0x8(%ebp),%eax
 458:	89 04 24             	mov    %eax,(%esp)
 45b:	e8 c4 fe ff ff       	call   324 <putc>
 460:	e9 31 01 00 00       	jmp    596 <printf+0x19b>
      }
    } else if(state == '%'){
 465:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 469:	0f 85 27 01 00 00    	jne    596 <printf+0x19b>
      if(c == 'd'){
 46f:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 473:	75 2d                	jne    4a2 <printf+0xa7>
        printint(fd, *ap, 10, 1);
 475:	8b 45 e8             	mov    -0x18(%ebp),%eax
 478:	8b 00                	mov    (%eax),%eax
 47a:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 481:	00 
 482:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 489:	00 
 48a:	89 44 24 04          	mov    %eax,0x4(%esp)
 48e:	8b 45 08             	mov    0x8(%ebp),%eax
 491:	89 04 24             	mov    %eax,(%esp)
 494:	e8 b3 fe ff ff       	call   34c <printint>
        ap++;
 499:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 49d:	e9 ed 00 00 00       	jmp    58f <printf+0x194>
      } else if(c == 'x' || c == 'p'){
 4a2:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 4a6:	74 06                	je     4ae <printf+0xb3>
 4a8:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 4ac:	75 2d                	jne    4db <printf+0xe0>
        printint(fd, *ap, 16, 0);
 4ae:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4b1:	8b 00                	mov    (%eax),%eax
 4b3:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 4ba:	00 
 4bb:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 4c2:	00 
 4c3:	89 44 24 04          	mov    %eax,0x4(%esp)
 4c7:	8b 45 08             	mov    0x8(%ebp),%eax
 4ca:	89 04 24             	mov    %eax,(%esp)
 4cd:	e8 7a fe ff ff       	call   34c <printint>
        ap++;
 4d2:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 4d6:	e9 b4 00 00 00       	jmp    58f <printf+0x194>
      } else if(c == 's'){
 4db:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 4df:	75 46                	jne    527 <printf+0x12c>
        s = (char*)*ap;
 4e1:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4e4:	8b 00                	mov    (%eax),%eax
 4e6:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 4e9:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 4ed:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 4f1:	75 27                	jne    51a <printf+0x11f>
          s = "(null)";
 4f3:	c7 45 f4 bf 07 00 00 	movl   $0x7bf,-0xc(%ebp)
        while(*s != 0){
 4fa:	eb 1e                	jmp    51a <printf+0x11f>
          putc(fd, *s);
 4fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4ff:	0f b6 00             	movzbl (%eax),%eax
 502:	0f be c0             	movsbl %al,%eax
 505:	89 44 24 04          	mov    %eax,0x4(%esp)
 509:	8b 45 08             	mov    0x8(%ebp),%eax
 50c:	89 04 24             	mov    %eax,(%esp)
 50f:	e8 10 fe ff ff       	call   324 <putc>
          s++;
 514:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 518:	eb 01                	jmp    51b <printf+0x120>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 51a:	90                   	nop
 51b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 51e:	0f b6 00             	movzbl (%eax),%eax
 521:	84 c0                	test   %al,%al
 523:	75 d7                	jne    4fc <printf+0x101>
 525:	eb 68                	jmp    58f <printf+0x194>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 527:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 52b:	75 1d                	jne    54a <printf+0x14f>
        putc(fd, *ap);
 52d:	8b 45 e8             	mov    -0x18(%ebp),%eax
 530:	8b 00                	mov    (%eax),%eax
 532:	0f be c0             	movsbl %al,%eax
 535:	89 44 24 04          	mov    %eax,0x4(%esp)
 539:	8b 45 08             	mov    0x8(%ebp),%eax
 53c:	89 04 24             	mov    %eax,(%esp)
 53f:	e8 e0 fd ff ff       	call   324 <putc>
        ap++;
 544:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 548:	eb 45                	jmp    58f <printf+0x194>
      } else if(c == '%'){
 54a:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 54e:	75 17                	jne    567 <printf+0x16c>
        putc(fd, c);
 550:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 553:	0f be c0             	movsbl %al,%eax
 556:	89 44 24 04          	mov    %eax,0x4(%esp)
 55a:	8b 45 08             	mov    0x8(%ebp),%eax
 55d:	89 04 24             	mov    %eax,(%esp)
 560:	e8 bf fd ff ff       	call   324 <putc>
 565:	eb 28                	jmp    58f <printf+0x194>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 567:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 56e:	00 
 56f:	8b 45 08             	mov    0x8(%ebp),%eax
 572:	89 04 24             	mov    %eax,(%esp)
 575:	e8 aa fd ff ff       	call   324 <putc>
        putc(fd, c);
 57a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 57d:	0f be c0             	movsbl %al,%eax
 580:	89 44 24 04          	mov    %eax,0x4(%esp)
 584:	8b 45 08             	mov    0x8(%ebp),%eax
 587:	89 04 24             	mov    %eax,(%esp)
 58a:	e8 95 fd ff ff       	call   324 <putc>
      }
      state = 0;
 58f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 596:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 59a:	8b 55 0c             	mov    0xc(%ebp),%edx
 59d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 5a0:	01 d0                	add    %edx,%eax
 5a2:	0f b6 00             	movzbl (%eax),%eax
 5a5:	84 c0                	test   %al,%al
 5a7:	0f 85 70 fe ff ff    	jne    41d <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 5ad:	c9                   	leave  
 5ae:	c3                   	ret    
 5af:	90                   	nop

000005b0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 5b0:	55                   	push   %ebp
 5b1:	89 e5                	mov    %esp,%ebp
 5b3:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 5b6:	8b 45 08             	mov    0x8(%ebp),%eax
 5b9:	83 e8 08             	sub    $0x8,%eax
 5bc:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5bf:	a1 20 0a 00 00       	mov    0xa20,%eax
 5c4:	89 45 fc             	mov    %eax,-0x4(%ebp)
 5c7:	eb 24                	jmp    5ed <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5c9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5cc:	8b 00                	mov    (%eax),%eax
 5ce:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 5d1:	77 12                	ja     5e5 <free+0x35>
 5d3:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5d6:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 5d9:	77 24                	ja     5ff <free+0x4f>
 5db:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5de:	8b 00                	mov    (%eax),%eax
 5e0:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 5e3:	77 1a                	ja     5ff <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5e5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5e8:	8b 00                	mov    (%eax),%eax
 5ea:	89 45 fc             	mov    %eax,-0x4(%ebp)
 5ed:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5f0:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 5f3:	76 d4                	jbe    5c9 <free+0x19>
 5f5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5f8:	8b 00                	mov    (%eax),%eax
 5fa:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 5fd:	76 ca                	jbe    5c9 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 5ff:	8b 45 f8             	mov    -0x8(%ebp),%eax
 602:	8b 40 04             	mov    0x4(%eax),%eax
 605:	c1 e0 03             	shl    $0x3,%eax
 608:	89 c2                	mov    %eax,%edx
 60a:	03 55 f8             	add    -0x8(%ebp),%edx
 60d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 610:	8b 00                	mov    (%eax),%eax
 612:	39 c2                	cmp    %eax,%edx
 614:	75 24                	jne    63a <free+0x8a>
    bp->s.size += p->s.ptr->s.size;
 616:	8b 45 f8             	mov    -0x8(%ebp),%eax
 619:	8b 50 04             	mov    0x4(%eax),%edx
 61c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 61f:	8b 00                	mov    (%eax),%eax
 621:	8b 40 04             	mov    0x4(%eax),%eax
 624:	01 c2                	add    %eax,%edx
 626:	8b 45 f8             	mov    -0x8(%ebp),%eax
 629:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 62c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 62f:	8b 00                	mov    (%eax),%eax
 631:	8b 10                	mov    (%eax),%edx
 633:	8b 45 f8             	mov    -0x8(%ebp),%eax
 636:	89 10                	mov    %edx,(%eax)
 638:	eb 0a                	jmp    644 <free+0x94>
  } else
    bp->s.ptr = p->s.ptr;
 63a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 63d:	8b 10                	mov    (%eax),%edx
 63f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 642:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 644:	8b 45 fc             	mov    -0x4(%ebp),%eax
 647:	8b 40 04             	mov    0x4(%eax),%eax
 64a:	c1 e0 03             	shl    $0x3,%eax
 64d:	03 45 fc             	add    -0x4(%ebp),%eax
 650:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 653:	75 20                	jne    675 <free+0xc5>
    p->s.size += bp->s.size;
 655:	8b 45 fc             	mov    -0x4(%ebp),%eax
 658:	8b 50 04             	mov    0x4(%eax),%edx
 65b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 65e:	8b 40 04             	mov    0x4(%eax),%eax
 661:	01 c2                	add    %eax,%edx
 663:	8b 45 fc             	mov    -0x4(%ebp),%eax
 666:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 669:	8b 45 f8             	mov    -0x8(%ebp),%eax
 66c:	8b 10                	mov    (%eax),%edx
 66e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 671:	89 10                	mov    %edx,(%eax)
 673:	eb 08                	jmp    67d <free+0xcd>
  } else
    p->s.ptr = bp;
 675:	8b 45 fc             	mov    -0x4(%ebp),%eax
 678:	8b 55 f8             	mov    -0x8(%ebp),%edx
 67b:	89 10                	mov    %edx,(%eax)
  freep = p;
 67d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 680:	a3 20 0a 00 00       	mov    %eax,0xa20
}
 685:	c9                   	leave  
 686:	c3                   	ret    

00000687 <morecore>:

static Header*
morecore(uint nu)
{
 687:	55                   	push   %ebp
 688:	89 e5                	mov    %esp,%ebp
 68a:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 68d:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 694:	77 07                	ja     69d <morecore+0x16>
    nu = 4096;
 696:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 69d:	8b 45 08             	mov    0x8(%ebp),%eax
 6a0:	c1 e0 03             	shl    $0x3,%eax
 6a3:	89 04 24             	mov    %eax,(%esp)
 6a6:	e8 51 fc ff ff       	call   2fc <sbrk>
 6ab:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 6ae:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 6b2:	75 07                	jne    6bb <morecore+0x34>
    return 0;
 6b4:	b8 00 00 00 00       	mov    $0x0,%eax
 6b9:	eb 22                	jmp    6dd <morecore+0x56>
  hp = (Header*)p;
 6bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6be:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 6c1:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6c4:	8b 55 08             	mov    0x8(%ebp),%edx
 6c7:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 6ca:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6cd:	83 c0 08             	add    $0x8,%eax
 6d0:	89 04 24             	mov    %eax,(%esp)
 6d3:	e8 d8 fe ff ff       	call   5b0 <free>
  return freep;
 6d8:	a1 20 0a 00 00       	mov    0xa20,%eax
}
 6dd:	c9                   	leave  
 6de:	c3                   	ret    

000006df <malloc>:

void*
malloc(uint nbytes)
{
 6df:	55                   	push   %ebp
 6e0:	89 e5                	mov    %esp,%ebp
 6e2:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6e5:	8b 45 08             	mov    0x8(%ebp),%eax
 6e8:	83 c0 07             	add    $0x7,%eax
 6eb:	c1 e8 03             	shr    $0x3,%eax
 6ee:	83 c0 01             	add    $0x1,%eax
 6f1:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 6f4:	a1 20 0a 00 00       	mov    0xa20,%eax
 6f9:	89 45 f0             	mov    %eax,-0x10(%ebp)
 6fc:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 700:	75 23                	jne    725 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 702:	c7 45 f0 18 0a 00 00 	movl   $0xa18,-0x10(%ebp)
 709:	8b 45 f0             	mov    -0x10(%ebp),%eax
 70c:	a3 20 0a 00 00       	mov    %eax,0xa20
 711:	a1 20 0a 00 00       	mov    0xa20,%eax
 716:	a3 18 0a 00 00       	mov    %eax,0xa18
    base.s.size = 0;
 71b:	c7 05 1c 0a 00 00 00 	movl   $0x0,0xa1c
 722:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 725:	8b 45 f0             	mov    -0x10(%ebp),%eax
 728:	8b 00                	mov    (%eax),%eax
 72a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 72d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 730:	8b 40 04             	mov    0x4(%eax),%eax
 733:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 736:	72 4d                	jb     785 <malloc+0xa6>
      if(p->s.size == nunits)
 738:	8b 45 f4             	mov    -0xc(%ebp),%eax
 73b:	8b 40 04             	mov    0x4(%eax),%eax
 73e:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 741:	75 0c                	jne    74f <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 743:	8b 45 f4             	mov    -0xc(%ebp),%eax
 746:	8b 10                	mov    (%eax),%edx
 748:	8b 45 f0             	mov    -0x10(%ebp),%eax
 74b:	89 10                	mov    %edx,(%eax)
 74d:	eb 26                	jmp    775 <malloc+0x96>
      else {
        p->s.size -= nunits;
 74f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 752:	8b 40 04             	mov    0x4(%eax),%eax
 755:	89 c2                	mov    %eax,%edx
 757:	2b 55 ec             	sub    -0x14(%ebp),%edx
 75a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 75d:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 760:	8b 45 f4             	mov    -0xc(%ebp),%eax
 763:	8b 40 04             	mov    0x4(%eax),%eax
 766:	c1 e0 03             	shl    $0x3,%eax
 769:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 76c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 76f:	8b 55 ec             	mov    -0x14(%ebp),%edx
 772:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 775:	8b 45 f0             	mov    -0x10(%ebp),%eax
 778:	a3 20 0a 00 00       	mov    %eax,0xa20
      return (void*)(p + 1);
 77d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 780:	83 c0 08             	add    $0x8,%eax
 783:	eb 38                	jmp    7bd <malloc+0xde>
    }
    if(p == freep)
 785:	a1 20 0a 00 00       	mov    0xa20,%eax
 78a:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 78d:	75 1b                	jne    7aa <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 78f:	8b 45 ec             	mov    -0x14(%ebp),%eax
 792:	89 04 24             	mov    %eax,(%esp)
 795:	e8 ed fe ff ff       	call   687 <morecore>
 79a:	89 45 f4             	mov    %eax,-0xc(%ebp)
 79d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 7a1:	75 07                	jne    7aa <malloc+0xcb>
        return 0;
 7a3:	b8 00 00 00 00       	mov    $0x0,%eax
 7a8:	eb 13                	jmp    7bd <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7ad:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7b3:	8b 00                	mov    (%eax),%eax
 7b5:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 7b8:	e9 70 ff ff ff       	jmp    72d <malloc+0x4e>
}
 7bd:	c9                   	leave  
 7be:	c3                   	ret    
