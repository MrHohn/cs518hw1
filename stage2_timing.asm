
_stage2_timing:     file format elf32-i386


Disassembly of section .text:

00000000 <handle_signal>:
#include "user.h"
#include "signal.h"
static int count = 100000;

void handle_signal(int signum)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
	// printf(1, "inside self handler\n");
	// printf(1, "modify the return address\n");
	// printf(1, "count = %d\n", count);
	--count;
   3:	a1 64 0b 00 00       	mov    0xb64,%eax
   8:	83 e8 01             	sub    $0x1,%eax
   b:	a3 64 0b 00 00       	mov    %eax,0xb64
	if(!count)
  10:	a1 64 0b 00 00       	mov    0xb64,%eax
  15:	85 c0                	test   %eax,%eax
  17:	75 07                	jne    20 <handle_signal+0x20>
	{
		__asm__ ("movl $0x72,4(%ebp)\n\t");
  19:	c7 45 04 72 00 00 00 	movl   $0x72,0x4(%ebp)
	}
}
  20:	5d                   	pop    %ebp
  21:	c3                   	ret    

00000022 <main>:


int main(int argc, char *argv[])
{
  22:	55                   	push   %ebp
  23:	89 e5                	mov    %esp,%ebp
  25:	83 e4 f0             	and    $0xfffffff0,%esp
  28:	83 ec 30             	sub    $0x30,%esp
	int x = 5;
  2b:	c7 44 24 2c 05 00 00 	movl   $0x5,0x2c(%esp)
  32:	00 
	int y = 0;
  33:	c7 44 24 28 00 00 00 	movl   $0x0,0x28(%esp)
  3a:	00 
	int begin, end;
	int counts = count;
  3b:	a1 64 0b 00 00       	mov    0xb64,%eax
  40:	89 44 24 24          	mov    %eax,0x24(%esp)

	// printf(1, "anything\n");

	signal(SIGFPE, handle_signal);
  44:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  4b:	00 
  4c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  53:	e8 b0 03 00 00       	call   408 <signal>

	// printf(1, "anything\n");
	
	begin = uptime();
  58:	e8 9b 03 00 00       	call   3f8 <uptime>
  5d:	89 44 24 20          	mov    %eax,0x20(%esp)
	// printf(1, "The clock cycle now is: %d\n", begin);	
	x = x / y;
  61:	8b 44 24 2c          	mov    0x2c(%esp),%eax
  65:	89 c2                	mov    %eax,%edx
  67:	c1 fa 1f             	sar    $0x1f,%edx
  6a:	f7 7c 24 28          	idivl  0x28(%esp)
  6e:	89 44 24 2c          	mov    %eax,0x2c(%esp)
	end = uptime();
  72:	e8 81 03 00 00       	call   3f8 <uptime>
  77:	89 44 24 1c          	mov    %eax,0x1c(%esp)
	//                   = (10 / 2.3) ms
	//                   = (10000 / 2.3) us
	//                   = (10000000 / 2.3) ns
	// printf(1, "The clock cycle now is: %d\n", end);
	// int total = (int)dtotal;
	int total = (end - begin) * 10000;
  7b:	8b 44 24 20          	mov    0x20(%esp),%eax
  7f:	8b 54 24 1c          	mov    0x1c(%esp),%edx
  83:	89 d1                	mov    %edx,%ecx
  85:	29 c1                	sub    %eax,%ecx
  87:	89 c8                	mov    %ecx,%eax
  89:	69 c0 10 27 00 00    	imul   $0x2710,%eax,%eax
  8f:	89 44 24 18          	mov    %eax,0x18(%esp)
	printf(1, "Traps Performed: %d times\n", counts);
  93:	8b 44 24 24          	mov    0x24(%esp),%eax
  97:	89 44 24 08          	mov    %eax,0x8(%esp)
  9b:	c7 44 24 04 ab 08 00 	movl   $0x8ab,0x4(%esp)
  a2:	00 
  a3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  aa:	e8 38 04 00 00       	call   4e7 <printf>
	printf(1, "Total Elapsed Time: %d us\n", total);
  af:	8b 44 24 18          	mov    0x18(%esp),%eax
  b3:	89 44 24 08          	mov    %eax,0x8(%esp)
  b7:	c7 44 24 04 c6 08 00 	movl   $0x8c6,0x4(%esp)
  be:	00 
  bf:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  c6:	e8 1c 04 00 00       	call   4e7 <printf>
	printf(1, "Average Time Per Trap: %d ns\n", total * 1000 / counts);
  cb:	8b 44 24 18          	mov    0x18(%esp),%eax
  cf:	69 c0 e8 03 00 00    	imul   $0x3e8,%eax,%eax
  d5:	89 c2                	mov    %eax,%edx
  d7:	c1 fa 1f             	sar    $0x1f,%edx
  da:	f7 7c 24 24          	idivl  0x24(%esp)
  de:	89 44 24 08          	mov    %eax,0x8(%esp)
  e2:	c7 44 24 04 e1 08 00 	movl   $0x8e1,0x4(%esp)
  e9:	00 
  ea:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  f1:	e8 f1 03 00 00       	call   4e7 <printf>

	exit();
  f6:	e8 65 02 00 00       	call   360 <exit>
  fb:	90                   	nop

000000fc <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  fc:	55                   	push   %ebp
  fd:	89 e5                	mov    %esp,%ebp
  ff:	57                   	push   %edi
 100:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 101:	8b 4d 08             	mov    0x8(%ebp),%ecx
 104:	8b 55 10             	mov    0x10(%ebp),%edx
 107:	8b 45 0c             	mov    0xc(%ebp),%eax
 10a:	89 cb                	mov    %ecx,%ebx
 10c:	89 df                	mov    %ebx,%edi
 10e:	89 d1                	mov    %edx,%ecx
 110:	fc                   	cld    
 111:	f3 aa                	rep stos %al,%es:(%edi)
 113:	89 ca                	mov    %ecx,%edx
 115:	89 fb                	mov    %edi,%ebx
 117:	89 5d 08             	mov    %ebx,0x8(%ebp)
 11a:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 11d:	5b                   	pop    %ebx
 11e:	5f                   	pop    %edi
 11f:	5d                   	pop    %ebp
 120:	c3                   	ret    

00000121 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 121:	55                   	push   %ebp
 122:	89 e5                	mov    %esp,%ebp
 124:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 127:	8b 45 08             	mov    0x8(%ebp),%eax
 12a:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 12d:	90                   	nop
 12e:	8b 45 0c             	mov    0xc(%ebp),%eax
 131:	0f b6 10             	movzbl (%eax),%edx
 134:	8b 45 08             	mov    0x8(%ebp),%eax
 137:	88 10                	mov    %dl,(%eax)
 139:	8b 45 08             	mov    0x8(%ebp),%eax
 13c:	0f b6 00             	movzbl (%eax),%eax
 13f:	84 c0                	test   %al,%al
 141:	0f 95 c0             	setne  %al
 144:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 148:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
 14c:	84 c0                	test   %al,%al
 14e:	75 de                	jne    12e <strcpy+0xd>
    ;
  return os;
 150:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 153:	c9                   	leave  
 154:	c3                   	ret    

00000155 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 155:	55                   	push   %ebp
 156:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 158:	eb 08                	jmp    162 <strcmp+0xd>
    p++, q++;
 15a:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 15e:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 162:	8b 45 08             	mov    0x8(%ebp),%eax
 165:	0f b6 00             	movzbl (%eax),%eax
 168:	84 c0                	test   %al,%al
 16a:	74 10                	je     17c <strcmp+0x27>
 16c:	8b 45 08             	mov    0x8(%ebp),%eax
 16f:	0f b6 10             	movzbl (%eax),%edx
 172:	8b 45 0c             	mov    0xc(%ebp),%eax
 175:	0f b6 00             	movzbl (%eax),%eax
 178:	38 c2                	cmp    %al,%dl
 17a:	74 de                	je     15a <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 17c:	8b 45 08             	mov    0x8(%ebp),%eax
 17f:	0f b6 00             	movzbl (%eax),%eax
 182:	0f b6 d0             	movzbl %al,%edx
 185:	8b 45 0c             	mov    0xc(%ebp),%eax
 188:	0f b6 00             	movzbl (%eax),%eax
 18b:	0f b6 c0             	movzbl %al,%eax
 18e:	89 d1                	mov    %edx,%ecx
 190:	29 c1                	sub    %eax,%ecx
 192:	89 c8                	mov    %ecx,%eax
}
 194:	5d                   	pop    %ebp
 195:	c3                   	ret    

00000196 <strlen>:

uint
strlen(char *s)
{
 196:	55                   	push   %ebp
 197:	89 e5                	mov    %esp,%ebp
 199:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 19c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 1a3:	eb 04                	jmp    1a9 <strlen+0x13>
 1a5:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 1a9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 1ac:	03 45 08             	add    0x8(%ebp),%eax
 1af:	0f b6 00             	movzbl (%eax),%eax
 1b2:	84 c0                	test   %al,%al
 1b4:	75 ef                	jne    1a5 <strlen+0xf>
    ;
  return n;
 1b6:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 1b9:	c9                   	leave  
 1ba:	c3                   	ret    

000001bb <memset>:

void*
memset(void *dst, int c, uint n)
{
 1bb:	55                   	push   %ebp
 1bc:	89 e5                	mov    %esp,%ebp
 1be:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
 1c1:	8b 45 10             	mov    0x10(%ebp),%eax
 1c4:	89 44 24 08          	mov    %eax,0x8(%esp)
 1c8:	8b 45 0c             	mov    0xc(%ebp),%eax
 1cb:	89 44 24 04          	mov    %eax,0x4(%esp)
 1cf:	8b 45 08             	mov    0x8(%ebp),%eax
 1d2:	89 04 24             	mov    %eax,(%esp)
 1d5:	e8 22 ff ff ff       	call   fc <stosb>
  return dst;
 1da:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1dd:	c9                   	leave  
 1de:	c3                   	ret    

000001df <strchr>:

char*
strchr(const char *s, char c)
{
 1df:	55                   	push   %ebp
 1e0:	89 e5                	mov    %esp,%ebp
 1e2:	83 ec 04             	sub    $0x4,%esp
 1e5:	8b 45 0c             	mov    0xc(%ebp),%eax
 1e8:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 1eb:	eb 14                	jmp    201 <strchr+0x22>
    if(*s == c)
 1ed:	8b 45 08             	mov    0x8(%ebp),%eax
 1f0:	0f b6 00             	movzbl (%eax),%eax
 1f3:	3a 45 fc             	cmp    -0x4(%ebp),%al
 1f6:	75 05                	jne    1fd <strchr+0x1e>
      return (char*)s;
 1f8:	8b 45 08             	mov    0x8(%ebp),%eax
 1fb:	eb 13                	jmp    210 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 1fd:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 201:	8b 45 08             	mov    0x8(%ebp),%eax
 204:	0f b6 00             	movzbl (%eax),%eax
 207:	84 c0                	test   %al,%al
 209:	75 e2                	jne    1ed <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 20b:	b8 00 00 00 00       	mov    $0x0,%eax
}
 210:	c9                   	leave  
 211:	c3                   	ret    

00000212 <gets>:

char*
gets(char *buf, int max)
{
 212:	55                   	push   %ebp
 213:	89 e5                	mov    %esp,%ebp
 215:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 218:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 21f:	eb 44                	jmp    265 <gets+0x53>
    cc = read(0, &c, 1);
 221:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 228:	00 
 229:	8d 45 ef             	lea    -0x11(%ebp),%eax
 22c:	89 44 24 04          	mov    %eax,0x4(%esp)
 230:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 237:	e8 3c 01 00 00       	call   378 <read>
 23c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 23f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 243:	7e 2d                	jle    272 <gets+0x60>
      break;
    buf[i++] = c;
 245:	8b 45 f4             	mov    -0xc(%ebp),%eax
 248:	03 45 08             	add    0x8(%ebp),%eax
 24b:	0f b6 55 ef          	movzbl -0x11(%ebp),%edx
 24f:	88 10                	mov    %dl,(%eax)
 251:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(c == '\n' || c == '\r')
 255:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 259:	3c 0a                	cmp    $0xa,%al
 25b:	74 16                	je     273 <gets+0x61>
 25d:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 261:	3c 0d                	cmp    $0xd,%al
 263:	74 0e                	je     273 <gets+0x61>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 265:	8b 45 f4             	mov    -0xc(%ebp),%eax
 268:	83 c0 01             	add    $0x1,%eax
 26b:	3b 45 0c             	cmp    0xc(%ebp),%eax
 26e:	7c b1                	jl     221 <gets+0xf>
 270:	eb 01                	jmp    273 <gets+0x61>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 272:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 273:	8b 45 f4             	mov    -0xc(%ebp),%eax
 276:	03 45 08             	add    0x8(%ebp),%eax
 279:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 27c:	8b 45 08             	mov    0x8(%ebp),%eax
}
 27f:	c9                   	leave  
 280:	c3                   	ret    

00000281 <stat>:

int
stat(char *n, struct stat *st)
{
 281:	55                   	push   %ebp
 282:	89 e5                	mov    %esp,%ebp
 284:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 287:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 28e:	00 
 28f:	8b 45 08             	mov    0x8(%ebp),%eax
 292:	89 04 24             	mov    %eax,(%esp)
 295:	e8 06 01 00 00       	call   3a0 <open>
 29a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 29d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 2a1:	79 07                	jns    2aa <stat+0x29>
    return -1;
 2a3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 2a8:	eb 23                	jmp    2cd <stat+0x4c>
  r = fstat(fd, st);
 2aa:	8b 45 0c             	mov    0xc(%ebp),%eax
 2ad:	89 44 24 04          	mov    %eax,0x4(%esp)
 2b1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 2b4:	89 04 24             	mov    %eax,(%esp)
 2b7:	e8 fc 00 00 00       	call   3b8 <fstat>
 2bc:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 2bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
 2c2:	89 04 24             	mov    %eax,(%esp)
 2c5:	e8 be 00 00 00       	call   388 <close>
  return r;
 2ca:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 2cd:	c9                   	leave  
 2ce:	c3                   	ret    

000002cf <atoi>:

int
atoi(const char *s)
{
 2cf:	55                   	push   %ebp
 2d0:	89 e5                	mov    %esp,%ebp
 2d2:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 2d5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 2dc:	eb 23                	jmp    301 <atoi+0x32>
    n = n*10 + *s++ - '0';
 2de:	8b 55 fc             	mov    -0x4(%ebp),%edx
 2e1:	89 d0                	mov    %edx,%eax
 2e3:	c1 e0 02             	shl    $0x2,%eax
 2e6:	01 d0                	add    %edx,%eax
 2e8:	01 c0                	add    %eax,%eax
 2ea:	89 c2                	mov    %eax,%edx
 2ec:	8b 45 08             	mov    0x8(%ebp),%eax
 2ef:	0f b6 00             	movzbl (%eax),%eax
 2f2:	0f be c0             	movsbl %al,%eax
 2f5:	01 d0                	add    %edx,%eax
 2f7:	83 e8 30             	sub    $0x30,%eax
 2fa:	89 45 fc             	mov    %eax,-0x4(%ebp)
 2fd:	83 45 08 01          	addl   $0x1,0x8(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 301:	8b 45 08             	mov    0x8(%ebp),%eax
 304:	0f b6 00             	movzbl (%eax),%eax
 307:	3c 2f                	cmp    $0x2f,%al
 309:	7e 0a                	jle    315 <atoi+0x46>
 30b:	8b 45 08             	mov    0x8(%ebp),%eax
 30e:	0f b6 00             	movzbl (%eax),%eax
 311:	3c 39                	cmp    $0x39,%al
 313:	7e c9                	jle    2de <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 315:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 318:	c9                   	leave  
 319:	c3                   	ret    

0000031a <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 31a:	55                   	push   %ebp
 31b:	89 e5                	mov    %esp,%ebp
 31d:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 320:	8b 45 08             	mov    0x8(%ebp),%eax
 323:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 326:	8b 45 0c             	mov    0xc(%ebp),%eax
 329:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 32c:	eb 13                	jmp    341 <memmove+0x27>
    *dst++ = *src++;
 32e:	8b 45 f8             	mov    -0x8(%ebp),%eax
 331:	0f b6 10             	movzbl (%eax),%edx
 334:	8b 45 fc             	mov    -0x4(%ebp),%eax
 337:	88 10                	mov    %dl,(%eax)
 339:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 33d:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 341:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
 345:	0f 9f c0             	setg   %al
 348:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
 34c:	84 c0                	test   %al,%al
 34e:	75 de                	jne    32e <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 350:	8b 45 08             	mov    0x8(%ebp),%eax
}
 353:	c9                   	leave  
 354:	c3                   	ret    
 355:	90                   	nop
 356:	90                   	nop
 357:	90                   	nop

00000358 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 358:	b8 01 00 00 00       	mov    $0x1,%eax
 35d:	cd 40                	int    $0x40
 35f:	c3                   	ret    

00000360 <exit>:
SYSCALL(exit)
 360:	b8 02 00 00 00       	mov    $0x2,%eax
 365:	cd 40                	int    $0x40
 367:	c3                   	ret    

00000368 <wait>:
SYSCALL(wait)
 368:	b8 03 00 00 00       	mov    $0x3,%eax
 36d:	cd 40                	int    $0x40
 36f:	c3                   	ret    

00000370 <pipe>:
SYSCALL(pipe)
 370:	b8 04 00 00 00       	mov    $0x4,%eax
 375:	cd 40                	int    $0x40
 377:	c3                   	ret    

00000378 <read>:
SYSCALL(read)
 378:	b8 05 00 00 00       	mov    $0x5,%eax
 37d:	cd 40                	int    $0x40
 37f:	c3                   	ret    

00000380 <write>:
SYSCALL(write)
 380:	b8 10 00 00 00       	mov    $0x10,%eax
 385:	cd 40                	int    $0x40
 387:	c3                   	ret    

00000388 <close>:
SYSCALL(close)
 388:	b8 15 00 00 00       	mov    $0x15,%eax
 38d:	cd 40                	int    $0x40
 38f:	c3                   	ret    

00000390 <kill>:
SYSCALL(kill)
 390:	b8 06 00 00 00       	mov    $0x6,%eax
 395:	cd 40                	int    $0x40
 397:	c3                   	ret    

00000398 <exec>:
SYSCALL(exec)
 398:	b8 07 00 00 00       	mov    $0x7,%eax
 39d:	cd 40                	int    $0x40
 39f:	c3                   	ret    

000003a0 <open>:
SYSCALL(open)
 3a0:	b8 0f 00 00 00       	mov    $0xf,%eax
 3a5:	cd 40                	int    $0x40
 3a7:	c3                   	ret    

000003a8 <mknod>:
SYSCALL(mknod)
 3a8:	b8 11 00 00 00       	mov    $0x11,%eax
 3ad:	cd 40                	int    $0x40
 3af:	c3                   	ret    

000003b0 <unlink>:
SYSCALL(unlink)
 3b0:	b8 12 00 00 00       	mov    $0x12,%eax
 3b5:	cd 40                	int    $0x40
 3b7:	c3                   	ret    

000003b8 <fstat>:
SYSCALL(fstat)
 3b8:	b8 08 00 00 00       	mov    $0x8,%eax
 3bd:	cd 40                	int    $0x40
 3bf:	c3                   	ret    

000003c0 <link>:
SYSCALL(link)
 3c0:	b8 13 00 00 00       	mov    $0x13,%eax
 3c5:	cd 40                	int    $0x40
 3c7:	c3                   	ret    

000003c8 <mkdir>:
SYSCALL(mkdir)
 3c8:	b8 14 00 00 00       	mov    $0x14,%eax
 3cd:	cd 40                	int    $0x40
 3cf:	c3                   	ret    

000003d0 <chdir>:
SYSCALL(chdir)
 3d0:	b8 09 00 00 00       	mov    $0x9,%eax
 3d5:	cd 40                	int    $0x40
 3d7:	c3                   	ret    

000003d8 <dup>:
SYSCALL(dup)
 3d8:	b8 0a 00 00 00       	mov    $0xa,%eax
 3dd:	cd 40                	int    $0x40
 3df:	c3                   	ret    

000003e0 <getpid>:
SYSCALL(getpid)
 3e0:	b8 0b 00 00 00       	mov    $0xb,%eax
 3e5:	cd 40                	int    $0x40
 3e7:	c3                   	ret    

000003e8 <sbrk>:
SYSCALL(sbrk)
 3e8:	b8 0c 00 00 00       	mov    $0xc,%eax
 3ed:	cd 40                	int    $0x40
 3ef:	c3                   	ret    

000003f0 <sleep>:
SYSCALL(sleep)
 3f0:	b8 0d 00 00 00       	mov    $0xd,%eax
 3f5:	cd 40                	int    $0x40
 3f7:	c3                   	ret    

000003f8 <uptime>:
SYSCALL(uptime)
 3f8:	b8 0e 00 00 00       	mov    $0xe,%eax
 3fd:	cd 40                	int    $0x40
 3ff:	c3                   	ret    

00000400 <halt>:
SYSCALL(halt)
 400:	b8 16 00 00 00       	mov    $0x16,%eax
 405:	cd 40                	int    $0x40
 407:	c3                   	ret    

00000408 <signal>:
 408:	b8 17 00 00 00       	mov    $0x17,%eax
 40d:	cd 40                	int    $0x40
 40f:	c3                   	ret    

00000410 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 410:	55                   	push   %ebp
 411:	89 e5                	mov    %esp,%ebp
 413:	83 ec 28             	sub    $0x28,%esp
 416:	8b 45 0c             	mov    0xc(%ebp),%eax
 419:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 41c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 423:	00 
 424:	8d 45 f4             	lea    -0xc(%ebp),%eax
 427:	89 44 24 04          	mov    %eax,0x4(%esp)
 42b:	8b 45 08             	mov    0x8(%ebp),%eax
 42e:	89 04 24             	mov    %eax,(%esp)
 431:	e8 4a ff ff ff       	call   380 <write>
}
 436:	c9                   	leave  
 437:	c3                   	ret    

00000438 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 438:	55                   	push   %ebp
 439:	89 e5                	mov    %esp,%ebp
 43b:	83 ec 48             	sub    $0x48,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 43e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 445:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 449:	74 17                	je     462 <printint+0x2a>
 44b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 44f:	79 11                	jns    462 <printint+0x2a>
    neg = 1;
 451:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 458:	8b 45 0c             	mov    0xc(%ebp),%eax
 45b:	f7 d8                	neg    %eax
 45d:	89 45 ec             	mov    %eax,-0x14(%ebp)
 460:	eb 06                	jmp    468 <printint+0x30>
  } else {
    x = xx;
 462:	8b 45 0c             	mov    0xc(%ebp),%eax
 465:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 468:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 46f:	8b 4d 10             	mov    0x10(%ebp),%ecx
 472:	8b 45 ec             	mov    -0x14(%ebp),%eax
 475:	ba 00 00 00 00       	mov    $0x0,%edx
 47a:	f7 f1                	div    %ecx
 47c:	89 d0                	mov    %edx,%eax
 47e:	0f b6 90 68 0b 00 00 	movzbl 0xb68(%eax),%edx
 485:	8d 45 dc             	lea    -0x24(%ebp),%eax
 488:	03 45 f4             	add    -0xc(%ebp),%eax
 48b:	88 10                	mov    %dl,(%eax)
 48d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  }while((x /= base) != 0);
 491:	8b 55 10             	mov    0x10(%ebp),%edx
 494:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 497:	8b 45 ec             	mov    -0x14(%ebp),%eax
 49a:	ba 00 00 00 00       	mov    $0x0,%edx
 49f:	f7 75 d4             	divl   -0x2c(%ebp)
 4a2:	89 45 ec             	mov    %eax,-0x14(%ebp)
 4a5:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 4a9:	75 c4                	jne    46f <printint+0x37>
  if(neg)
 4ab:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 4af:	74 2a                	je     4db <printint+0xa3>
    buf[i++] = '-';
 4b1:	8d 45 dc             	lea    -0x24(%ebp),%eax
 4b4:	03 45 f4             	add    -0xc(%ebp),%eax
 4b7:	c6 00 2d             	movb   $0x2d,(%eax)
 4ba:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)

  while(--i >= 0)
 4be:	eb 1b                	jmp    4db <printint+0xa3>
    putc(fd, buf[i]);
 4c0:	8d 45 dc             	lea    -0x24(%ebp),%eax
 4c3:	03 45 f4             	add    -0xc(%ebp),%eax
 4c6:	0f b6 00             	movzbl (%eax),%eax
 4c9:	0f be c0             	movsbl %al,%eax
 4cc:	89 44 24 04          	mov    %eax,0x4(%esp)
 4d0:	8b 45 08             	mov    0x8(%ebp),%eax
 4d3:	89 04 24             	mov    %eax,(%esp)
 4d6:	e8 35 ff ff ff       	call   410 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 4db:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 4df:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 4e3:	79 db                	jns    4c0 <printint+0x88>
    putc(fd, buf[i]);
}
 4e5:	c9                   	leave  
 4e6:	c3                   	ret    

000004e7 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 4e7:	55                   	push   %ebp
 4e8:	89 e5                	mov    %esp,%ebp
 4ea:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 4ed:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 4f4:	8d 45 0c             	lea    0xc(%ebp),%eax
 4f7:	83 c0 04             	add    $0x4,%eax
 4fa:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 4fd:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 504:	e9 7d 01 00 00       	jmp    686 <printf+0x19f>
    c = fmt[i] & 0xff;
 509:	8b 55 0c             	mov    0xc(%ebp),%edx
 50c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 50f:	01 d0                	add    %edx,%eax
 511:	0f b6 00             	movzbl (%eax),%eax
 514:	0f be c0             	movsbl %al,%eax
 517:	25 ff 00 00 00       	and    $0xff,%eax
 51c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 51f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 523:	75 2c                	jne    551 <printf+0x6a>
      if(c == '%'){
 525:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 529:	75 0c                	jne    537 <printf+0x50>
        state = '%';
 52b:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 532:	e9 4b 01 00 00       	jmp    682 <printf+0x19b>
      } else {
        putc(fd, c);
 537:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 53a:	0f be c0             	movsbl %al,%eax
 53d:	89 44 24 04          	mov    %eax,0x4(%esp)
 541:	8b 45 08             	mov    0x8(%ebp),%eax
 544:	89 04 24             	mov    %eax,(%esp)
 547:	e8 c4 fe ff ff       	call   410 <putc>
 54c:	e9 31 01 00 00       	jmp    682 <printf+0x19b>
      }
    } else if(state == '%'){
 551:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 555:	0f 85 27 01 00 00    	jne    682 <printf+0x19b>
      if(c == 'd'){
 55b:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 55f:	75 2d                	jne    58e <printf+0xa7>
        printint(fd, *ap, 10, 1);
 561:	8b 45 e8             	mov    -0x18(%ebp),%eax
 564:	8b 00                	mov    (%eax),%eax
 566:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 56d:	00 
 56e:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 575:	00 
 576:	89 44 24 04          	mov    %eax,0x4(%esp)
 57a:	8b 45 08             	mov    0x8(%ebp),%eax
 57d:	89 04 24             	mov    %eax,(%esp)
 580:	e8 b3 fe ff ff       	call   438 <printint>
        ap++;
 585:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 589:	e9 ed 00 00 00       	jmp    67b <printf+0x194>
      } else if(c == 'x' || c == 'p'){
 58e:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 592:	74 06                	je     59a <printf+0xb3>
 594:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 598:	75 2d                	jne    5c7 <printf+0xe0>
        printint(fd, *ap, 16, 0);
 59a:	8b 45 e8             	mov    -0x18(%ebp),%eax
 59d:	8b 00                	mov    (%eax),%eax
 59f:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 5a6:	00 
 5a7:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 5ae:	00 
 5af:	89 44 24 04          	mov    %eax,0x4(%esp)
 5b3:	8b 45 08             	mov    0x8(%ebp),%eax
 5b6:	89 04 24             	mov    %eax,(%esp)
 5b9:	e8 7a fe ff ff       	call   438 <printint>
        ap++;
 5be:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5c2:	e9 b4 00 00 00       	jmp    67b <printf+0x194>
      } else if(c == 's'){
 5c7:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 5cb:	75 46                	jne    613 <printf+0x12c>
        s = (char*)*ap;
 5cd:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5d0:	8b 00                	mov    (%eax),%eax
 5d2:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 5d5:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 5d9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 5dd:	75 27                	jne    606 <printf+0x11f>
          s = "(null)";
 5df:	c7 45 f4 ff 08 00 00 	movl   $0x8ff,-0xc(%ebp)
        while(*s != 0){
 5e6:	eb 1e                	jmp    606 <printf+0x11f>
          putc(fd, *s);
 5e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5eb:	0f b6 00             	movzbl (%eax),%eax
 5ee:	0f be c0             	movsbl %al,%eax
 5f1:	89 44 24 04          	mov    %eax,0x4(%esp)
 5f5:	8b 45 08             	mov    0x8(%ebp),%eax
 5f8:	89 04 24             	mov    %eax,(%esp)
 5fb:	e8 10 fe ff ff       	call   410 <putc>
          s++;
 600:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 604:	eb 01                	jmp    607 <printf+0x120>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 606:	90                   	nop
 607:	8b 45 f4             	mov    -0xc(%ebp),%eax
 60a:	0f b6 00             	movzbl (%eax),%eax
 60d:	84 c0                	test   %al,%al
 60f:	75 d7                	jne    5e8 <printf+0x101>
 611:	eb 68                	jmp    67b <printf+0x194>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 613:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 617:	75 1d                	jne    636 <printf+0x14f>
        putc(fd, *ap);
 619:	8b 45 e8             	mov    -0x18(%ebp),%eax
 61c:	8b 00                	mov    (%eax),%eax
 61e:	0f be c0             	movsbl %al,%eax
 621:	89 44 24 04          	mov    %eax,0x4(%esp)
 625:	8b 45 08             	mov    0x8(%ebp),%eax
 628:	89 04 24             	mov    %eax,(%esp)
 62b:	e8 e0 fd ff ff       	call   410 <putc>
        ap++;
 630:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 634:	eb 45                	jmp    67b <printf+0x194>
      } else if(c == '%'){
 636:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 63a:	75 17                	jne    653 <printf+0x16c>
        putc(fd, c);
 63c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 63f:	0f be c0             	movsbl %al,%eax
 642:	89 44 24 04          	mov    %eax,0x4(%esp)
 646:	8b 45 08             	mov    0x8(%ebp),%eax
 649:	89 04 24             	mov    %eax,(%esp)
 64c:	e8 bf fd ff ff       	call   410 <putc>
 651:	eb 28                	jmp    67b <printf+0x194>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 653:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 65a:	00 
 65b:	8b 45 08             	mov    0x8(%ebp),%eax
 65e:	89 04 24             	mov    %eax,(%esp)
 661:	e8 aa fd ff ff       	call   410 <putc>
        putc(fd, c);
 666:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 669:	0f be c0             	movsbl %al,%eax
 66c:	89 44 24 04          	mov    %eax,0x4(%esp)
 670:	8b 45 08             	mov    0x8(%ebp),%eax
 673:	89 04 24             	mov    %eax,(%esp)
 676:	e8 95 fd ff ff       	call   410 <putc>
      }
      state = 0;
 67b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 682:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 686:	8b 55 0c             	mov    0xc(%ebp),%edx
 689:	8b 45 f0             	mov    -0x10(%ebp),%eax
 68c:	01 d0                	add    %edx,%eax
 68e:	0f b6 00             	movzbl (%eax),%eax
 691:	84 c0                	test   %al,%al
 693:	0f 85 70 fe ff ff    	jne    509 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 699:	c9                   	leave  
 69a:	c3                   	ret    
 69b:	90                   	nop

0000069c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 69c:	55                   	push   %ebp
 69d:	89 e5                	mov    %esp,%ebp
 69f:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 6a2:	8b 45 08             	mov    0x8(%ebp),%eax
 6a5:	83 e8 08             	sub    $0x8,%eax
 6a8:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6ab:	a1 84 0b 00 00       	mov    0xb84,%eax
 6b0:	89 45 fc             	mov    %eax,-0x4(%ebp)
 6b3:	eb 24                	jmp    6d9 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6b5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6b8:	8b 00                	mov    (%eax),%eax
 6ba:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 6bd:	77 12                	ja     6d1 <free+0x35>
 6bf:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6c2:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 6c5:	77 24                	ja     6eb <free+0x4f>
 6c7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ca:	8b 00                	mov    (%eax),%eax
 6cc:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6cf:	77 1a                	ja     6eb <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6d1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6d4:	8b 00                	mov    (%eax),%eax
 6d6:	89 45 fc             	mov    %eax,-0x4(%ebp)
 6d9:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6dc:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 6df:	76 d4                	jbe    6b5 <free+0x19>
 6e1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6e4:	8b 00                	mov    (%eax),%eax
 6e6:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6e9:	76 ca                	jbe    6b5 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 6eb:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6ee:	8b 40 04             	mov    0x4(%eax),%eax
 6f1:	c1 e0 03             	shl    $0x3,%eax
 6f4:	89 c2                	mov    %eax,%edx
 6f6:	03 55 f8             	add    -0x8(%ebp),%edx
 6f9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6fc:	8b 00                	mov    (%eax),%eax
 6fe:	39 c2                	cmp    %eax,%edx
 700:	75 24                	jne    726 <free+0x8a>
    bp->s.size += p->s.ptr->s.size;
 702:	8b 45 f8             	mov    -0x8(%ebp),%eax
 705:	8b 50 04             	mov    0x4(%eax),%edx
 708:	8b 45 fc             	mov    -0x4(%ebp),%eax
 70b:	8b 00                	mov    (%eax),%eax
 70d:	8b 40 04             	mov    0x4(%eax),%eax
 710:	01 c2                	add    %eax,%edx
 712:	8b 45 f8             	mov    -0x8(%ebp),%eax
 715:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 718:	8b 45 fc             	mov    -0x4(%ebp),%eax
 71b:	8b 00                	mov    (%eax),%eax
 71d:	8b 10                	mov    (%eax),%edx
 71f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 722:	89 10                	mov    %edx,(%eax)
 724:	eb 0a                	jmp    730 <free+0x94>
  } else
    bp->s.ptr = p->s.ptr;
 726:	8b 45 fc             	mov    -0x4(%ebp),%eax
 729:	8b 10                	mov    (%eax),%edx
 72b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 72e:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 730:	8b 45 fc             	mov    -0x4(%ebp),%eax
 733:	8b 40 04             	mov    0x4(%eax),%eax
 736:	c1 e0 03             	shl    $0x3,%eax
 739:	03 45 fc             	add    -0x4(%ebp),%eax
 73c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 73f:	75 20                	jne    761 <free+0xc5>
    p->s.size += bp->s.size;
 741:	8b 45 fc             	mov    -0x4(%ebp),%eax
 744:	8b 50 04             	mov    0x4(%eax),%edx
 747:	8b 45 f8             	mov    -0x8(%ebp),%eax
 74a:	8b 40 04             	mov    0x4(%eax),%eax
 74d:	01 c2                	add    %eax,%edx
 74f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 752:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 755:	8b 45 f8             	mov    -0x8(%ebp),%eax
 758:	8b 10                	mov    (%eax),%edx
 75a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 75d:	89 10                	mov    %edx,(%eax)
 75f:	eb 08                	jmp    769 <free+0xcd>
  } else
    p->s.ptr = bp;
 761:	8b 45 fc             	mov    -0x4(%ebp),%eax
 764:	8b 55 f8             	mov    -0x8(%ebp),%edx
 767:	89 10                	mov    %edx,(%eax)
  freep = p;
 769:	8b 45 fc             	mov    -0x4(%ebp),%eax
 76c:	a3 84 0b 00 00       	mov    %eax,0xb84
}
 771:	c9                   	leave  
 772:	c3                   	ret    

00000773 <morecore>:

static Header*
morecore(uint nu)
{
 773:	55                   	push   %ebp
 774:	89 e5                	mov    %esp,%ebp
 776:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 779:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 780:	77 07                	ja     789 <morecore+0x16>
    nu = 4096;
 782:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 789:	8b 45 08             	mov    0x8(%ebp),%eax
 78c:	c1 e0 03             	shl    $0x3,%eax
 78f:	89 04 24             	mov    %eax,(%esp)
 792:	e8 51 fc ff ff       	call   3e8 <sbrk>
 797:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 79a:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 79e:	75 07                	jne    7a7 <morecore+0x34>
    return 0;
 7a0:	b8 00 00 00 00       	mov    $0x0,%eax
 7a5:	eb 22                	jmp    7c9 <morecore+0x56>
  hp = (Header*)p;
 7a7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7aa:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 7ad:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7b0:	8b 55 08             	mov    0x8(%ebp),%edx
 7b3:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 7b6:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7b9:	83 c0 08             	add    $0x8,%eax
 7bc:	89 04 24             	mov    %eax,(%esp)
 7bf:	e8 d8 fe ff ff       	call   69c <free>
  return freep;
 7c4:	a1 84 0b 00 00       	mov    0xb84,%eax
}
 7c9:	c9                   	leave  
 7ca:	c3                   	ret    

000007cb <malloc>:

void*
malloc(uint nbytes)
{
 7cb:	55                   	push   %ebp
 7cc:	89 e5                	mov    %esp,%ebp
 7ce:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7d1:	8b 45 08             	mov    0x8(%ebp),%eax
 7d4:	83 c0 07             	add    $0x7,%eax
 7d7:	c1 e8 03             	shr    $0x3,%eax
 7da:	83 c0 01             	add    $0x1,%eax
 7dd:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 7e0:	a1 84 0b 00 00       	mov    0xb84,%eax
 7e5:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7e8:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 7ec:	75 23                	jne    811 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 7ee:	c7 45 f0 7c 0b 00 00 	movl   $0xb7c,-0x10(%ebp)
 7f5:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7f8:	a3 84 0b 00 00       	mov    %eax,0xb84
 7fd:	a1 84 0b 00 00       	mov    0xb84,%eax
 802:	a3 7c 0b 00 00       	mov    %eax,0xb7c
    base.s.size = 0;
 807:	c7 05 80 0b 00 00 00 	movl   $0x0,0xb80
 80e:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 811:	8b 45 f0             	mov    -0x10(%ebp),%eax
 814:	8b 00                	mov    (%eax),%eax
 816:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 819:	8b 45 f4             	mov    -0xc(%ebp),%eax
 81c:	8b 40 04             	mov    0x4(%eax),%eax
 81f:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 822:	72 4d                	jb     871 <malloc+0xa6>
      if(p->s.size == nunits)
 824:	8b 45 f4             	mov    -0xc(%ebp),%eax
 827:	8b 40 04             	mov    0x4(%eax),%eax
 82a:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 82d:	75 0c                	jne    83b <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 82f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 832:	8b 10                	mov    (%eax),%edx
 834:	8b 45 f0             	mov    -0x10(%ebp),%eax
 837:	89 10                	mov    %edx,(%eax)
 839:	eb 26                	jmp    861 <malloc+0x96>
      else {
        p->s.size -= nunits;
 83b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 83e:	8b 40 04             	mov    0x4(%eax),%eax
 841:	89 c2                	mov    %eax,%edx
 843:	2b 55 ec             	sub    -0x14(%ebp),%edx
 846:	8b 45 f4             	mov    -0xc(%ebp),%eax
 849:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 84c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 84f:	8b 40 04             	mov    0x4(%eax),%eax
 852:	c1 e0 03             	shl    $0x3,%eax
 855:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 858:	8b 45 f4             	mov    -0xc(%ebp),%eax
 85b:	8b 55 ec             	mov    -0x14(%ebp),%edx
 85e:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 861:	8b 45 f0             	mov    -0x10(%ebp),%eax
 864:	a3 84 0b 00 00       	mov    %eax,0xb84
      return (void*)(p + 1);
 869:	8b 45 f4             	mov    -0xc(%ebp),%eax
 86c:	83 c0 08             	add    $0x8,%eax
 86f:	eb 38                	jmp    8a9 <malloc+0xde>
    }
    if(p == freep)
 871:	a1 84 0b 00 00       	mov    0xb84,%eax
 876:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 879:	75 1b                	jne    896 <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 87b:	8b 45 ec             	mov    -0x14(%ebp),%eax
 87e:	89 04 24             	mov    %eax,(%esp)
 881:	e8 ed fe ff ff       	call   773 <morecore>
 886:	89 45 f4             	mov    %eax,-0xc(%ebp)
 889:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 88d:	75 07                	jne    896 <malloc+0xcb>
        return 0;
 88f:	b8 00 00 00 00       	mov    $0x0,%eax
 894:	eb 13                	jmp    8a9 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 896:	8b 45 f4             	mov    -0xc(%ebp),%eax
 899:	89 45 f0             	mov    %eax,-0x10(%ebp)
 89c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 89f:	8b 00                	mov    (%eax),%eax
 8a1:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 8a4:	e9 70 ff ff ff       	jmp    819 <malloc+0x4e>
}
 8a9:	c9                   	leave  
 8aa:	c3                   	ret    
