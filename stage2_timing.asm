
_stage2_timing:     file format elf32-i386


Disassembly of section .text:

00000000 <signal>:
#include "user.h"
#include "signal.h"
static int count = 10000;

int signal(int signum, sighandler_t handler)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
	asm
   3:	c7 45 0c 17 00 00 00 	movl   $0x17,0xc(%ebp)
	(
		"movl   $0x17,0x0c(%ebp) \n\t" 

	);

	return 1;
   a:	b8 01 00 00 00       	mov    $0x1,%eax
}
   f:	5d                   	pop    %ebp
  10:	c3                   	ret    

00000011 <handle_signal>:

void handle_signal(int signum)
{
  11:	55                   	push   %ebp
  12:	89 e5                	mov    %esp,%ebp

}
  14:	5d                   	pop    %ebp
  15:	c3                   	ret    

00000016 <main>:

int main(int argc, char *argv[])
{
  16:	55                   	push   %ebp
  17:	89 e5                	mov    %esp,%ebp
  19:	83 e4 f0             	and    $0xfffffff0,%esp
  1c:	83 ec 30             	sub    $0x30,%esp
	int x = 5;
  1f:	c7 44 24 2c 05 00 00 	movl   $0x5,0x2c(%esp)
  26:	00 
	int y = 0;
  27:	c7 44 24 28 00 00 00 	movl   $0x0,0x28(%esp)
  2e:	00 
	int begin, end;
	int counts = count;
  2f:	a1 7c 0b 00 00       	mov    0xb7c,%eax
  34:	89 44 24 24          	mov    %eax,0x24(%esp)

	signal(SIGFPE, handle_signal);
  38:	c7 44 24 04 11 00 00 	movl   $0x11,0x4(%esp)
  3f:	00 
  40:	c7 04 24 17 00 00 00 	movl   $0x17,(%esp)
  47:	e8 b4 ff ff ff       	call   0 <signal>
	begin = uptime();
  4c:	e8 ab 03 00 00       	call   3fc <uptime>
  51:	89 44 24 20          	mov    %eax,0x20(%esp)
	while(count--){
  55:	eb 11                	jmp    68 <main+0x52>
		x = x / y;
  57:	8b 44 24 2c          	mov    0x2c(%esp),%eax
  5b:	89 c2                	mov    %eax,%edx
  5d:	c1 fa 1f             	sar    $0x1f,%edx
  60:	f7 7c 24 28          	idivl  0x28(%esp)
  64:	89 44 24 2c          	mov    %eax,0x2c(%esp)
	int begin, end;
	int counts = count;

	signal(SIGFPE, handle_signal);
	begin = uptime();
	while(count--){
  68:	a1 7c 0b 00 00       	mov    0xb7c,%eax
  6d:	85 c0                	test   %eax,%eax
  6f:	0f 95 c2             	setne  %dl
  72:	83 e8 01             	sub    $0x1,%eax
  75:	a3 7c 0b 00 00       	mov    %eax,0xb7c
  7a:	84 d2                	test   %dl,%dl
  7c:	75 d9                	jne    57 <main+0x41>
		x = x / y;
	}
	end = uptime();
  7e:	e8 79 03 00 00       	call   3fc <uptime>
  83:	89 44 24 1c          	mov    %eax,0x1c(%esp)
	
	printf(1, "Traps Performed: %d\n", counts);
  87:	8b 44 24 24          	mov    0x24(%esp),%eax
  8b:	89 44 24 08          	mov    %eax,0x8(%esp)
  8f:	c7 44 24 04 af 08 00 	movl   $0x8af,0x4(%esp)
  96:	00 
  97:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  9e:	e8 48 04 00 00       	call   4eb <printf>
	printf(1, "Total Elapsed Time: %d\n", end - begin);
  a3:	8b 44 24 20          	mov    0x20(%esp),%eax
  a7:	8b 54 24 1c          	mov    0x1c(%esp),%edx
  ab:	89 d1                	mov    %edx,%ecx
  ad:	29 c1                	sub    %eax,%ecx
  af:	89 c8                	mov    %ecx,%eax
  b1:	89 44 24 08          	mov    %eax,0x8(%esp)
  b5:	c7 44 24 04 c4 08 00 	movl   $0x8c4,0x4(%esp)
  bc:	00 
  bd:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  c4:	e8 22 04 00 00       	call   4eb <printf>
	printf(1, "Average Time Per Trap: %d\n", (end - begin) / counts);
  c9:	8b 44 24 20          	mov    0x20(%esp),%eax
  cd:	8b 54 24 1c          	mov    0x1c(%esp),%edx
  d1:	89 d1                	mov    %edx,%ecx
  d3:	29 c1                	sub    %eax,%ecx
  d5:	89 c8                	mov    %ecx,%eax
  d7:	89 c2                	mov    %eax,%edx
  d9:	c1 fa 1f             	sar    $0x1f,%edx
  dc:	f7 7c 24 24          	idivl  0x24(%esp)
  e0:	89 44 24 08          	mov    %eax,0x8(%esp)
  e4:	c7 44 24 04 dc 08 00 	movl   $0x8dc,0x4(%esp)
  eb:	00 
  ec:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  f3:	e8 f3 03 00 00       	call   4eb <printf>

	exit();
  f8:	e8 67 02 00 00       	call   364 <exit>
  fd:	90                   	nop
  fe:	90                   	nop
  ff:	90                   	nop

00000100 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 100:	55                   	push   %ebp
 101:	89 e5                	mov    %esp,%ebp
 103:	57                   	push   %edi
 104:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 105:	8b 4d 08             	mov    0x8(%ebp),%ecx
 108:	8b 55 10             	mov    0x10(%ebp),%edx
 10b:	8b 45 0c             	mov    0xc(%ebp),%eax
 10e:	89 cb                	mov    %ecx,%ebx
 110:	89 df                	mov    %ebx,%edi
 112:	89 d1                	mov    %edx,%ecx
 114:	fc                   	cld    
 115:	f3 aa                	rep stos %al,%es:(%edi)
 117:	89 ca                	mov    %ecx,%edx
 119:	89 fb                	mov    %edi,%ebx
 11b:	89 5d 08             	mov    %ebx,0x8(%ebp)
 11e:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 121:	5b                   	pop    %ebx
 122:	5f                   	pop    %edi
 123:	5d                   	pop    %ebp
 124:	c3                   	ret    

00000125 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 125:	55                   	push   %ebp
 126:	89 e5                	mov    %esp,%ebp
 128:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 12b:	8b 45 08             	mov    0x8(%ebp),%eax
 12e:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 131:	90                   	nop
 132:	8b 45 0c             	mov    0xc(%ebp),%eax
 135:	0f b6 10             	movzbl (%eax),%edx
 138:	8b 45 08             	mov    0x8(%ebp),%eax
 13b:	88 10                	mov    %dl,(%eax)
 13d:	8b 45 08             	mov    0x8(%ebp),%eax
 140:	0f b6 00             	movzbl (%eax),%eax
 143:	84 c0                	test   %al,%al
 145:	0f 95 c0             	setne  %al
 148:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 14c:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
 150:	84 c0                	test   %al,%al
 152:	75 de                	jne    132 <strcpy+0xd>
    ;
  return os;
 154:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 157:	c9                   	leave  
 158:	c3                   	ret    

00000159 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 159:	55                   	push   %ebp
 15a:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 15c:	eb 08                	jmp    166 <strcmp+0xd>
    p++, q++;
 15e:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 162:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 166:	8b 45 08             	mov    0x8(%ebp),%eax
 169:	0f b6 00             	movzbl (%eax),%eax
 16c:	84 c0                	test   %al,%al
 16e:	74 10                	je     180 <strcmp+0x27>
 170:	8b 45 08             	mov    0x8(%ebp),%eax
 173:	0f b6 10             	movzbl (%eax),%edx
 176:	8b 45 0c             	mov    0xc(%ebp),%eax
 179:	0f b6 00             	movzbl (%eax),%eax
 17c:	38 c2                	cmp    %al,%dl
 17e:	74 de                	je     15e <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 180:	8b 45 08             	mov    0x8(%ebp),%eax
 183:	0f b6 00             	movzbl (%eax),%eax
 186:	0f b6 d0             	movzbl %al,%edx
 189:	8b 45 0c             	mov    0xc(%ebp),%eax
 18c:	0f b6 00             	movzbl (%eax),%eax
 18f:	0f b6 c0             	movzbl %al,%eax
 192:	89 d1                	mov    %edx,%ecx
 194:	29 c1                	sub    %eax,%ecx
 196:	89 c8                	mov    %ecx,%eax
}
 198:	5d                   	pop    %ebp
 199:	c3                   	ret    

0000019a <strlen>:

uint
strlen(char *s)
{
 19a:	55                   	push   %ebp
 19b:	89 e5                	mov    %esp,%ebp
 19d:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 1a0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 1a7:	eb 04                	jmp    1ad <strlen+0x13>
 1a9:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 1ad:	8b 45 fc             	mov    -0x4(%ebp),%eax
 1b0:	03 45 08             	add    0x8(%ebp),%eax
 1b3:	0f b6 00             	movzbl (%eax),%eax
 1b6:	84 c0                	test   %al,%al
 1b8:	75 ef                	jne    1a9 <strlen+0xf>
    ;
  return n;
 1ba:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 1bd:	c9                   	leave  
 1be:	c3                   	ret    

000001bf <memset>:

void*
memset(void *dst, int c, uint n)
{
 1bf:	55                   	push   %ebp
 1c0:	89 e5                	mov    %esp,%ebp
 1c2:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
 1c5:	8b 45 10             	mov    0x10(%ebp),%eax
 1c8:	89 44 24 08          	mov    %eax,0x8(%esp)
 1cc:	8b 45 0c             	mov    0xc(%ebp),%eax
 1cf:	89 44 24 04          	mov    %eax,0x4(%esp)
 1d3:	8b 45 08             	mov    0x8(%ebp),%eax
 1d6:	89 04 24             	mov    %eax,(%esp)
 1d9:	e8 22 ff ff ff       	call   100 <stosb>
  return dst;
 1de:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1e1:	c9                   	leave  
 1e2:	c3                   	ret    

000001e3 <strchr>:

char*
strchr(const char *s, char c)
{
 1e3:	55                   	push   %ebp
 1e4:	89 e5                	mov    %esp,%ebp
 1e6:	83 ec 04             	sub    $0x4,%esp
 1e9:	8b 45 0c             	mov    0xc(%ebp),%eax
 1ec:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 1ef:	eb 14                	jmp    205 <strchr+0x22>
    if(*s == c)
 1f1:	8b 45 08             	mov    0x8(%ebp),%eax
 1f4:	0f b6 00             	movzbl (%eax),%eax
 1f7:	3a 45 fc             	cmp    -0x4(%ebp),%al
 1fa:	75 05                	jne    201 <strchr+0x1e>
      return (char*)s;
 1fc:	8b 45 08             	mov    0x8(%ebp),%eax
 1ff:	eb 13                	jmp    214 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 201:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 205:	8b 45 08             	mov    0x8(%ebp),%eax
 208:	0f b6 00             	movzbl (%eax),%eax
 20b:	84 c0                	test   %al,%al
 20d:	75 e2                	jne    1f1 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 20f:	b8 00 00 00 00       	mov    $0x0,%eax
}
 214:	c9                   	leave  
 215:	c3                   	ret    

00000216 <gets>:

char*
gets(char *buf, int max)
{
 216:	55                   	push   %ebp
 217:	89 e5                	mov    %esp,%ebp
 219:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 21c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 223:	eb 44                	jmp    269 <gets+0x53>
    cc = read(0, &c, 1);
 225:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 22c:	00 
 22d:	8d 45 ef             	lea    -0x11(%ebp),%eax
 230:	89 44 24 04          	mov    %eax,0x4(%esp)
 234:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 23b:	e8 3c 01 00 00       	call   37c <read>
 240:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 243:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 247:	7e 2d                	jle    276 <gets+0x60>
      break;
    buf[i++] = c;
 249:	8b 45 f4             	mov    -0xc(%ebp),%eax
 24c:	03 45 08             	add    0x8(%ebp),%eax
 24f:	0f b6 55 ef          	movzbl -0x11(%ebp),%edx
 253:	88 10                	mov    %dl,(%eax)
 255:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(c == '\n' || c == '\r')
 259:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 25d:	3c 0a                	cmp    $0xa,%al
 25f:	74 16                	je     277 <gets+0x61>
 261:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 265:	3c 0d                	cmp    $0xd,%al
 267:	74 0e                	je     277 <gets+0x61>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 269:	8b 45 f4             	mov    -0xc(%ebp),%eax
 26c:	83 c0 01             	add    $0x1,%eax
 26f:	3b 45 0c             	cmp    0xc(%ebp),%eax
 272:	7c b1                	jl     225 <gets+0xf>
 274:	eb 01                	jmp    277 <gets+0x61>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 276:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 277:	8b 45 f4             	mov    -0xc(%ebp),%eax
 27a:	03 45 08             	add    0x8(%ebp),%eax
 27d:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 280:	8b 45 08             	mov    0x8(%ebp),%eax
}
 283:	c9                   	leave  
 284:	c3                   	ret    

00000285 <stat>:

int
stat(char *n, struct stat *st)
{
 285:	55                   	push   %ebp
 286:	89 e5                	mov    %esp,%ebp
 288:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 28b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 292:	00 
 293:	8b 45 08             	mov    0x8(%ebp),%eax
 296:	89 04 24             	mov    %eax,(%esp)
 299:	e8 06 01 00 00       	call   3a4 <open>
 29e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 2a1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 2a5:	79 07                	jns    2ae <stat+0x29>
    return -1;
 2a7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 2ac:	eb 23                	jmp    2d1 <stat+0x4c>
  r = fstat(fd, st);
 2ae:	8b 45 0c             	mov    0xc(%ebp),%eax
 2b1:	89 44 24 04          	mov    %eax,0x4(%esp)
 2b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 2b8:	89 04 24             	mov    %eax,(%esp)
 2bb:	e8 fc 00 00 00       	call   3bc <fstat>
 2c0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 2c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 2c6:	89 04 24             	mov    %eax,(%esp)
 2c9:	e8 be 00 00 00       	call   38c <close>
  return r;
 2ce:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 2d1:	c9                   	leave  
 2d2:	c3                   	ret    

000002d3 <atoi>:

int
atoi(const char *s)
{
 2d3:	55                   	push   %ebp
 2d4:	89 e5                	mov    %esp,%ebp
 2d6:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 2d9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 2e0:	eb 23                	jmp    305 <atoi+0x32>
    n = n*10 + *s++ - '0';
 2e2:	8b 55 fc             	mov    -0x4(%ebp),%edx
 2e5:	89 d0                	mov    %edx,%eax
 2e7:	c1 e0 02             	shl    $0x2,%eax
 2ea:	01 d0                	add    %edx,%eax
 2ec:	01 c0                	add    %eax,%eax
 2ee:	89 c2                	mov    %eax,%edx
 2f0:	8b 45 08             	mov    0x8(%ebp),%eax
 2f3:	0f b6 00             	movzbl (%eax),%eax
 2f6:	0f be c0             	movsbl %al,%eax
 2f9:	01 d0                	add    %edx,%eax
 2fb:	83 e8 30             	sub    $0x30,%eax
 2fe:	89 45 fc             	mov    %eax,-0x4(%ebp)
 301:	83 45 08 01          	addl   $0x1,0x8(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 305:	8b 45 08             	mov    0x8(%ebp),%eax
 308:	0f b6 00             	movzbl (%eax),%eax
 30b:	3c 2f                	cmp    $0x2f,%al
 30d:	7e 0a                	jle    319 <atoi+0x46>
 30f:	8b 45 08             	mov    0x8(%ebp),%eax
 312:	0f b6 00             	movzbl (%eax),%eax
 315:	3c 39                	cmp    $0x39,%al
 317:	7e c9                	jle    2e2 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 319:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 31c:	c9                   	leave  
 31d:	c3                   	ret    

0000031e <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 31e:	55                   	push   %ebp
 31f:	89 e5                	mov    %esp,%ebp
 321:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 324:	8b 45 08             	mov    0x8(%ebp),%eax
 327:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 32a:	8b 45 0c             	mov    0xc(%ebp),%eax
 32d:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 330:	eb 13                	jmp    345 <memmove+0x27>
    *dst++ = *src++;
 332:	8b 45 f8             	mov    -0x8(%ebp),%eax
 335:	0f b6 10             	movzbl (%eax),%edx
 338:	8b 45 fc             	mov    -0x4(%ebp),%eax
 33b:	88 10                	mov    %dl,(%eax)
 33d:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 341:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 345:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
 349:	0f 9f c0             	setg   %al
 34c:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
 350:	84 c0                	test   %al,%al
 352:	75 de                	jne    332 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 354:	8b 45 08             	mov    0x8(%ebp),%eax
}
 357:	c9                   	leave  
 358:	c3                   	ret    
 359:	90                   	nop
 35a:	90                   	nop
 35b:	90                   	nop

0000035c <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 35c:	b8 01 00 00 00       	mov    $0x1,%eax
 361:	cd 40                	int    $0x40
 363:	c3                   	ret    

00000364 <exit>:
SYSCALL(exit)
 364:	b8 02 00 00 00       	mov    $0x2,%eax
 369:	cd 40                	int    $0x40
 36b:	c3                   	ret    

0000036c <wait>:
SYSCALL(wait)
 36c:	b8 03 00 00 00       	mov    $0x3,%eax
 371:	cd 40                	int    $0x40
 373:	c3                   	ret    

00000374 <pipe>:
SYSCALL(pipe)
 374:	b8 04 00 00 00       	mov    $0x4,%eax
 379:	cd 40                	int    $0x40
 37b:	c3                   	ret    

0000037c <read>:
SYSCALL(read)
 37c:	b8 05 00 00 00       	mov    $0x5,%eax
 381:	cd 40                	int    $0x40
 383:	c3                   	ret    

00000384 <write>:
SYSCALL(write)
 384:	b8 10 00 00 00       	mov    $0x10,%eax
 389:	cd 40                	int    $0x40
 38b:	c3                   	ret    

0000038c <close>:
SYSCALL(close)
 38c:	b8 15 00 00 00       	mov    $0x15,%eax
 391:	cd 40                	int    $0x40
 393:	c3                   	ret    

00000394 <kill>:
SYSCALL(kill)
 394:	b8 06 00 00 00       	mov    $0x6,%eax
 399:	cd 40                	int    $0x40
 39b:	c3                   	ret    

0000039c <exec>:
SYSCALL(exec)
 39c:	b8 07 00 00 00       	mov    $0x7,%eax
 3a1:	cd 40                	int    $0x40
 3a3:	c3                   	ret    

000003a4 <open>:
SYSCALL(open)
 3a4:	b8 0f 00 00 00       	mov    $0xf,%eax
 3a9:	cd 40                	int    $0x40
 3ab:	c3                   	ret    

000003ac <mknod>:
SYSCALL(mknod)
 3ac:	b8 11 00 00 00       	mov    $0x11,%eax
 3b1:	cd 40                	int    $0x40
 3b3:	c3                   	ret    

000003b4 <unlink>:
SYSCALL(unlink)
 3b4:	b8 12 00 00 00       	mov    $0x12,%eax
 3b9:	cd 40                	int    $0x40
 3bb:	c3                   	ret    

000003bc <fstat>:
SYSCALL(fstat)
 3bc:	b8 08 00 00 00       	mov    $0x8,%eax
 3c1:	cd 40                	int    $0x40
 3c3:	c3                   	ret    

000003c4 <link>:
SYSCALL(link)
 3c4:	b8 13 00 00 00       	mov    $0x13,%eax
 3c9:	cd 40                	int    $0x40
 3cb:	c3                   	ret    

000003cc <mkdir>:
SYSCALL(mkdir)
 3cc:	b8 14 00 00 00       	mov    $0x14,%eax
 3d1:	cd 40                	int    $0x40
 3d3:	c3                   	ret    

000003d4 <chdir>:
SYSCALL(chdir)
 3d4:	b8 09 00 00 00       	mov    $0x9,%eax
 3d9:	cd 40                	int    $0x40
 3db:	c3                   	ret    

000003dc <dup>:
SYSCALL(dup)
 3dc:	b8 0a 00 00 00       	mov    $0xa,%eax
 3e1:	cd 40                	int    $0x40
 3e3:	c3                   	ret    

000003e4 <getpid>:
SYSCALL(getpid)
 3e4:	b8 0b 00 00 00       	mov    $0xb,%eax
 3e9:	cd 40                	int    $0x40
 3eb:	c3                   	ret    

000003ec <sbrk>:
SYSCALL(sbrk)
 3ec:	b8 0c 00 00 00       	mov    $0xc,%eax
 3f1:	cd 40                	int    $0x40
 3f3:	c3                   	ret    

000003f4 <sleep>:
SYSCALL(sleep)
 3f4:	b8 0d 00 00 00       	mov    $0xd,%eax
 3f9:	cd 40                	int    $0x40
 3fb:	c3                   	ret    

000003fc <uptime>:
SYSCALL(uptime)
 3fc:	b8 0e 00 00 00       	mov    $0xe,%eax
 401:	cd 40                	int    $0x40
 403:	c3                   	ret    

00000404 <halt>:
SYSCALL(halt)
 404:	b8 16 00 00 00       	mov    $0x16,%eax
 409:	cd 40                	int    $0x40
 40b:	c3                   	ret    

0000040c <regis>:
 40c:	b8 17 00 00 00       	mov    $0x17,%eax
 411:	cd 40                	int    $0x40
 413:	c3                   	ret    

00000414 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 414:	55                   	push   %ebp
 415:	89 e5                	mov    %esp,%ebp
 417:	83 ec 28             	sub    $0x28,%esp
 41a:	8b 45 0c             	mov    0xc(%ebp),%eax
 41d:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 420:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 427:	00 
 428:	8d 45 f4             	lea    -0xc(%ebp),%eax
 42b:	89 44 24 04          	mov    %eax,0x4(%esp)
 42f:	8b 45 08             	mov    0x8(%ebp),%eax
 432:	89 04 24             	mov    %eax,(%esp)
 435:	e8 4a ff ff ff       	call   384 <write>
}
 43a:	c9                   	leave  
 43b:	c3                   	ret    

0000043c <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 43c:	55                   	push   %ebp
 43d:	89 e5                	mov    %esp,%ebp
 43f:	83 ec 48             	sub    $0x48,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 442:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 449:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 44d:	74 17                	je     466 <printint+0x2a>
 44f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 453:	79 11                	jns    466 <printint+0x2a>
    neg = 1;
 455:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 45c:	8b 45 0c             	mov    0xc(%ebp),%eax
 45f:	f7 d8                	neg    %eax
 461:	89 45 ec             	mov    %eax,-0x14(%ebp)
 464:	eb 06                	jmp    46c <printint+0x30>
  } else {
    x = xx;
 466:	8b 45 0c             	mov    0xc(%ebp),%eax
 469:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 46c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 473:	8b 4d 10             	mov    0x10(%ebp),%ecx
 476:	8b 45 ec             	mov    -0x14(%ebp),%eax
 479:	ba 00 00 00 00       	mov    $0x0,%edx
 47e:	f7 f1                	div    %ecx
 480:	89 d0                	mov    %edx,%eax
 482:	0f b6 90 80 0b 00 00 	movzbl 0xb80(%eax),%edx
 489:	8d 45 dc             	lea    -0x24(%ebp),%eax
 48c:	03 45 f4             	add    -0xc(%ebp),%eax
 48f:	88 10                	mov    %dl,(%eax)
 491:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  }while((x /= base) != 0);
 495:	8b 55 10             	mov    0x10(%ebp),%edx
 498:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 49b:	8b 45 ec             	mov    -0x14(%ebp),%eax
 49e:	ba 00 00 00 00       	mov    $0x0,%edx
 4a3:	f7 75 d4             	divl   -0x2c(%ebp)
 4a6:	89 45 ec             	mov    %eax,-0x14(%ebp)
 4a9:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 4ad:	75 c4                	jne    473 <printint+0x37>
  if(neg)
 4af:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 4b3:	74 2a                	je     4df <printint+0xa3>
    buf[i++] = '-';
 4b5:	8d 45 dc             	lea    -0x24(%ebp),%eax
 4b8:	03 45 f4             	add    -0xc(%ebp),%eax
 4bb:	c6 00 2d             	movb   $0x2d,(%eax)
 4be:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)

  while(--i >= 0)
 4c2:	eb 1b                	jmp    4df <printint+0xa3>
    putc(fd, buf[i]);
 4c4:	8d 45 dc             	lea    -0x24(%ebp),%eax
 4c7:	03 45 f4             	add    -0xc(%ebp),%eax
 4ca:	0f b6 00             	movzbl (%eax),%eax
 4cd:	0f be c0             	movsbl %al,%eax
 4d0:	89 44 24 04          	mov    %eax,0x4(%esp)
 4d4:	8b 45 08             	mov    0x8(%ebp),%eax
 4d7:	89 04 24             	mov    %eax,(%esp)
 4da:	e8 35 ff ff ff       	call   414 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 4df:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 4e3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 4e7:	79 db                	jns    4c4 <printint+0x88>
    putc(fd, buf[i]);
}
 4e9:	c9                   	leave  
 4ea:	c3                   	ret    

000004eb <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 4eb:	55                   	push   %ebp
 4ec:	89 e5                	mov    %esp,%ebp
 4ee:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 4f1:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 4f8:	8d 45 0c             	lea    0xc(%ebp),%eax
 4fb:	83 c0 04             	add    $0x4,%eax
 4fe:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 501:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 508:	e9 7d 01 00 00       	jmp    68a <printf+0x19f>
    c = fmt[i] & 0xff;
 50d:	8b 55 0c             	mov    0xc(%ebp),%edx
 510:	8b 45 f0             	mov    -0x10(%ebp),%eax
 513:	01 d0                	add    %edx,%eax
 515:	0f b6 00             	movzbl (%eax),%eax
 518:	0f be c0             	movsbl %al,%eax
 51b:	25 ff 00 00 00       	and    $0xff,%eax
 520:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 523:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 527:	75 2c                	jne    555 <printf+0x6a>
      if(c == '%'){
 529:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 52d:	75 0c                	jne    53b <printf+0x50>
        state = '%';
 52f:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 536:	e9 4b 01 00 00       	jmp    686 <printf+0x19b>
      } else {
        putc(fd, c);
 53b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 53e:	0f be c0             	movsbl %al,%eax
 541:	89 44 24 04          	mov    %eax,0x4(%esp)
 545:	8b 45 08             	mov    0x8(%ebp),%eax
 548:	89 04 24             	mov    %eax,(%esp)
 54b:	e8 c4 fe ff ff       	call   414 <putc>
 550:	e9 31 01 00 00       	jmp    686 <printf+0x19b>
      }
    } else if(state == '%'){
 555:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 559:	0f 85 27 01 00 00    	jne    686 <printf+0x19b>
      if(c == 'd'){
 55f:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 563:	75 2d                	jne    592 <printf+0xa7>
        printint(fd, *ap, 10, 1);
 565:	8b 45 e8             	mov    -0x18(%ebp),%eax
 568:	8b 00                	mov    (%eax),%eax
 56a:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 571:	00 
 572:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 579:	00 
 57a:	89 44 24 04          	mov    %eax,0x4(%esp)
 57e:	8b 45 08             	mov    0x8(%ebp),%eax
 581:	89 04 24             	mov    %eax,(%esp)
 584:	e8 b3 fe ff ff       	call   43c <printint>
        ap++;
 589:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 58d:	e9 ed 00 00 00       	jmp    67f <printf+0x194>
      } else if(c == 'x' || c == 'p'){
 592:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 596:	74 06                	je     59e <printf+0xb3>
 598:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 59c:	75 2d                	jne    5cb <printf+0xe0>
        printint(fd, *ap, 16, 0);
 59e:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5a1:	8b 00                	mov    (%eax),%eax
 5a3:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 5aa:	00 
 5ab:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 5b2:	00 
 5b3:	89 44 24 04          	mov    %eax,0x4(%esp)
 5b7:	8b 45 08             	mov    0x8(%ebp),%eax
 5ba:	89 04 24             	mov    %eax,(%esp)
 5bd:	e8 7a fe ff ff       	call   43c <printint>
        ap++;
 5c2:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5c6:	e9 b4 00 00 00       	jmp    67f <printf+0x194>
      } else if(c == 's'){
 5cb:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 5cf:	75 46                	jne    617 <printf+0x12c>
        s = (char*)*ap;
 5d1:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5d4:	8b 00                	mov    (%eax),%eax
 5d6:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 5d9:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 5dd:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 5e1:	75 27                	jne    60a <printf+0x11f>
          s = "(null)";
 5e3:	c7 45 f4 f7 08 00 00 	movl   $0x8f7,-0xc(%ebp)
        while(*s != 0){
 5ea:	eb 1e                	jmp    60a <printf+0x11f>
          putc(fd, *s);
 5ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5ef:	0f b6 00             	movzbl (%eax),%eax
 5f2:	0f be c0             	movsbl %al,%eax
 5f5:	89 44 24 04          	mov    %eax,0x4(%esp)
 5f9:	8b 45 08             	mov    0x8(%ebp),%eax
 5fc:	89 04 24             	mov    %eax,(%esp)
 5ff:	e8 10 fe ff ff       	call   414 <putc>
          s++;
 604:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 608:	eb 01                	jmp    60b <printf+0x120>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 60a:	90                   	nop
 60b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 60e:	0f b6 00             	movzbl (%eax),%eax
 611:	84 c0                	test   %al,%al
 613:	75 d7                	jne    5ec <printf+0x101>
 615:	eb 68                	jmp    67f <printf+0x194>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 617:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 61b:	75 1d                	jne    63a <printf+0x14f>
        putc(fd, *ap);
 61d:	8b 45 e8             	mov    -0x18(%ebp),%eax
 620:	8b 00                	mov    (%eax),%eax
 622:	0f be c0             	movsbl %al,%eax
 625:	89 44 24 04          	mov    %eax,0x4(%esp)
 629:	8b 45 08             	mov    0x8(%ebp),%eax
 62c:	89 04 24             	mov    %eax,(%esp)
 62f:	e8 e0 fd ff ff       	call   414 <putc>
        ap++;
 634:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 638:	eb 45                	jmp    67f <printf+0x194>
      } else if(c == '%'){
 63a:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 63e:	75 17                	jne    657 <printf+0x16c>
        putc(fd, c);
 640:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 643:	0f be c0             	movsbl %al,%eax
 646:	89 44 24 04          	mov    %eax,0x4(%esp)
 64a:	8b 45 08             	mov    0x8(%ebp),%eax
 64d:	89 04 24             	mov    %eax,(%esp)
 650:	e8 bf fd ff ff       	call   414 <putc>
 655:	eb 28                	jmp    67f <printf+0x194>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 657:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 65e:	00 
 65f:	8b 45 08             	mov    0x8(%ebp),%eax
 662:	89 04 24             	mov    %eax,(%esp)
 665:	e8 aa fd ff ff       	call   414 <putc>
        putc(fd, c);
 66a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 66d:	0f be c0             	movsbl %al,%eax
 670:	89 44 24 04          	mov    %eax,0x4(%esp)
 674:	8b 45 08             	mov    0x8(%ebp),%eax
 677:	89 04 24             	mov    %eax,(%esp)
 67a:	e8 95 fd ff ff       	call   414 <putc>
      }
      state = 0;
 67f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 686:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 68a:	8b 55 0c             	mov    0xc(%ebp),%edx
 68d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 690:	01 d0                	add    %edx,%eax
 692:	0f b6 00             	movzbl (%eax),%eax
 695:	84 c0                	test   %al,%al
 697:	0f 85 70 fe ff ff    	jne    50d <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 69d:	c9                   	leave  
 69e:	c3                   	ret    
 69f:	90                   	nop

000006a0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6a0:	55                   	push   %ebp
 6a1:	89 e5                	mov    %esp,%ebp
 6a3:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 6a6:	8b 45 08             	mov    0x8(%ebp),%eax
 6a9:	83 e8 08             	sub    $0x8,%eax
 6ac:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6af:	a1 9c 0b 00 00       	mov    0xb9c,%eax
 6b4:	89 45 fc             	mov    %eax,-0x4(%ebp)
 6b7:	eb 24                	jmp    6dd <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6b9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6bc:	8b 00                	mov    (%eax),%eax
 6be:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 6c1:	77 12                	ja     6d5 <free+0x35>
 6c3:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6c6:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 6c9:	77 24                	ja     6ef <free+0x4f>
 6cb:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ce:	8b 00                	mov    (%eax),%eax
 6d0:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6d3:	77 1a                	ja     6ef <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6d5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6d8:	8b 00                	mov    (%eax),%eax
 6da:	89 45 fc             	mov    %eax,-0x4(%ebp)
 6dd:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6e0:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 6e3:	76 d4                	jbe    6b9 <free+0x19>
 6e5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6e8:	8b 00                	mov    (%eax),%eax
 6ea:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6ed:	76 ca                	jbe    6b9 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 6ef:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6f2:	8b 40 04             	mov    0x4(%eax),%eax
 6f5:	c1 e0 03             	shl    $0x3,%eax
 6f8:	89 c2                	mov    %eax,%edx
 6fa:	03 55 f8             	add    -0x8(%ebp),%edx
 6fd:	8b 45 fc             	mov    -0x4(%ebp),%eax
 700:	8b 00                	mov    (%eax),%eax
 702:	39 c2                	cmp    %eax,%edx
 704:	75 24                	jne    72a <free+0x8a>
    bp->s.size += p->s.ptr->s.size;
 706:	8b 45 f8             	mov    -0x8(%ebp),%eax
 709:	8b 50 04             	mov    0x4(%eax),%edx
 70c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 70f:	8b 00                	mov    (%eax),%eax
 711:	8b 40 04             	mov    0x4(%eax),%eax
 714:	01 c2                	add    %eax,%edx
 716:	8b 45 f8             	mov    -0x8(%ebp),%eax
 719:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 71c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 71f:	8b 00                	mov    (%eax),%eax
 721:	8b 10                	mov    (%eax),%edx
 723:	8b 45 f8             	mov    -0x8(%ebp),%eax
 726:	89 10                	mov    %edx,(%eax)
 728:	eb 0a                	jmp    734 <free+0x94>
  } else
    bp->s.ptr = p->s.ptr;
 72a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 72d:	8b 10                	mov    (%eax),%edx
 72f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 732:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 734:	8b 45 fc             	mov    -0x4(%ebp),%eax
 737:	8b 40 04             	mov    0x4(%eax),%eax
 73a:	c1 e0 03             	shl    $0x3,%eax
 73d:	03 45 fc             	add    -0x4(%ebp),%eax
 740:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 743:	75 20                	jne    765 <free+0xc5>
    p->s.size += bp->s.size;
 745:	8b 45 fc             	mov    -0x4(%ebp),%eax
 748:	8b 50 04             	mov    0x4(%eax),%edx
 74b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 74e:	8b 40 04             	mov    0x4(%eax),%eax
 751:	01 c2                	add    %eax,%edx
 753:	8b 45 fc             	mov    -0x4(%ebp),%eax
 756:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 759:	8b 45 f8             	mov    -0x8(%ebp),%eax
 75c:	8b 10                	mov    (%eax),%edx
 75e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 761:	89 10                	mov    %edx,(%eax)
 763:	eb 08                	jmp    76d <free+0xcd>
  } else
    p->s.ptr = bp;
 765:	8b 45 fc             	mov    -0x4(%ebp),%eax
 768:	8b 55 f8             	mov    -0x8(%ebp),%edx
 76b:	89 10                	mov    %edx,(%eax)
  freep = p;
 76d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 770:	a3 9c 0b 00 00       	mov    %eax,0xb9c
}
 775:	c9                   	leave  
 776:	c3                   	ret    

00000777 <morecore>:

static Header*
morecore(uint nu)
{
 777:	55                   	push   %ebp
 778:	89 e5                	mov    %esp,%ebp
 77a:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 77d:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 784:	77 07                	ja     78d <morecore+0x16>
    nu = 4096;
 786:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 78d:	8b 45 08             	mov    0x8(%ebp),%eax
 790:	c1 e0 03             	shl    $0x3,%eax
 793:	89 04 24             	mov    %eax,(%esp)
 796:	e8 51 fc ff ff       	call   3ec <sbrk>
 79b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 79e:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 7a2:	75 07                	jne    7ab <morecore+0x34>
    return 0;
 7a4:	b8 00 00 00 00       	mov    $0x0,%eax
 7a9:	eb 22                	jmp    7cd <morecore+0x56>
  hp = (Header*)p;
 7ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7ae:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 7b1:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7b4:	8b 55 08             	mov    0x8(%ebp),%edx
 7b7:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 7ba:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7bd:	83 c0 08             	add    $0x8,%eax
 7c0:	89 04 24             	mov    %eax,(%esp)
 7c3:	e8 d8 fe ff ff       	call   6a0 <free>
  return freep;
 7c8:	a1 9c 0b 00 00       	mov    0xb9c,%eax
}
 7cd:	c9                   	leave  
 7ce:	c3                   	ret    

000007cf <malloc>:

void*
malloc(uint nbytes)
{
 7cf:	55                   	push   %ebp
 7d0:	89 e5                	mov    %esp,%ebp
 7d2:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7d5:	8b 45 08             	mov    0x8(%ebp),%eax
 7d8:	83 c0 07             	add    $0x7,%eax
 7db:	c1 e8 03             	shr    $0x3,%eax
 7de:	83 c0 01             	add    $0x1,%eax
 7e1:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 7e4:	a1 9c 0b 00 00       	mov    0xb9c,%eax
 7e9:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7ec:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 7f0:	75 23                	jne    815 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 7f2:	c7 45 f0 94 0b 00 00 	movl   $0xb94,-0x10(%ebp)
 7f9:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7fc:	a3 9c 0b 00 00       	mov    %eax,0xb9c
 801:	a1 9c 0b 00 00       	mov    0xb9c,%eax
 806:	a3 94 0b 00 00       	mov    %eax,0xb94
    base.s.size = 0;
 80b:	c7 05 98 0b 00 00 00 	movl   $0x0,0xb98
 812:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 815:	8b 45 f0             	mov    -0x10(%ebp),%eax
 818:	8b 00                	mov    (%eax),%eax
 81a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 81d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 820:	8b 40 04             	mov    0x4(%eax),%eax
 823:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 826:	72 4d                	jb     875 <malloc+0xa6>
      if(p->s.size == nunits)
 828:	8b 45 f4             	mov    -0xc(%ebp),%eax
 82b:	8b 40 04             	mov    0x4(%eax),%eax
 82e:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 831:	75 0c                	jne    83f <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 833:	8b 45 f4             	mov    -0xc(%ebp),%eax
 836:	8b 10                	mov    (%eax),%edx
 838:	8b 45 f0             	mov    -0x10(%ebp),%eax
 83b:	89 10                	mov    %edx,(%eax)
 83d:	eb 26                	jmp    865 <malloc+0x96>
      else {
        p->s.size -= nunits;
 83f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 842:	8b 40 04             	mov    0x4(%eax),%eax
 845:	89 c2                	mov    %eax,%edx
 847:	2b 55 ec             	sub    -0x14(%ebp),%edx
 84a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 84d:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 850:	8b 45 f4             	mov    -0xc(%ebp),%eax
 853:	8b 40 04             	mov    0x4(%eax),%eax
 856:	c1 e0 03             	shl    $0x3,%eax
 859:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 85c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 85f:	8b 55 ec             	mov    -0x14(%ebp),%edx
 862:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 865:	8b 45 f0             	mov    -0x10(%ebp),%eax
 868:	a3 9c 0b 00 00       	mov    %eax,0xb9c
      return (void*)(p + 1);
 86d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 870:	83 c0 08             	add    $0x8,%eax
 873:	eb 38                	jmp    8ad <malloc+0xde>
    }
    if(p == freep)
 875:	a1 9c 0b 00 00       	mov    0xb9c,%eax
 87a:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 87d:	75 1b                	jne    89a <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 87f:	8b 45 ec             	mov    -0x14(%ebp),%eax
 882:	89 04 24             	mov    %eax,(%esp)
 885:	e8 ed fe ff ff       	call   777 <morecore>
 88a:	89 45 f4             	mov    %eax,-0xc(%ebp)
 88d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 891:	75 07                	jne    89a <malloc+0xcb>
        return 0;
 893:	b8 00 00 00 00       	mov    $0x0,%eax
 898:	eb 13                	jmp    8ad <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 89a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 89d:	89 45 f0             	mov    %eax,-0x10(%ebp)
 8a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8a3:	8b 00                	mov    (%eax),%eax
 8a5:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 8a8:	e9 70 ff ff ff       	jmp    81d <malloc+0x4e>
}
 8ad:	c9                   	leave  
 8ae:	c3                   	ret    
