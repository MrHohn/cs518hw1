
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
    __asm__ ("movl 0x8(%ebp),%edx\n\t");
   3:	8b 55 08             	mov    0x8(%ebp),%edx
    __asm__ ("movl 0xc(%ebp),%ecx\n\t");
   6:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    __asm__ ("movl 0x10(%ebp),%eax\n\t");
   9:	8b 45 10             	mov    0x10(%ebp),%eax
    __asm__ ("movl %ecx,0x4(%ebp)\n\t");
   c:	89 4d 04             	mov    %ecx,0x4(%ebp)
    __asm__ ("movl 0x0(%ebp),%ecx\n\t");
   f:	8b 4d 00             	mov    0x0(%ebp),%ecx
    __asm__ ("movl %ecx,0xc(%ebp)\n\t");
  12:	89 4d 0c             	mov    %ecx,0xc(%ebp)
    __asm__ ("movl 0x4(%ebp),%ecx\n\t");
  15:	8b 4d 04             	mov    0x4(%ebp),%ecx
    __asm__ ("add $0xc,%ebp\n\t");
  18:	83 c5 0c             	add    $0xc,%ebp
    __asm__ ("movl $0x7f,4(%ebp)\n\t");
  1b:	c7 45 04 7f 00 00 00 	movl   $0x7f,0x4(%ebp)

    __asm__ ("movl %ebp,%esp\n\t");
  22:	89 ec                	mov    %ebp,%esp
    __asm__ ("pop %ebp\n\t");
  24:	5d                   	pop    %ebp
    __asm__ ("ret\n\t");
  25:	c3                   	ret    


    // __asm__ ("movl $0x92,4(%ebp)\n\t");
    // __asm__ ("ret \n\t");
  26:	5d                   	pop    %ebp
  27:	c3                   	ret    

00000028 <main>:
#include "restorer.h"

void handle_signal(int);

int main(void)
{
  28:	55                   	push   %ebp
  29:	89 e5                	mov    %esp,%ebp
  2b:	83 e4 f0             	and    $0xfffffff0,%esp
  2e:	83 ec 20             	sub    $0x20,%esp
    register int ecx asm ("%ecx");
    // restorer();
    signal(-1, (sighandler_t*) restorer);   // save the address of restorer function inside the kernel.
  31:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  38:	00 
  39:	c7 04 24 ff ff ff ff 	movl   $0xffffffff,(%esp)
  40:	e8 93 03 00 00       	call   3d8 <signal>
    signal(SIGFPE, handle_signal);         // register the actual signal for divide by zero.
  45:	c7 44 24 04 c1 00 00 	movl   $0xc1,0x4(%esp)
  4c:	00 
  4d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  54:	e8 7f 03 00 00       	call   3d8 <signal>

    int x = 5;
  59:	c7 44 24 1c 05 00 00 	movl   $0x5,0x1c(%esp)
  60:	00 
    int y = 0;
  61:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
  68:	00 

    ecx = 5;
  69:	b9 05 00 00 00       	mov    $0x5,%ecx
    x = x / y;
  6e:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  72:	89 c2                	mov    %eax,%edx
  74:	c1 fa 1f             	sar    $0x1f,%edx
  77:	f7 7c 24 18          	idivl  0x18(%esp)
  7b:	89 44 24 1c          	mov    %eax,0x1c(%esp)

    if (ecx == 5)
  7f:	89 c8                	mov    %ecx,%eax
  81:	83 f8 05             	cmp    $0x5,%eax
  84:	75 1c                	jne    a2 <main+0x7a>
        printf(1, "TEST PASSED: Final value of ecx is %d...\n", ecx);
  86:	89 c8                	mov    %ecx,%eax
  88:	89 44 24 08          	mov    %eax,0x8(%esp)
  8c:	c7 44 24 04 7c 08 00 	movl   $0x87c,0x4(%esp)
  93:	00 
  94:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  9b:	e8 17 04 00 00       	call   4b7 <printf>
  a0:	eb 1a                	jmp    bc <main+0x94>
    else
        printf(1, "TEST FAILED: Final value of ecx is %d...\n", ecx);
  a2:	89 c8                	mov    %ecx,%eax
  a4:	89 44 24 08          	mov    %eax,0x8(%esp)
  a8:	c7 44 24 04 a8 08 00 	movl   $0x8a8,0x4(%esp)
  af:	00 
  b0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  b7:	e8 fb 03 00 00       	call   4b7 <printf>

    exit();
  bc:	e8 6f 02 00 00       	call   330 <exit>

000000c1 <handle_signal>:
}

void handle_signal(int signum)
{
  c1:	55                   	push   %ebp
  c2:	89 e5                	mov    %esp,%ebp
    // printf(1, "in handler\n");
    // exit();

    __asm__ ("movl $0x0,%ecx\n\t");
  c4:	b9 00 00 00 00       	mov    $0x0,%ecx
	// Add your code to skip the return ip here
    // __asm__ ("movl $0x0,4(%ebp)\n\t");
  c9:	5d                   	pop    %ebp
  ca:	c3                   	ret    
  cb:	90                   	nop

000000cc <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  cc:	55                   	push   %ebp
  cd:	89 e5                	mov    %esp,%ebp
  cf:	57                   	push   %edi
  d0:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  d1:	8b 4d 08             	mov    0x8(%ebp),%ecx
  d4:	8b 55 10             	mov    0x10(%ebp),%edx
  d7:	8b 45 0c             	mov    0xc(%ebp),%eax
  da:	89 cb                	mov    %ecx,%ebx
  dc:	89 df                	mov    %ebx,%edi
  de:	89 d1                	mov    %edx,%ecx
  e0:	fc                   	cld    
  e1:	f3 aa                	rep stos %al,%es:(%edi)
  e3:	89 ca                	mov    %ecx,%edx
  e5:	89 fb                	mov    %edi,%ebx
  e7:	89 5d 08             	mov    %ebx,0x8(%ebp)
  ea:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  ed:	5b                   	pop    %ebx
  ee:	5f                   	pop    %edi
  ef:	5d                   	pop    %ebp
  f0:	c3                   	ret    

000000f1 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  f1:	55                   	push   %ebp
  f2:	89 e5                	mov    %esp,%ebp
  f4:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  f7:	8b 45 08             	mov    0x8(%ebp),%eax
  fa:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  fd:	90                   	nop
  fe:	8b 45 0c             	mov    0xc(%ebp),%eax
 101:	0f b6 10             	movzbl (%eax),%edx
 104:	8b 45 08             	mov    0x8(%ebp),%eax
 107:	88 10                	mov    %dl,(%eax)
 109:	8b 45 08             	mov    0x8(%ebp),%eax
 10c:	0f b6 00             	movzbl (%eax),%eax
 10f:	84 c0                	test   %al,%al
 111:	0f 95 c0             	setne  %al
 114:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 118:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
 11c:	84 c0                	test   %al,%al
 11e:	75 de                	jne    fe <strcpy+0xd>
    ;
  return os;
 120:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 123:	c9                   	leave  
 124:	c3                   	ret    

00000125 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 125:	55                   	push   %ebp
 126:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 128:	eb 08                	jmp    132 <strcmp+0xd>
    p++, q++;
 12a:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 12e:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 132:	8b 45 08             	mov    0x8(%ebp),%eax
 135:	0f b6 00             	movzbl (%eax),%eax
 138:	84 c0                	test   %al,%al
 13a:	74 10                	je     14c <strcmp+0x27>
 13c:	8b 45 08             	mov    0x8(%ebp),%eax
 13f:	0f b6 10             	movzbl (%eax),%edx
 142:	8b 45 0c             	mov    0xc(%ebp),%eax
 145:	0f b6 00             	movzbl (%eax),%eax
 148:	38 c2                	cmp    %al,%dl
 14a:	74 de                	je     12a <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 14c:	8b 45 08             	mov    0x8(%ebp),%eax
 14f:	0f b6 00             	movzbl (%eax),%eax
 152:	0f b6 d0             	movzbl %al,%edx
 155:	8b 45 0c             	mov    0xc(%ebp),%eax
 158:	0f b6 00             	movzbl (%eax),%eax
 15b:	0f b6 c0             	movzbl %al,%eax
 15e:	89 d1                	mov    %edx,%ecx
 160:	29 c1                	sub    %eax,%ecx
 162:	89 c8                	mov    %ecx,%eax
}
 164:	5d                   	pop    %ebp
 165:	c3                   	ret    

00000166 <strlen>:

uint
strlen(char *s)
{
 166:	55                   	push   %ebp
 167:	89 e5                	mov    %esp,%ebp
 169:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 16c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 173:	eb 04                	jmp    179 <strlen+0x13>
 175:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 179:	8b 45 fc             	mov    -0x4(%ebp),%eax
 17c:	03 45 08             	add    0x8(%ebp),%eax
 17f:	0f b6 00             	movzbl (%eax),%eax
 182:	84 c0                	test   %al,%al
 184:	75 ef                	jne    175 <strlen+0xf>
    ;
  return n;
 186:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 189:	c9                   	leave  
 18a:	c3                   	ret    

0000018b <memset>:

void*
memset(void *dst, int c, uint n)
{
 18b:	55                   	push   %ebp
 18c:	89 e5                	mov    %esp,%ebp
 18e:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
 191:	8b 45 10             	mov    0x10(%ebp),%eax
 194:	89 44 24 08          	mov    %eax,0x8(%esp)
 198:	8b 45 0c             	mov    0xc(%ebp),%eax
 19b:	89 44 24 04          	mov    %eax,0x4(%esp)
 19f:	8b 45 08             	mov    0x8(%ebp),%eax
 1a2:	89 04 24             	mov    %eax,(%esp)
 1a5:	e8 22 ff ff ff       	call   cc <stosb>
  return dst;
 1aa:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1ad:	c9                   	leave  
 1ae:	c3                   	ret    

000001af <strchr>:

char*
strchr(const char *s, char c)
{
 1af:	55                   	push   %ebp
 1b0:	89 e5                	mov    %esp,%ebp
 1b2:	83 ec 04             	sub    $0x4,%esp
 1b5:	8b 45 0c             	mov    0xc(%ebp),%eax
 1b8:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 1bb:	eb 14                	jmp    1d1 <strchr+0x22>
    if(*s == c)
 1bd:	8b 45 08             	mov    0x8(%ebp),%eax
 1c0:	0f b6 00             	movzbl (%eax),%eax
 1c3:	3a 45 fc             	cmp    -0x4(%ebp),%al
 1c6:	75 05                	jne    1cd <strchr+0x1e>
      return (char*)s;
 1c8:	8b 45 08             	mov    0x8(%ebp),%eax
 1cb:	eb 13                	jmp    1e0 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 1cd:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 1d1:	8b 45 08             	mov    0x8(%ebp),%eax
 1d4:	0f b6 00             	movzbl (%eax),%eax
 1d7:	84 c0                	test   %al,%al
 1d9:	75 e2                	jne    1bd <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 1db:	b8 00 00 00 00       	mov    $0x0,%eax
}
 1e0:	c9                   	leave  
 1e1:	c3                   	ret    

000001e2 <gets>:

char*
gets(char *buf, int max)
{
 1e2:	55                   	push   %ebp
 1e3:	89 e5                	mov    %esp,%ebp
 1e5:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1e8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 1ef:	eb 44                	jmp    235 <gets+0x53>
    cc = read(0, &c, 1);
 1f1:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 1f8:	00 
 1f9:	8d 45 ef             	lea    -0x11(%ebp),%eax
 1fc:	89 44 24 04          	mov    %eax,0x4(%esp)
 200:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 207:	e8 3c 01 00 00       	call   348 <read>
 20c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 20f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 213:	7e 2d                	jle    242 <gets+0x60>
      break;
    buf[i++] = c;
 215:	8b 45 f4             	mov    -0xc(%ebp),%eax
 218:	03 45 08             	add    0x8(%ebp),%eax
 21b:	0f b6 55 ef          	movzbl -0x11(%ebp),%edx
 21f:	88 10                	mov    %dl,(%eax)
 221:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(c == '\n' || c == '\r')
 225:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 229:	3c 0a                	cmp    $0xa,%al
 22b:	74 16                	je     243 <gets+0x61>
 22d:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 231:	3c 0d                	cmp    $0xd,%al
 233:	74 0e                	je     243 <gets+0x61>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 235:	8b 45 f4             	mov    -0xc(%ebp),%eax
 238:	83 c0 01             	add    $0x1,%eax
 23b:	3b 45 0c             	cmp    0xc(%ebp),%eax
 23e:	7c b1                	jl     1f1 <gets+0xf>
 240:	eb 01                	jmp    243 <gets+0x61>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 242:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 243:	8b 45 f4             	mov    -0xc(%ebp),%eax
 246:	03 45 08             	add    0x8(%ebp),%eax
 249:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 24c:	8b 45 08             	mov    0x8(%ebp),%eax
}
 24f:	c9                   	leave  
 250:	c3                   	ret    

00000251 <stat>:

int
stat(char *n, struct stat *st)
{
 251:	55                   	push   %ebp
 252:	89 e5                	mov    %esp,%ebp
 254:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 257:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 25e:	00 
 25f:	8b 45 08             	mov    0x8(%ebp),%eax
 262:	89 04 24             	mov    %eax,(%esp)
 265:	e8 06 01 00 00       	call   370 <open>
 26a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 26d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 271:	79 07                	jns    27a <stat+0x29>
    return -1;
 273:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 278:	eb 23                	jmp    29d <stat+0x4c>
  r = fstat(fd, st);
 27a:	8b 45 0c             	mov    0xc(%ebp),%eax
 27d:	89 44 24 04          	mov    %eax,0x4(%esp)
 281:	8b 45 f4             	mov    -0xc(%ebp),%eax
 284:	89 04 24             	mov    %eax,(%esp)
 287:	e8 fc 00 00 00       	call   388 <fstat>
 28c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 28f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 292:	89 04 24             	mov    %eax,(%esp)
 295:	e8 be 00 00 00       	call   358 <close>
  return r;
 29a:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 29d:	c9                   	leave  
 29e:	c3                   	ret    

0000029f <atoi>:

int
atoi(const char *s)
{
 29f:	55                   	push   %ebp
 2a0:	89 e5                	mov    %esp,%ebp
 2a2:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 2a5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 2ac:	eb 23                	jmp    2d1 <atoi+0x32>
    n = n*10 + *s++ - '0';
 2ae:	8b 55 fc             	mov    -0x4(%ebp),%edx
 2b1:	89 d0                	mov    %edx,%eax
 2b3:	c1 e0 02             	shl    $0x2,%eax
 2b6:	01 d0                	add    %edx,%eax
 2b8:	01 c0                	add    %eax,%eax
 2ba:	89 c2                	mov    %eax,%edx
 2bc:	8b 45 08             	mov    0x8(%ebp),%eax
 2bf:	0f b6 00             	movzbl (%eax),%eax
 2c2:	0f be c0             	movsbl %al,%eax
 2c5:	01 d0                	add    %edx,%eax
 2c7:	83 e8 30             	sub    $0x30,%eax
 2ca:	89 45 fc             	mov    %eax,-0x4(%ebp)
 2cd:	83 45 08 01          	addl   $0x1,0x8(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2d1:	8b 45 08             	mov    0x8(%ebp),%eax
 2d4:	0f b6 00             	movzbl (%eax),%eax
 2d7:	3c 2f                	cmp    $0x2f,%al
 2d9:	7e 0a                	jle    2e5 <atoi+0x46>
 2db:	8b 45 08             	mov    0x8(%ebp),%eax
 2de:	0f b6 00             	movzbl (%eax),%eax
 2e1:	3c 39                	cmp    $0x39,%al
 2e3:	7e c9                	jle    2ae <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 2e5:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 2e8:	c9                   	leave  
 2e9:	c3                   	ret    

000002ea <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 2ea:	55                   	push   %ebp
 2eb:	89 e5                	mov    %esp,%ebp
 2ed:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 2f0:	8b 45 08             	mov    0x8(%ebp),%eax
 2f3:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 2f6:	8b 45 0c             	mov    0xc(%ebp),%eax
 2f9:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 2fc:	eb 13                	jmp    311 <memmove+0x27>
    *dst++ = *src++;
 2fe:	8b 45 f8             	mov    -0x8(%ebp),%eax
 301:	0f b6 10             	movzbl (%eax),%edx
 304:	8b 45 fc             	mov    -0x4(%ebp),%eax
 307:	88 10                	mov    %dl,(%eax)
 309:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 30d:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 311:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
 315:	0f 9f c0             	setg   %al
 318:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
 31c:	84 c0                	test   %al,%al
 31e:	75 de                	jne    2fe <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 320:	8b 45 08             	mov    0x8(%ebp),%eax
}
 323:	c9                   	leave  
 324:	c3                   	ret    
 325:	90                   	nop
 326:	90                   	nop
 327:	90                   	nop

00000328 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 328:	b8 01 00 00 00       	mov    $0x1,%eax
 32d:	cd 40                	int    $0x40
 32f:	c3                   	ret    

00000330 <exit>:
SYSCALL(exit)
 330:	b8 02 00 00 00       	mov    $0x2,%eax
 335:	cd 40                	int    $0x40
 337:	c3                   	ret    

00000338 <wait>:
SYSCALL(wait)
 338:	b8 03 00 00 00       	mov    $0x3,%eax
 33d:	cd 40                	int    $0x40
 33f:	c3                   	ret    

00000340 <pipe>:
SYSCALL(pipe)
 340:	b8 04 00 00 00       	mov    $0x4,%eax
 345:	cd 40                	int    $0x40
 347:	c3                   	ret    

00000348 <read>:
SYSCALL(read)
 348:	b8 05 00 00 00       	mov    $0x5,%eax
 34d:	cd 40                	int    $0x40
 34f:	c3                   	ret    

00000350 <write>:
SYSCALL(write)
 350:	b8 10 00 00 00       	mov    $0x10,%eax
 355:	cd 40                	int    $0x40
 357:	c3                   	ret    

00000358 <close>:
SYSCALL(close)
 358:	b8 15 00 00 00       	mov    $0x15,%eax
 35d:	cd 40                	int    $0x40
 35f:	c3                   	ret    

00000360 <kill>:
SYSCALL(kill)
 360:	b8 06 00 00 00       	mov    $0x6,%eax
 365:	cd 40                	int    $0x40
 367:	c3                   	ret    

00000368 <exec>:
SYSCALL(exec)
 368:	b8 07 00 00 00       	mov    $0x7,%eax
 36d:	cd 40                	int    $0x40
 36f:	c3                   	ret    

00000370 <open>:
SYSCALL(open)
 370:	b8 0f 00 00 00       	mov    $0xf,%eax
 375:	cd 40                	int    $0x40
 377:	c3                   	ret    

00000378 <mknod>:
SYSCALL(mknod)
 378:	b8 11 00 00 00       	mov    $0x11,%eax
 37d:	cd 40                	int    $0x40
 37f:	c3                   	ret    

00000380 <unlink>:
SYSCALL(unlink)
 380:	b8 12 00 00 00       	mov    $0x12,%eax
 385:	cd 40                	int    $0x40
 387:	c3                   	ret    

00000388 <fstat>:
SYSCALL(fstat)
 388:	b8 08 00 00 00       	mov    $0x8,%eax
 38d:	cd 40                	int    $0x40
 38f:	c3                   	ret    

00000390 <link>:
SYSCALL(link)
 390:	b8 13 00 00 00       	mov    $0x13,%eax
 395:	cd 40                	int    $0x40
 397:	c3                   	ret    

00000398 <mkdir>:
SYSCALL(mkdir)
 398:	b8 14 00 00 00       	mov    $0x14,%eax
 39d:	cd 40                	int    $0x40
 39f:	c3                   	ret    

000003a0 <chdir>:
SYSCALL(chdir)
 3a0:	b8 09 00 00 00       	mov    $0x9,%eax
 3a5:	cd 40                	int    $0x40
 3a7:	c3                   	ret    

000003a8 <dup>:
SYSCALL(dup)
 3a8:	b8 0a 00 00 00       	mov    $0xa,%eax
 3ad:	cd 40                	int    $0x40
 3af:	c3                   	ret    

000003b0 <getpid>:
SYSCALL(getpid)
 3b0:	b8 0b 00 00 00       	mov    $0xb,%eax
 3b5:	cd 40                	int    $0x40
 3b7:	c3                   	ret    

000003b8 <sbrk>:
SYSCALL(sbrk)
 3b8:	b8 0c 00 00 00       	mov    $0xc,%eax
 3bd:	cd 40                	int    $0x40
 3bf:	c3                   	ret    

000003c0 <sleep>:
SYSCALL(sleep)
 3c0:	b8 0d 00 00 00       	mov    $0xd,%eax
 3c5:	cd 40                	int    $0x40
 3c7:	c3                   	ret    

000003c8 <uptime>:
SYSCALL(uptime)
 3c8:	b8 0e 00 00 00       	mov    $0xe,%eax
 3cd:	cd 40                	int    $0x40
 3cf:	c3                   	ret    

000003d0 <halt>:
SYSCALL(halt)
 3d0:	b8 16 00 00 00       	mov    $0x16,%eax
 3d5:	cd 40                	int    $0x40
 3d7:	c3                   	ret    

000003d8 <signal>:
 3d8:	b8 17 00 00 00       	mov    $0x17,%eax
 3dd:	cd 40                	int    $0x40
 3df:	c3                   	ret    

000003e0 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 3e0:	55                   	push   %ebp
 3e1:	89 e5                	mov    %esp,%ebp
 3e3:	83 ec 28             	sub    $0x28,%esp
 3e6:	8b 45 0c             	mov    0xc(%ebp),%eax
 3e9:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 3ec:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 3f3:	00 
 3f4:	8d 45 f4             	lea    -0xc(%ebp),%eax
 3f7:	89 44 24 04          	mov    %eax,0x4(%esp)
 3fb:	8b 45 08             	mov    0x8(%ebp),%eax
 3fe:	89 04 24             	mov    %eax,(%esp)
 401:	e8 4a ff ff ff       	call   350 <write>
}
 406:	c9                   	leave  
 407:	c3                   	ret    

00000408 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 408:	55                   	push   %ebp
 409:	89 e5                	mov    %esp,%ebp
 40b:	83 ec 48             	sub    $0x48,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 40e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 415:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 419:	74 17                	je     432 <printint+0x2a>
 41b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 41f:	79 11                	jns    432 <printint+0x2a>
    neg = 1;
 421:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 428:	8b 45 0c             	mov    0xc(%ebp),%eax
 42b:	f7 d8                	neg    %eax
 42d:	89 45 ec             	mov    %eax,-0x14(%ebp)
 430:	eb 06                	jmp    438 <printint+0x30>
  } else {
    x = xx;
 432:	8b 45 0c             	mov    0xc(%ebp),%eax
 435:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 438:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 43f:	8b 4d 10             	mov    0x10(%ebp),%ecx
 442:	8b 45 ec             	mov    -0x14(%ebp),%eax
 445:	ba 00 00 00 00       	mov    $0x0,%edx
 44a:	f7 f1                	div    %ecx
 44c:	89 d0                	mov    %edx,%eax
 44e:	0f b6 90 58 0b 00 00 	movzbl 0xb58(%eax),%edx
 455:	8d 45 dc             	lea    -0x24(%ebp),%eax
 458:	03 45 f4             	add    -0xc(%ebp),%eax
 45b:	88 10                	mov    %dl,(%eax)
 45d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  }while((x /= base) != 0);
 461:	8b 55 10             	mov    0x10(%ebp),%edx
 464:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 467:	8b 45 ec             	mov    -0x14(%ebp),%eax
 46a:	ba 00 00 00 00       	mov    $0x0,%edx
 46f:	f7 75 d4             	divl   -0x2c(%ebp)
 472:	89 45 ec             	mov    %eax,-0x14(%ebp)
 475:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 479:	75 c4                	jne    43f <printint+0x37>
  if(neg)
 47b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 47f:	74 2a                	je     4ab <printint+0xa3>
    buf[i++] = '-';
 481:	8d 45 dc             	lea    -0x24(%ebp),%eax
 484:	03 45 f4             	add    -0xc(%ebp),%eax
 487:	c6 00 2d             	movb   $0x2d,(%eax)
 48a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)

  while(--i >= 0)
 48e:	eb 1b                	jmp    4ab <printint+0xa3>
    putc(fd, buf[i]);
 490:	8d 45 dc             	lea    -0x24(%ebp),%eax
 493:	03 45 f4             	add    -0xc(%ebp),%eax
 496:	0f b6 00             	movzbl (%eax),%eax
 499:	0f be c0             	movsbl %al,%eax
 49c:	89 44 24 04          	mov    %eax,0x4(%esp)
 4a0:	8b 45 08             	mov    0x8(%ebp),%eax
 4a3:	89 04 24             	mov    %eax,(%esp)
 4a6:	e8 35 ff ff ff       	call   3e0 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 4ab:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 4af:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 4b3:	79 db                	jns    490 <printint+0x88>
    putc(fd, buf[i]);
}
 4b5:	c9                   	leave  
 4b6:	c3                   	ret    

000004b7 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 4b7:	55                   	push   %ebp
 4b8:	89 e5                	mov    %esp,%ebp
 4ba:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 4bd:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 4c4:	8d 45 0c             	lea    0xc(%ebp),%eax
 4c7:	83 c0 04             	add    $0x4,%eax
 4ca:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 4cd:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 4d4:	e9 7d 01 00 00       	jmp    656 <printf+0x19f>
    c = fmt[i] & 0xff;
 4d9:	8b 55 0c             	mov    0xc(%ebp),%edx
 4dc:	8b 45 f0             	mov    -0x10(%ebp),%eax
 4df:	01 d0                	add    %edx,%eax
 4e1:	0f b6 00             	movzbl (%eax),%eax
 4e4:	0f be c0             	movsbl %al,%eax
 4e7:	25 ff 00 00 00       	and    $0xff,%eax
 4ec:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 4ef:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 4f3:	75 2c                	jne    521 <printf+0x6a>
      if(c == '%'){
 4f5:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 4f9:	75 0c                	jne    507 <printf+0x50>
        state = '%';
 4fb:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 502:	e9 4b 01 00 00       	jmp    652 <printf+0x19b>
      } else {
        putc(fd, c);
 507:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 50a:	0f be c0             	movsbl %al,%eax
 50d:	89 44 24 04          	mov    %eax,0x4(%esp)
 511:	8b 45 08             	mov    0x8(%ebp),%eax
 514:	89 04 24             	mov    %eax,(%esp)
 517:	e8 c4 fe ff ff       	call   3e0 <putc>
 51c:	e9 31 01 00 00       	jmp    652 <printf+0x19b>
      }
    } else if(state == '%'){
 521:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 525:	0f 85 27 01 00 00    	jne    652 <printf+0x19b>
      if(c == 'd'){
 52b:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 52f:	75 2d                	jne    55e <printf+0xa7>
        printint(fd, *ap, 10, 1);
 531:	8b 45 e8             	mov    -0x18(%ebp),%eax
 534:	8b 00                	mov    (%eax),%eax
 536:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 53d:	00 
 53e:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 545:	00 
 546:	89 44 24 04          	mov    %eax,0x4(%esp)
 54a:	8b 45 08             	mov    0x8(%ebp),%eax
 54d:	89 04 24             	mov    %eax,(%esp)
 550:	e8 b3 fe ff ff       	call   408 <printint>
        ap++;
 555:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 559:	e9 ed 00 00 00       	jmp    64b <printf+0x194>
      } else if(c == 'x' || c == 'p'){
 55e:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 562:	74 06                	je     56a <printf+0xb3>
 564:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 568:	75 2d                	jne    597 <printf+0xe0>
        printint(fd, *ap, 16, 0);
 56a:	8b 45 e8             	mov    -0x18(%ebp),%eax
 56d:	8b 00                	mov    (%eax),%eax
 56f:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 576:	00 
 577:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 57e:	00 
 57f:	89 44 24 04          	mov    %eax,0x4(%esp)
 583:	8b 45 08             	mov    0x8(%ebp),%eax
 586:	89 04 24             	mov    %eax,(%esp)
 589:	e8 7a fe ff ff       	call   408 <printint>
        ap++;
 58e:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 592:	e9 b4 00 00 00       	jmp    64b <printf+0x194>
      } else if(c == 's'){
 597:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 59b:	75 46                	jne    5e3 <printf+0x12c>
        s = (char*)*ap;
 59d:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5a0:	8b 00                	mov    (%eax),%eax
 5a2:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 5a5:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 5a9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 5ad:	75 27                	jne    5d6 <printf+0x11f>
          s = "(null)";
 5af:	c7 45 f4 d2 08 00 00 	movl   $0x8d2,-0xc(%ebp)
        while(*s != 0){
 5b6:	eb 1e                	jmp    5d6 <printf+0x11f>
          putc(fd, *s);
 5b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5bb:	0f b6 00             	movzbl (%eax),%eax
 5be:	0f be c0             	movsbl %al,%eax
 5c1:	89 44 24 04          	mov    %eax,0x4(%esp)
 5c5:	8b 45 08             	mov    0x8(%ebp),%eax
 5c8:	89 04 24             	mov    %eax,(%esp)
 5cb:	e8 10 fe ff ff       	call   3e0 <putc>
          s++;
 5d0:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 5d4:	eb 01                	jmp    5d7 <printf+0x120>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 5d6:	90                   	nop
 5d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5da:	0f b6 00             	movzbl (%eax),%eax
 5dd:	84 c0                	test   %al,%al
 5df:	75 d7                	jne    5b8 <printf+0x101>
 5e1:	eb 68                	jmp    64b <printf+0x194>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5e3:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 5e7:	75 1d                	jne    606 <printf+0x14f>
        putc(fd, *ap);
 5e9:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5ec:	8b 00                	mov    (%eax),%eax
 5ee:	0f be c0             	movsbl %al,%eax
 5f1:	89 44 24 04          	mov    %eax,0x4(%esp)
 5f5:	8b 45 08             	mov    0x8(%ebp),%eax
 5f8:	89 04 24             	mov    %eax,(%esp)
 5fb:	e8 e0 fd ff ff       	call   3e0 <putc>
        ap++;
 600:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 604:	eb 45                	jmp    64b <printf+0x194>
      } else if(c == '%'){
 606:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 60a:	75 17                	jne    623 <printf+0x16c>
        putc(fd, c);
 60c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 60f:	0f be c0             	movsbl %al,%eax
 612:	89 44 24 04          	mov    %eax,0x4(%esp)
 616:	8b 45 08             	mov    0x8(%ebp),%eax
 619:	89 04 24             	mov    %eax,(%esp)
 61c:	e8 bf fd ff ff       	call   3e0 <putc>
 621:	eb 28                	jmp    64b <printf+0x194>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 623:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 62a:	00 
 62b:	8b 45 08             	mov    0x8(%ebp),%eax
 62e:	89 04 24             	mov    %eax,(%esp)
 631:	e8 aa fd ff ff       	call   3e0 <putc>
        putc(fd, c);
 636:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 639:	0f be c0             	movsbl %al,%eax
 63c:	89 44 24 04          	mov    %eax,0x4(%esp)
 640:	8b 45 08             	mov    0x8(%ebp),%eax
 643:	89 04 24             	mov    %eax,(%esp)
 646:	e8 95 fd ff ff       	call   3e0 <putc>
      }
      state = 0;
 64b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 652:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 656:	8b 55 0c             	mov    0xc(%ebp),%edx
 659:	8b 45 f0             	mov    -0x10(%ebp),%eax
 65c:	01 d0                	add    %edx,%eax
 65e:	0f b6 00             	movzbl (%eax),%eax
 661:	84 c0                	test   %al,%al
 663:	0f 85 70 fe ff ff    	jne    4d9 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 669:	c9                   	leave  
 66a:	c3                   	ret    
 66b:	90                   	nop

0000066c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 66c:	55                   	push   %ebp
 66d:	89 e5                	mov    %esp,%ebp
 66f:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 672:	8b 45 08             	mov    0x8(%ebp),%eax
 675:	83 e8 08             	sub    $0x8,%eax
 678:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 67b:	a1 74 0b 00 00       	mov    0xb74,%eax
 680:	89 45 fc             	mov    %eax,-0x4(%ebp)
 683:	eb 24                	jmp    6a9 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 685:	8b 45 fc             	mov    -0x4(%ebp),%eax
 688:	8b 00                	mov    (%eax),%eax
 68a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 68d:	77 12                	ja     6a1 <free+0x35>
 68f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 692:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 695:	77 24                	ja     6bb <free+0x4f>
 697:	8b 45 fc             	mov    -0x4(%ebp),%eax
 69a:	8b 00                	mov    (%eax),%eax
 69c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 69f:	77 1a                	ja     6bb <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6a1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6a4:	8b 00                	mov    (%eax),%eax
 6a6:	89 45 fc             	mov    %eax,-0x4(%ebp)
 6a9:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6ac:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 6af:	76 d4                	jbe    685 <free+0x19>
 6b1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6b4:	8b 00                	mov    (%eax),%eax
 6b6:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6b9:	76 ca                	jbe    685 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 6bb:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6be:	8b 40 04             	mov    0x4(%eax),%eax
 6c1:	c1 e0 03             	shl    $0x3,%eax
 6c4:	89 c2                	mov    %eax,%edx
 6c6:	03 55 f8             	add    -0x8(%ebp),%edx
 6c9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6cc:	8b 00                	mov    (%eax),%eax
 6ce:	39 c2                	cmp    %eax,%edx
 6d0:	75 24                	jne    6f6 <free+0x8a>
    bp->s.size += p->s.ptr->s.size;
 6d2:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6d5:	8b 50 04             	mov    0x4(%eax),%edx
 6d8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6db:	8b 00                	mov    (%eax),%eax
 6dd:	8b 40 04             	mov    0x4(%eax),%eax
 6e0:	01 c2                	add    %eax,%edx
 6e2:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6e5:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 6e8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6eb:	8b 00                	mov    (%eax),%eax
 6ed:	8b 10                	mov    (%eax),%edx
 6ef:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6f2:	89 10                	mov    %edx,(%eax)
 6f4:	eb 0a                	jmp    700 <free+0x94>
  } else
    bp->s.ptr = p->s.ptr;
 6f6:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6f9:	8b 10                	mov    (%eax),%edx
 6fb:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6fe:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 700:	8b 45 fc             	mov    -0x4(%ebp),%eax
 703:	8b 40 04             	mov    0x4(%eax),%eax
 706:	c1 e0 03             	shl    $0x3,%eax
 709:	03 45 fc             	add    -0x4(%ebp),%eax
 70c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 70f:	75 20                	jne    731 <free+0xc5>
    p->s.size += bp->s.size;
 711:	8b 45 fc             	mov    -0x4(%ebp),%eax
 714:	8b 50 04             	mov    0x4(%eax),%edx
 717:	8b 45 f8             	mov    -0x8(%ebp),%eax
 71a:	8b 40 04             	mov    0x4(%eax),%eax
 71d:	01 c2                	add    %eax,%edx
 71f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 722:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 725:	8b 45 f8             	mov    -0x8(%ebp),%eax
 728:	8b 10                	mov    (%eax),%edx
 72a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 72d:	89 10                	mov    %edx,(%eax)
 72f:	eb 08                	jmp    739 <free+0xcd>
  } else
    p->s.ptr = bp;
 731:	8b 45 fc             	mov    -0x4(%ebp),%eax
 734:	8b 55 f8             	mov    -0x8(%ebp),%edx
 737:	89 10                	mov    %edx,(%eax)
  freep = p;
 739:	8b 45 fc             	mov    -0x4(%ebp),%eax
 73c:	a3 74 0b 00 00       	mov    %eax,0xb74
}
 741:	c9                   	leave  
 742:	c3                   	ret    

00000743 <morecore>:

static Header*
morecore(uint nu)
{
 743:	55                   	push   %ebp
 744:	89 e5                	mov    %esp,%ebp
 746:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 749:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 750:	77 07                	ja     759 <morecore+0x16>
    nu = 4096;
 752:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 759:	8b 45 08             	mov    0x8(%ebp),%eax
 75c:	c1 e0 03             	shl    $0x3,%eax
 75f:	89 04 24             	mov    %eax,(%esp)
 762:	e8 51 fc ff ff       	call   3b8 <sbrk>
 767:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 76a:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 76e:	75 07                	jne    777 <morecore+0x34>
    return 0;
 770:	b8 00 00 00 00       	mov    $0x0,%eax
 775:	eb 22                	jmp    799 <morecore+0x56>
  hp = (Header*)p;
 777:	8b 45 f4             	mov    -0xc(%ebp),%eax
 77a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 77d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 780:	8b 55 08             	mov    0x8(%ebp),%edx
 783:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 786:	8b 45 f0             	mov    -0x10(%ebp),%eax
 789:	83 c0 08             	add    $0x8,%eax
 78c:	89 04 24             	mov    %eax,(%esp)
 78f:	e8 d8 fe ff ff       	call   66c <free>
  return freep;
 794:	a1 74 0b 00 00       	mov    0xb74,%eax
}
 799:	c9                   	leave  
 79a:	c3                   	ret    

0000079b <malloc>:

void*
malloc(uint nbytes)
{
 79b:	55                   	push   %ebp
 79c:	89 e5                	mov    %esp,%ebp
 79e:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7a1:	8b 45 08             	mov    0x8(%ebp),%eax
 7a4:	83 c0 07             	add    $0x7,%eax
 7a7:	c1 e8 03             	shr    $0x3,%eax
 7aa:	83 c0 01             	add    $0x1,%eax
 7ad:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 7b0:	a1 74 0b 00 00       	mov    0xb74,%eax
 7b5:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7b8:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 7bc:	75 23                	jne    7e1 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 7be:	c7 45 f0 6c 0b 00 00 	movl   $0xb6c,-0x10(%ebp)
 7c5:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7c8:	a3 74 0b 00 00       	mov    %eax,0xb74
 7cd:	a1 74 0b 00 00       	mov    0xb74,%eax
 7d2:	a3 6c 0b 00 00       	mov    %eax,0xb6c
    base.s.size = 0;
 7d7:	c7 05 70 0b 00 00 00 	movl   $0x0,0xb70
 7de:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7e1:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7e4:	8b 00                	mov    (%eax),%eax
 7e6:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 7e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7ec:	8b 40 04             	mov    0x4(%eax),%eax
 7ef:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 7f2:	72 4d                	jb     841 <malloc+0xa6>
      if(p->s.size == nunits)
 7f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7f7:	8b 40 04             	mov    0x4(%eax),%eax
 7fa:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 7fd:	75 0c                	jne    80b <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 7ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
 802:	8b 10                	mov    (%eax),%edx
 804:	8b 45 f0             	mov    -0x10(%ebp),%eax
 807:	89 10                	mov    %edx,(%eax)
 809:	eb 26                	jmp    831 <malloc+0x96>
      else {
        p->s.size -= nunits;
 80b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 80e:	8b 40 04             	mov    0x4(%eax),%eax
 811:	89 c2                	mov    %eax,%edx
 813:	2b 55 ec             	sub    -0x14(%ebp),%edx
 816:	8b 45 f4             	mov    -0xc(%ebp),%eax
 819:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 81c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 81f:	8b 40 04             	mov    0x4(%eax),%eax
 822:	c1 e0 03             	shl    $0x3,%eax
 825:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 828:	8b 45 f4             	mov    -0xc(%ebp),%eax
 82b:	8b 55 ec             	mov    -0x14(%ebp),%edx
 82e:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 831:	8b 45 f0             	mov    -0x10(%ebp),%eax
 834:	a3 74 0b 00 00       	mov    %eax,0xb74
      return (void*)(p + 1);
 839:	8b 45 f4             	mov    -0xc(%ebp),%eax
 83c:	83 c0 08             	add    $0x8,%eax
 83f:	eb 38                	jmp    879 <malloc+0xde>
    }
    if(p == freep)
 841:	a1 74 0b 00 00       	mov    0xb74,%eax
 846:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 849:	75 1b                	jne    866 <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 84b:	8b 45 ec             	mov    -0x14(%ebp),%eax
 84e:	89 04 24             	mov    %eax,(%esp)
 851:	e8 ed fe ff ff       	call   743 <morecore>
 856:	89 45 f4             	mov    %eax,-0xc(%ebp)
 859:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 85d:	75 07                	jne    866 <malloc+0xcb>
        return 0;
 85f:	b8 00 00 00 00       	mov    $0x0,%eax
 864:	eb 13                	jmp    879 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 866:	8b 45 f4             	mov    -0xc(%ebp),%eax
 869:	89 45 f0             	mov    %eax,-0x10(%ebp)
 86c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 86f:	8b 00                	mov    (%eax),%eax
 871:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 874:	e9 70 ff ff ff       	jmp    7e9 <malloc+0x4e>
}
 879:	c9                   	leave  
 87a:	c3                   	ret    
