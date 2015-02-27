
_stage2_timing:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:

void handle_signal(int);


int main(int argc, char *argv[])
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 e4 f0             	and    $0xfffffff0,%esp
   6:	83 ec 50             	sub    $0x50,%esp
	int x = 5;
   9:	c7 44 24 4c 05 00 00 	movl   $0x5,0x4c(%esp)
  10:	00 
	int y = 0;
  11:	c7 44 24 48 00 00 00 	movl   $0x0,0x48(%esp)
  18:	00 
	int begin, end;
	int counts = count;
  19:	a1 a8 0b 00 00       	mov    0xba8,%eax
  1e:	89 44 24 44          	mov    %eax,0x44(%esp)

	// printf(1, "anything\n");

	signal(SIGFPE, handle_signal);
  22:	c7 44 24 04 0b 01 00 	movl   $0x10b,0x4(%esp)
  29:	00 
  2a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  31:	e8 06 04 00 00       	call   43c <signal>

	// printf(1, "anything\n");
	
	begin = uptime();
  36:	e8 f1 03 00 00       	call   42c <uptime>
  3b:	89 44 24 40          	mov    %eax,0x40(%esp)
	// printf(1, "The clock cycle now is: %d\n", begin);	
	x = x / y;
  3f:	8b 44 24 4c          	mov    0x4c(%esp),%eax
  43:	89 c2                	mov    %eax,%edx
  45:	c1 fa 1f             	sar    $0x1f,%edx
  48:	f7 7c 24 48          	idivl  0x48(%esp)
  4c:	89 44 24 4c          	mov    %eax,0x4c(%esp)
	end = uptime();
  50:	e8 d7 03 00 00       	call   42c <uptime>
  55:	89 44 24 3c          	mov    %eax,0x3c(%esp)
	// double dtotal = double(end - begin) * 4348 * 1000; 
	double dtotal = (double)(end - begin) * 10000 / CPU; 
  59:	8b 44 24 40          	mov    0x40(%esp),%eax
  5d:	8b 54 24 3c          	mov    0x3c(%esp),%edx
  61:	89 d1                	mov    %edx,%ecx
  63:	29 c1                	sub    %eax,%ecx
  65:	89 c8                	mov    %ecx,%eax
  67:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  6b:	db 44 24 1c          	fildl  0x1c(%esp)
  6f:	dd 05 38 09 00 00    	fldl   0x938
  75:	de c9                	fmulp  %st,%st(1)
  77:	dd 05 b0 0b 00 00    	fldl   0xbb0
  7d:	de f9                	fdivrp %st,%st(1)
  7f:	dd 5c 24 30          	fstpl  0x30(%esp)
	//time per timer IRQ = (10000000 / 2.3Ghz)s
	//                   = (10 / 2.3) ms
	//                   = (10000 / 2.3) us
	//                   = (10000000 / 2.3) ns
	// printf(1, "The clock cycle now is: %d\n", end);
	int total = (int)dtotal;
  83:	dd 44 24 30          	fldl   0x30(%esp)
  87:	d9 7c 24 1a          	fnstcw 0x1a(%esp)
  8b:	0f b7 44 24 1a       	movzwl 0x1a(%esp),%eax
  90:	b4 0c                	mov    $0xc,%ah
  92:	66 89 44 24 18       	mov    %ax,0x18(%esp)
  97:	d9 6c 24 18          	fldcw  0x18(%esp)
  9b:	db 5c 24 2c          	fistpl 0x2c(%esp)
  9f:	d9 6c 24 1a          	fldcw  0x1a(%esp)
	printf(1, "Traps Performed: %d times\n", counts);
  a3:	8b 44 24 44          	mov    0x44(%esp),%eax
  a7:	89 44 24 08          	mov    %eax,0x8(%esp)
  ab:	c7 44 24 04 e0 08 00 	movl   $0x8e0,0x4(%esp)
  b2:	00 
  b3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  ba:	e8 5c 04 00 00       	call   51b <printf>
	printf(1, "Total Elapsed Time: %d us\n", total);
  bf:	8b 44 24 2c          	mov    0x2c(%esp),%eax
  c3:	89 44 24 08          	mov    %eax,0x8(%esp)
  c7:	c7 44 24 04 fb 08 00 	movl   $0x8fb,0x4(%esp)
  ce:	00 
  cf:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  d6:	e8 40 04 00 00       	call   51b <printf>
	printf(1, "Average Time Per Trap: %d ns\n", total * 1000 / counts);
  db:	8b 44 24 2c          	mov    0x2c(%esp),%eax
  df:	69 c0 e8 03 00 00    	imul   $0x3e8,%eax,%eax
  e5:	89 c2                	mov    %eax,%edx
  e7:	c1 fa 1f             	sar    $0x1f,%edx
  ea:	f7 7c 24 44          	idivl  0x44(%esp)
  ee:	89 44 24 08          	mov    %eax,0x8(%esp)
  f2:	c7 44 24 04 16 09 00 	movl   $0x916,0x4(%esp)
  f9:	00 
  fa:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 101:	e8 15 04 00 00       	call   51b <printf>

	exit();
 106:	e8 89 02 00 00       	call   394 <exit>

0000010b <handle_signal>:
}

void handle_signal(int signum)
{
 10b:	55                   	push   %ebp
 10c:	89 e5                	mov    %esp,%ebp
	// printf(1, "inside self handler\n");
	// printf(1, "modify the return address\n");
	// printf(1, "count = %d\n", count);
	--count;
 10e:	a1 a8 0b 00 00       	mov    0xba8,%eax
 113:	83 e8 01             	sub    $0x1,%eax
 116:	a3 a8 0b 00 00       	mov    %eax,0xba8
	if(!count)
 11b:	a1 a8 0b 00 00       	mov    0xba8,%eax
 120:	85 c0                	test   %eax,%eax
 122:	75 07                	jne    12b <handle_signal+0x20>
	{
		__asm__ ("movl $0x50,4(%ebp)\n\t");
 124:	c7 45 04 50 00 00 00 	movl   $0x50,0x4(%ebp)
	}
 12b:	5d                   	pop    %ebp
 12c:	c3                   	ret    
 12d:	90                   	nop
 12e:	90                   	nop
 12f:	90                   	nop

00000130 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 130:	55                   	push   %ebp
 131:	89 e5                	mov    %esp,%ebp
 133:	57                   	push   %edi
 134:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 135:	8b 4d 08             	mov    0x8(%ebp),%ecx
 138:	8b 55 10             	mov    0x10(%ebp),%edx
 13b:	8b 45 0c             	mov    0xc(%ebp),%eax
 13e:	89 cb                	mov    %ecx,%ebx
 140:	89 df                	mov    %ebx,%edi
 142:	89 d1                	mov    %edx,%ecx
 144:	fc                   	cld    
 145:	f3 aa                	rep stos %al,%es:(%edi)
 147:	89 ca                	mov    %ecx,%edx
 149:	89 fb                	mov    %edi,%ebx
 14b:	89 5d 08             	mov    %ebx,0x8(%ebp)
 14e:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 151:	5b                   	pop    %ebx
 152:	5f                   	pop    %edi
 153:	5d                   	pop    %ebp
 154:	c3                   	ret    

00000155 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 155:	55                   	push   %ebp
 156:	89 e5                	mov    %esp,%ebp
 158:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 15b:	8b 45 08             	mov    0x8(%ebp),%eax
 15e:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 161:	90                   	nop
 162:	8b 45 0c             	mov    0xc(%ebp),%eax
 165:	0f b6 10             	movzbl (%eax),%edx
 168:	8b 45 08             	mov    0x8(%ebp),%eax
 16b:	88 10                	mov    %dl,(%eax)
 16d:	8b 45 08             	mov    0x8(%ebp),%eax
 170:	0f b6 00             	movzbl (%eax),%eax
 173:	84 c0                	test   %al,%al
 175:	0f 95 c0             	setne  %al
 178:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 17c:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
 180:	84 c0                	test   %al,%al
 182:	75 de                	jne    162 <strcpy+0xd>
    ;
  return os;
 184:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 187:	c9                   	leave  
 188:	c3                   	ret    

00000189 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 189:	55                   	push   %ebp
 18a:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 18c:	eb 08                	jmp    196 <strcmp+0xd>
    p++, q++;
 18e:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 192:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 196:	8b 45 08             	mov    0x8(%ebp),%eax
 199:	0f b6 00             	movzbl (%eax),%eax
 19c:	84 c0                	test   %al,%al
 19e:	74 10                	je     1b0 <strcmp+0x27>
 1a0:	8b 45 08             	mov    0x8(%ebp),%eax
 1a3:	0f b6 10             	movzbl (%eax),%edx
 1a6:	8b 45 0c             	mov    0xc(%ebp),%eax
 1a9:	0f b6 00             	movzbl (%eax),%eax
 1ac:	38 c2                	cmp    %al,%dl
 1ae:	74 de                	je     18e <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 1b0:	8b 45 08             	mov    0x8(%ebp),%eax
 1b3:	0f b6 00             	movzbl (%eax),%eax
 1b6:	0f b6 d0             	movzbl %al,%edx
 1b9:	8b 45 0c             	mov    0xc(%ebp),%eax
 1bc:	0f b6 00             	movzbl (%eax),%eax
 1bf:	0f b6 c0             	movzbl %al,%eax
 1c2:	89 d1                	mov    %edx,%ecx
 1c4:	29 c1                	sub    %eax,%ecx
 1c6:	89 c8                	mov    %ecx,%eax
}
 1c8:	5d                   	pop    %ebp
 1c9:	c3                   	ret    

000001ca <strlen>:

uint
strlen(char *s)
{
 1ca:	55                   	push   %ebp
 1cb:	89 e5                	mov    %esp,%ebp
 1cd:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 1d0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 1d7:	eb 04                	jmp    1dd <strlen+0x13>
 1d9:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 1dd:	8b 45 fc             	mov    -0x4(%ebp),%eax
 1e0:	03 45 08             	add    0x8(%ebp),%eax
 1e3:	0f b6 00             	movzbl (%eax),%eax
 1e6:	84 c0                	test   %al,%al
 1e8:	75 ef                	jne    1d9 <strlen+0xf>
    ;
  return n;
 1ea:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 1ed:	c9                   	leave  
 1ee:	c3                   	ret    

000001ef <memset>:

void*
memset(void *dst, int c, uint n)
{
 1ef:	55                   	push   %ebp
 1f0:	89 e5                	mov    %esp,%ebp
 1f2:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
 1f5:	8b 45 10             	mov    0x10(%ebp),%eax
 1f8:	89 44 24 08          	mov    %eax,0x8(%esp)
 1fc:	8b 45 0c             	mov    0xc(%ebp),%eax
 1ff:	89 44 24 04          	mov    %eax,0x4(%esp)
 203:	8b 45 08             	mov    0x8(%ebp),%eax
 206:	89 04 24             	mov    %eax,(%esp)
 209:	e8 22 ff ff ff       	call   130 <stosb>
  return dst;
 20e:	8b 45 08             	mov    0x8(%ebp),%eax
}
 211:	c9                   	leave  
 212:	c3                   	ret    

00000213 <strchr>:

char*
strchr(const char *s, char c)
{
 213:	55                   	push   %ebp
 214:	89 e5                	mov    %esp,%ebp
 216:	83 ec 04             	sub    $0x4,%esp
 219:	8b 45 0c             	mov    0xc(%ebp),%eax
 21c:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 21f:	eb 14                	jmp    235 <strchr+0x22>
    if(*s == c)
 221:	8b 45 08             	mov    0x8(%ebp),%eax
 224:	0f b6 00             	movzbl (%eax),%eax
 227:	3a 45 fc             	cmp    -0x4(%ebp),%al
 22a:	75 05                	jne    231 <strchr+0x1e>
      return (char*)s;
 22c:	8b 45 08             	mov    0x8(%ebp),%eax
 22f:	eb 13                	jmp    244 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 231:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 235:	8b 45 08             	mov    0x8(%ebp),%eax
 238:	0f b6 00             	movzbl (%eax),%eax
 23b:	84 c0                	test   %al,%al
 23d:	75 e2                	jne    221 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 23f:	b8 00 00 00 00       	mov    $0x0,%eax
}
 244:	c9                   	leave  
 245:	c3                   	ret    

00000246 <gets>:

char*
gets(char *buf, int max)
{
 246:	55                   	push   %ebp
 247:	89 e5                	mov    %esp,%ebp
 249:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 24c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 253:	eb 44                	jmp    299 <gets+0x53>
    cc = read(0, &c, 1);
 255:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 25c:	00 
 25d:	8d 45 ef             	lea    -0x11(%ebp),%eax
 260:	89 44 24 04          	mov    %eax,0x4(%esp)
 264:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 26b:	e8 3c 01 00 00       	call   3ac <read>
 270:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 273:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 277:	7e 2d                	jle    2a6 <gets+0x60>
      break;
    buf[i++] = c;
 279:	8b 45 f4             	mov    -0xc(%ebp),%eax
 27c:	03 45 08             	add    0x8(%ebp),%eax
 27f:	0f b6 55 ef          	movzbl -0x11(%ebp),%edx
 283:	88 10                	mov    %dl,(%eax)
 285:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(c == '\n' || c == '\r')
 289:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 28d:	3c 0a                	cmp    $0xa,%al
 28f:	74 16                	je     2a7 <gets+0x61>
 291:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 295:	3c 0d                	cmp    $0xd,%al
 297:	74 0e                	je     2a7 <gets+0x61>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 299:	8b 45 f4             	mov    -0xc(%ebp),%eax
 29c:	83 c0 01             	add    $0x1,%eax
 29f:	3b 45 0c             	cmp    0xc(%ebp),%eax
 2a2:	7c b1                	jl     255 <gets+0xf>
 2a4:	eb 01                	jmp    2a7 <gets+0x61>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 2a6:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 2a7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 2aa:	03 45 08             	add    0x8(%ebp),%eax
 2ad:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 2b0:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2b3:	c9                   	leave  
 2b4:	c3                   	ret    

000002b5 <stat>:

int
stat(char *n, struct stat *st)
{
 2b5:	55                   	push   %ebp
 2b6:	89 e5                	mov    %esp,%ebp
 2b8:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2bb:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 2c2:	00 
 2c3:	8b 45 08             	mov    0x8(%ebp),%eax
 2c6:	89 04 24             	mov    %eax,(%esp)
 2c9:	e8 06 01 00 00       	call   3d4 <open>
 2ce:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 2d1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 2d5:	79 07                	jns    2de <stat+0x29>
    return -1;
 2d7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 2dc:	eb 23                	jmp    301 <stat+0x4c>
  r = fstat(fd, st);
 2de:	8b 45 0c             	mov    0xc(%ebp),%eax
 2e1:	89 44 24 04          	mov    %eax,0x4(%esp)
 2e5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 2e8:	89 04 24             	mov    %eax,(%esp)
 2eb:	e8 fc 00 00 00       	call   3ec <fstat>
 2f0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 2f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 2f6:	89 04 24             	mov    %eax,(%esp)
 2f9:	e8 be 00 00 00       	call   3bc <close>
  return r;
 2fe:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 301:	c9                   	leave  
 302:	c3                   	ret    

00000303 <atoi>:

int
atoi(const char *s)
{
 303:	55                   	push   %ebp
 304:	89 e5                	mov    %esp,%ebp
 306:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 309:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 310:	eb 23                	jmp    335 <atoi+0x32>
    n = n*10 + *s++ - '0';
 312:	8b 55 fc             	mov    -0x4(%ebp),%edx
 315:	89 d0                	mov    %edx,%eax
 317:	c1 e0 02             	shl    $0x2,%eax
 31a:	01 d0                	add    %edx,%eax
 31c:	01 c0                	add    %eax,%eax
 31e:	89 c2                	mov    %eax,%edx
 320:	8b 45 08             	mov    0x8(%ebp),%eax
 323:	0f b6 00             	movzbl (%eax),%eax
 326:	0f be c0             	movsbl %al,%eax
 329:	01 d0                	add    %edx,%eax
 32b:	83 e8 30             	sub    $0x30,%eax
 32e:	89 45 fc             	mov    %eax,-0x4(%ebp)
 331:	83 45 08 01          	addl   $0x1,0x8(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 335:	8b 45 08             	mov    0x8(%ebp),%eax
 338:	0f b6 00             	movzbl (%eax),%eax
 33b:	3c 2f                	cmp    $0x2f,%al
 33d:	7e 0a                	jle    349 <atoi+0x46>
 33f:	8b 45 08             	mov    0x8(%ebp),%eax
 342:	0f b6 00             	movzbl (%eax),%eax
 345:	3c 39                	cmp    $0x39,%al
 347:	7e c9                	jle    312 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 349:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 34c:	c9                   	leave  
 34d:	c3                   	ret    

0000034e <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 34e:	55                   	push   %ebp
 34f:	89 e5                	mov    %esp,%ebp
 351:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 354:	8b 45 08             	mov    0x8(%ebp),%eax
 357:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 35a:	8b 45 0c             	mov    0xc(%ebp),%eax
 35d:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 360:	eb 13                	jmp    375 <memmove+0x27>
    *dst++ = *src++;
 362:	8b 45 f8             	mov    -0x8(%ebp),%eax
 365:	0f b6 10             	movzbl (%eax),%edx
 368:	8b 45 fc             	mov    -0x4(%ebp),%eax
 36b:	88 10                	mov    %dl,(%eax)
 36d:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 371:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 375:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
 379:	0f 9f c0             	setg   %al
 37c:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
 380:	84 c0                	test   %al,%al
 382:	75 de                	jne    362 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 384:	8b 45 08             	mov    0x8(%ebp),%eax
}
 387:	c9                   	leave  
 388:	c3                   	ret    
 389:	90                   	nop
 38a:	90                   	nop
 38b:	90                   	nop

0000038c <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 38c:	b8 01 00 00 00       	mov    $0x1,%eax
 391:	cd 40                	int    $0x40
 393:	c3                   	ret    

00000394 <exit>:
SYSCALL(exit)
 394:	b8 02 00 00 00       	mov    $0x2,%eax
 399:	cd 40                	int    $0x40
 39b:	c3                   	ret    

0000039c <wait>:
SYSCALL(wait)
 39c:	b8 03 00 00 00       	mov    $0x3,%eax
 3a1:	cd 40                	int    $0x40
 3a3:	c3                   	ret    

000003a4 <pipe>:
SYSCALL(pipe)
 3a4:	b8 04 00 00 00       	mov    $0x4,%eax
 3a9:	cd 40                	int    $0x40
 3ab:	c3                   	ret    

000003ac <read>:
SYSCALL(read)
 3ac:	b8 05 00 00 00       	mov    $0x5,%eax
 3b1:	cd 40                	int    $0x40
 3b3:	c3                   	ret    

000003b4 <write>:
SYSCALL(write)
 3b4:	b8 10 00 00 00       	mov    $0x10,%eax
 3b9:	cd 40                	int    $0x40
 3bb:	c3                   	ret    

000003bc <close>:
SYSCALL(close)
 3bc:	b8 15 00 00 00       	mov    $0x15,%eax
 3c1:	cd 40                	int    $0x40
 3c3:	c3                   	ret    

000003c4 <kill>:
SYSCALL(kill)
 3c4:	b8 06 00 00 00       	mov    $0x6,%eax
 3c9:	cd 40                	int    $0x40
 3cb:	c3                   	ret    

000003cc <exec>:
SYSCALL(exec)
 3cc:	b8 07 00 00 00       	mov    $0x7,%eax
 3d1:	cd 40                	int    $0x40
 3d3:	c3                   	ret    

000003d4 <open>:
SYSCALL(open)
 3d4:	b8 0f 00 00 00       	mov    $0xf,%eax
 3d9:	cd 40                	int    $0x40
 3db:	c3                   	ret    

000003dc <mknod>:
SYSCALL(mknod)
 3dc:	b8 11 00 00 00       	mov    $0x11,%eax
 3e1:	cd 40                	int    $0x40
 3e3:	c3                   	ret    

000003e4 <unlink>:
SYSCALL(unlink)
 3e4:	b8 12 00 00 00       	mov    $0x12,%eax
 3e9:	cd 40                	int    $0x40
 3eb:	c3                   	ret    

000003ec <fstat>:
SYSCALL(fstat)
 3ec:	b8 08 00 00 00       	mov    $0x8,%eax
 3f1:	cd 40                	int    $0x40
 3f3:	c3                   	ret    

000003f4 <link>:
SYSCALL(link)
 3f4:	b8 13 00 00 00       	mov    $0x13,%eax
 3f9:	cd 40                	int    $0x40
 3fb:	c3                   	ret    

000003fc <mkdir>:
SYSCALL(mkdir)
 3fc:	b8 14 00 00 00       	mov    $0x14,%eax
 401:	cd 40                	int    $0x40
 403:	c3                   	ret    

00000404 <chdir>:
SYSCALL(chdir)
 404:	b8 09 00 00 00       	mov    $0x9,%eax
 409:	cd 40                	int    $0x40
 40b:	c3                   	ret    

0000040c <dup>:
SYSCALL(dup)
 40c:	b8 0a 00 00 00       	mov    $0xa,%eax
 411:	cd 40                	int    $0x40
 413:	c3                   	ret    

00000414 <getpid>:
SYSCALL(getpid)
 414:	b8 0b 00 00 00       	mov    $0xb,%eax
 419:	cd 40                	int    $0x40
 41b:	c3                   	ret    

0000041c <sbrk>:
SYSCALL(sbrk)
 41c:	b8 0c 00 00 00       	mov    $0xc,%eax
 421:	cd 40                	int    $0x40
 423:	c3                   	ret    

00000424 <sleep>:
SYSCALL(sleep)
 424:	b8 0d 00 00 00       	mov    $0xd,%eax
 429:	cd 40                	int    $0x40
 42b:	c3                   	ret    

0000042c <uptime>:
SYSCALL(uptime)
 42c:	b8 0e 00 00 00       	mov    $0xe,%eax
 431:	cd 40                	int    $0x40
 433:	c3                   	ret    

00000434 <halt>:
SYSCALL(halt)
 434:	b8 16 00 00 00       	mov    $0x16,%eax
 439:	cd 40                	int    $0x40
 43b:	c3                   	ret    

0000043c <signal>:
 43c:	b8 17 00 00 00       	mov    $0x17,%eax
 441:	cd 40                	int    $0x40
 443:	c3                   	ret    

00000444 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 444:	55                   	push   %ebp
 445:	89 e5                	mov    %esp,%ebp
 447:	83 ec 28             	sub    $0x28,%esp
 44a:	8b 45 0c             	mov    0xc(%ebp),%eax
 44d:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 450:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 457:	00 
 458:	8d 45 f4             	lea    -0xc(%ebp),%eax
 45b:	89 44 24 04          	mov    %eax,0x4(%esp)
 45f:	8b 45 08             	mov    0x8(%ebp),%eax
 462:	89 04 24             	mov    %eax,(%esp)
 465:	e8 4a ff ff ff       	call   3b4 <write>
}
 46a:	c9                   	leave  
 46b:	c3                   	ret    

0000046c <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 46c:	55                   	push   %ebp
 46d:	89 e5                	mov    %esp,%ebp
 46f:	83 ec 48             	sub    $0x48,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 472:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 479:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 47d:	74 17                	je     496 <printint+0x2a>
 47f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 483:	79 11                	jns    496 <printint+0x2a>
    neg = 1;
 485:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 48c:	8b 45 0c             	mov    0xc(%ebp),%eax
 48f:	f7 d8                	neg    %eax
 491:	89 45 ec             	mov    %eax,-0x14(%ebp)
 494:	eb 06                	jmp    49c <printint+0x30>
  } else {
    x = xx;
 496:	8b 45 0c             	mov    0xc(%ebp),%eax
 499:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 49c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 4a3:	8b 4d 10             	mov    0x10(%ebp),%ecx
 4a6:	8b 45 ec             	mov    -0x14(%ebp),%eax
 4a9:	ba 00 00 00 00       	mov    $0x0,%edx
 4ae:	f7 f1                	div    %ecx
 4b0:	89 d0                	mov    %edx,%eax
 4b2:	0f b6 90 b8 0b 00 00 	movzbl 0xbb8(%eax),%edx
 4b9:	8d 45 dc             	lea    -0x24(%ebp),%eax
 4bc:	03 45 f4             	add    -0xc(%ebp),%eax
 4bf:	88 10                	mov    %dl,(%eax)
 4c1:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  }while((x /= base) != 0);
 4c5:	8b 55 10             	mov    0x10(%ebp),%edx
 4c8:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 4cb:	8b 45 ec             	mov    -0x14(%ebp),%eax
 4ce:	ba 00 00 00 00       	mov    $0x0,%edx
 4d3:	f7 75 d4             	divl   -0x2c(%ebp)
 4d6:	89 45 ec             	mov    %eax,-0x14(%ebp)
 4d9:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 4dd:	75 c4                	jne    4a3 <printint+0x37>
  if(neg)
 4df:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 4e3:	74 2a                	je     50f <printint+0xa3>
    buf[i++] = '-';
 4e5:	8d 45 dc             	lea    -0x24(%ebp),%eax
 4e8:	03 45 f4             	add    -0xc(%ebp),%eax
 4eb:	c6 00 2d             	movb   $0x2d,(%eax)
 4ee:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)

  while(--i >= 0)
 4f2:	eb 1b                	jmp    50f <printint+0xa3>
    putc(fd, buf[i]);
 4f4:	8d 45 dc             	lea    -0x24(%ebp),%eax
 4f7:	03 45 f4             	add    -0xc(%ebp),%eax
 4fa:	0f b6 00             	movzbl (%eax),%eax
 4fd:	0f be c0             	movsbl %al,%eax
 500:	89 44 24 04          	mov    %eax,0x4(%esp)
 504:	8b 45 08             	mov    0x8(%ebp),%eax
 507:	89 04 24             	mov    %eax,(%esp)
 50a:	e8 35 ff ff ff       	call   444 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 50f:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 513:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 517:	79 db                	jns    4f4 <printint+0x88>
    putc(fd, buf[i]);
}
 519:	c9                   	leave  
 51a:	c3                   	ret    

0000051b <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 51b:	55                   	push   %ebp
 51c:	89 e5                	mov    %esp,%ebp
 51e:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 521:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 528:	8d 45 0c             	lea    0xc(%ebp),%eax
 52b:	83 c0 04             	add    $0x4,%eax
 52e:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 531:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 538:	e9 7d 01 00 00       	jmp    6ba <printf+0x19f>
    c = fmt[i] & 0xff;
 53d:	8b 55 0c             	mov    0xc(%ebp),%edx
 540:	8b 45 f0             	mov    -0x10(%ebp),%eax
 543:	01 d0                	add    %edx,%eax
 545:	0f b6 00             	movzbl (%eax),%eax
 548:	0f be c0             	movsbl %al,%eax
 54b:	25 ff 00 00 00       	and    $0xff,%eax
 550:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 553:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 557:	75 2c                	jne    585 <printf+0x6a>
      if(c == '%'){
 559:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 55d:	75 0c                	jne    56b <printf+0x50>
        state = '%';
 55f:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 566:	e9 4b 01 00 00       	jmp    6b6 <printf+0x19b>
      } else {
        putc(fd, c);
 56b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 56e:	0f be c0             	movsbl %al,%eax
 571:	89 44 24 04          	mov    %eax,0x4(%esp)
 575:	8b 45 08             	mov    0x8(%ebp),%eax
 578:	89 04 24             	mov    %eax,(%esp)
 57b:	e8 c4 fe ff ff       	call   444 <putc>
 580:	e9 31 01 00 00       	jmp    6b6 <printf+0x19b>
      }
    } else if(state == '%'){
 585:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 589:	0f 85 27 01 00 00    	jne    6b6 <printf+0x19b>
      if(c == 'd'){
 58f:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 593:	75 2d                	jne    5c2 <printf+0xa7>
        printint(fd, *ap, 10, 1);
 595:	8b 45 e8             	mov    -0x18(%ebp),%eax
 598:	8b 00                	mov    (%eax),%eax
 59a:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 5a1:	00 
 5a2:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 5a9:	00 
 5aa:	89 44 24 04          	mov    %eax,0x4(%esp)
 5ae:	8b 45 08             	mov    0x8(%ebp),%eax
 5b1:	89 04 24             	mov    %eax,(%esp)
 5b4:	e8 b3 fe ff ff       	call   46c <printint>
        ap++;
 5b9:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5bd:	e9 ed 00 00 00       	jmp    6af <printf+0x194>
      } else if(c == 'x' || c == 'p'){
 5c2:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 5c6:	74 06                	je     5ce <printf+0xb3>
 5c8:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 5cc:	75 2d                	jne    5fb <printf+0xe0>
        printint(fd, *ap, 16, 0);
 5ce:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5d1:	8b 00                	mov    (%eax),%eax
 5d3:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 5da:	00 
 5db:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 5e2:	00 
 5e3:	89 44 24 04          	mov    %eax,0x4(%esp)
 5e7:	8b 45 08             	mov    0x8(%ebp),%eax
 5ea:	89 04 24             	mov    %eax,(%esp)
 5ed:	e8 7a fe ff ff       	call   46c <printint>
        ap++;
 5f2:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5f6:	e9 b4 00 00 00       	jmp    6af <printf+0x194>
      } else if(c == 's'){
 5fb:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 5ff:	75 46                	jne    647 <printf+0x12c>
        s = (char*)*ap;
 601:	8b 45 e8             	mov    -0x18(%ebp),%eax
 604:	8b 00                	mov    (%eax),%eax
 606:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 609:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 60d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 611:	75 27                	jne    63a <printf+0x11f>
          s = "(null)";
 613:	c7 45 f4 40 09 00 00 	movl   $0x940,-0xc(%ebp)
        while(*s != 0){
 61a:	eb 1e                	jmp    63a <printf+0x11f>
          putc(fd, *s);
 61c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 61f:	0f b6 00             	movzbl (%eax),%eax
 622:	0f be c0             	movsbl %al,%eax
 625:	89 44 24 04          	mov    %eax,0x4(%esp)
 629:	8b 45 08             	mov    0x8(%ebp),%eax
 62c:	89 04 24             	mov    %eax,(%esp)
 62f:	e8 10 fe ff ff       	call   444 <putc>
          s++;
 634:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 638:	eb 01                	jmp    63b <printf+0x120>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 63a:	90                   	nop
 63b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 63e:	0f b6 00             	movzbl (%eax),%eax
 641:	84 c0                	test   %al,%al
 643:	75 d7                	jne    61c <printf+0x101>
 645:	eb 68                	jmp    6af <printf+0x194>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 647:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 64b:	75 1d                	jne    66a <printf+0x14f>
        putc(fd, *ap);
 64d:	8b 45 e8             	mov    -0x18(%ebp),%eax
 650:	8b 00                	mov    (%eax),%eax
 652:	0f be c0             	movsbl %al,%eax
 655:	89 44 24 04          	mov    %eax,0x4(%esp)
 659:	8b 45 08             	mov    0x8(%ebp),%eax
 65c:	89 04 24             	mov    %eax,(%esp)
 65f:	e8 e0 fd ff ff       	call   444 <putc>
        ap++;
 664:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 668:	eb 45                	jmp    6af <printf+0x194>
      } else if(c == '%'){
 66a:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 66e:	75 17                	jne    687 <printf+0x16c>
        putc(fd, c);
 670:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 673:	0f be c0             	movsbl %al,%eax
 676:	89 44 24 04          	mov    %eax,0x4(%esp)
 67a:	8b 45 08             	mov    0x8(%ebp),%eax
 67d:	89 04 24             	mov    %eax,(%esp)
 680:	e8 bf fd ff ff       	call   444 <putc>
 685:	eb 28                	jmp    6af <printf+0x194>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 687:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 68e:	00 
 68f:	8b 45 08             	mov    0x8(%ebp),%eax
 692:	89 04 24             	mov    %eax,(%esp)
 695:	e8 aa fd ff ff       	call   444 <putc>
        putc(fd, c);
 69a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 69d:	0f be c0             	movsbl %al,%eax
 6a0:	89 44 24 04          	mov    %eax,0x4(%esp)
 6a4:	8b 45 08             	mov    0x8(%ebp),%eax
 6a7:	89 04 24             	mov    %eax,(%esp)
 6aa:	e8 95 fd ff ff       	call   444 <putc>
      }
      state = 0;
 6af:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 6b6:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 6ba:	8b 55 0c             	mov    0xc(%ebp),%edx
 6bd:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6c0:	01 d0                	add    %edx,%eax
 6c2:	0f b6 00             	movzbl (%eax),%eax
 6c5:	84 c0                	test   %al,%al
 6c7:	0f 85 70 fe ff ff    	jne    53d <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 6cd:	c9                   	leave  
 6ce:	c3                   	ret    
 6cf:	90                   	nop

000006d0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6d0:	55                   	push   %ebp
 6d1:	89 e5                	mov    %esp,%ebp
 6d3:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 6d6:	8b 45 08             	mov    0x8(%ebp),%eax
 6d9:	83 e8 08             	sub    $0x8,%eax
 6dc:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6df:	a1 d4 0b 00 00       	mov    0xbd4,%eax
 6e4:	89 45 fc             	mov    %eax,-0x4(%ebp)
 6e7:	eb 24                	jmp    70d <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6e9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ec:	8b 00                	mov    (%eax),%eax
 6ee:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 6f1:	77 12                	ja     705 <free+0x35>
 6f3:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6f6:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 6f9:	77 24                	ja     71f <free+0x4f>
 6fb:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6fe:	8b 00                	mov    (%eax),%eax
 700:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 703:	77 1a                	ja     71f <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 705:	8b 45 fc             	mov    -0x4(%ebp),%eax
 708:	8b 00                	mov    (%eax),%eax
 70a:	89 45 fc             	mov    %eax,-0x4(%ebp)
 70d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 710:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 713:	76 d4                	jbe    6e9 <free+0x19>
 715:	8b 45 fc             	mov    -0x4(%ebp),%eax
 718:	8b 00                	mov    (%eax),%eax
 71a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 71d:	76 ca                	jbe    6e9 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 71f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 722:	8b 40 04             	mov    0x4(%eax),%eax
 725:	c1 e0 03             	shl    $0x3,%eax
 728:	89 c2                	mov    %eax,%edx
 72a:	03 55 f8             	add    -0x8(%ebp),%edx
 72d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 730:	8b 00                	mov    (%eax),%eax
 732:	39 c2                	cmp    %eax,%edx
 734:	75 24                	jne    75a <free+0x8a>
    bp->s.size += p->s.ptr->s.size;
 736:	8b 45 f8             	mov    -0x8(%ebp),%eax
 739:	8b 50 04             	mov    0x4(%eax),%edx
 73c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 73f:	8b 00                	mov    (%eax),%eax
 741:	8b 40 04             	mov    0x4(%eax),%eax
 744:	01 c2                	add    %eax,%edx
 746:	8b 45 f8             	mov    -0x8(%ebp),%eax
 749:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 74c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 74f:	8b 00                	mov    (%eax),%eax
 751:	8b 10                	mov    (%eax),%edx
 753:	8b 45 f8             	mov    -0x8(%ebp),%eax
 756:	89 10                	mov    %edx,(%eax)
 758:	eb 0a                	jmp    764 <free+0x94>
  } else
    bp->s.ptr = p->s.ptr;
 75a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 75d:	8b 10                	mov    (%eax),%edx
 75f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 762:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 764:	8b 45 fc             	mov    -0x4(%ebp),%eax
 767:	8b 40 04             	mov    0x4(%eax),%eax
 76a:	c1 e0 03             	shl    $0x3,%eax
 76d:	03 45 fc             	add    -0x4(%ebp),%eax
 770:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 773:	75 20                	jne    795 <free+0xc5>
    p->s.size += bp->s.size;
 775:	8b 45 fc             	mov    -0x4(%ebp),%eax
 778:	8b 50 04             	mov    0x4(%eax),%edx
 77b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 77e:	8b 40 04             	mov    0x4(%eax),%eax
 781:	01 c2                	add    %eax,%edx
 783:	8b 45 fc             	mov    -0x4(%ebp),%eax
 786:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 789:	8b 45 f8             	mov    -0x8(%ebp),%eax
 78c:	8b 10                	mov    (%eax),%edx
 78e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 791:	89 10                	mov    %edx,(%eax)
 793:	eb 08                	jmp    79d <free+0xcd>
  } else
    p->s.ptr = bp;
 795:	8b 45 fc             	mov    -0x4(%ebp),%eax
 798:	8b 55 f8             	mov    -0x8(%ebp),%edx
 79b:	89 10                	mov    %edx,(%eax)
  freep = p;
 79d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7a0:	a3 d4 0b 00 00       	mov    %eax,0xbd4
}
 7a5:	c9                   	leave  
 7a6:	c3                   	ret    

000007a7 <morecore>:

static Header*
morecore(uint nu)
{
 7a7:	55                   	push   %ebp
 7a8:	89 e5                	mov    %esp,%ebp
 7aa:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 7ad:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 7b4:	77 07                	ja     7bd <morecore+0x16>
    nu = 4096;
 7b6:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 7bd:	8b 45 08             	mov    0x8(%ebp),%eax
 7c0:	c1 e0 03             	shl    $0x3,%eax
 7c3:	89 04 24             	mov    %eax,(%esp)
 7c6:	e8 51 fc ff ff       	call   41c <sbrk>
 7cb:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 7ce:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 7d2:	75 07                	jne    7db <morecore+0x34>
    return 0;
 7d4:	b8 00 00 00 00       	mov    $0x0,%eax
 7d9:	eb 22                	jmp    7fd <morecore+0x56>
  hp = (Header*)p;
 7db:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7de:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 7e1:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7e4:	8b 55 08             	mov    0x8(%ebp),%edx
 7e7:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 7ea:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7ed:	83 c0 08             	add    $0x8,%eax
 7f0:	89 04 24             	mov    %eax,(%esp)
 7f3:	e8 d8 fe ff ff       	call   6d0 <free>
  return freep;
 7f8:	a1 d4 0b 00 00       	mov    0xbd4,%eax
}
 7fd:	c9                   	leave  
 7fe:	c3                   	ret    

000007ff <malloc>:

void*
malloc(uint nbytes)
{
 7ff:	55                   	push   %ebp
 800:	89 e5                	mov    %esp,%ebp
 802:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 805:	8b 45 08             	mov    0x8(%ebp),%eax
 808:	83 c0 07             	add    $0x7,%eax
 80b:	c1 e8 03             	shr    $0x3,%eax
 80e:	83 c0 01             	add    $0x1,%eax
 811:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 814:	a1 d4 0b 00 00       	mov    0xbd4,%eax
 819:	89 45 f0             	mov    %eax,-0x10(%ebp)
 81c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 820:	75 23                	jne    845 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 822:	c7 45 f0 cc 0b 00 00 	movl   $0xbcc,-0x10(%ebp)
 829:	8b 45 f0             	mov    -0x10(%ebp),%eax
 82c:	a3 d4 0b 00 00       	mov    %eax,0xbd4
 831:	a1 d4 0b 00 00       	mov    0xbd4,%eax
 836:	a3 cc 0b 00 00       	mov    %eax,0xbcc
    base.s.size = 0;
 83b:	c7 05 d0 0b 00 00 00 	movl   $0x0,0xbd0
 842:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 845:	8b 45 f0             	mov    -0x10(%ebp),%eax
 848:	8b 00                	mov    (%eax),%eax
 84a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 84d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 850:	8b 40 04             	mov    0x4(%eax),%eax
 853:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 856:	72 4d                	jb     8a5 <malloc+0xa6>
      if(p->s.size == nunits)
 858:	8b 45 f4             	mov    -0xc(%ebp),%eax
 85b:	8b 40 04             	mov    0x4(%eax),%eax
 85e:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 861:	75 0c                	jne    86f <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 863:	8b 45 f4             	mov    -0xc(%ebp),%eax
 866:	8b 10                	mov    (%eax),%edx
 868:	8b 45 f0             	mov    -0x10(%ebp),%eax
 86b:	89 10                	mov    %edx,(%eax)
 86d:	eb 26                	jmp    895 <malloc+0x96>
      else {
        p->s.size -= nunits;
 86f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 872:	8b 40 04             	mov    0x4(%eax),%eax
 875:	89 c2                	mov    %eax,%edx
 877:	2b 55 ec             	sub    -0x14(%ebp),%edx
 87a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 87d:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 880:	8b 45 f4             	mov    -0xc(%ebp),%eax
 883:	8b 40 04             	mov    0x4(%eax),%eax
 886:	c1 e0 03             	shl    $0x3,%eax
 889:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 88c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 88f:	8b 55 ec             	mov    -0x14(%ebp),%edx
 892:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 895:	8b 45 f0             	mov    -0x10(%ebp),%eax
 898:	a3 d4 0b 00 00       	mov    %eax,0xbd4
      return (void*)(p + 1);
 89d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8a0:	83 c0 08             	add    $0x8,%eax
 8a3:	eb 38                	jmp    8dd <malloc+0xde>
    }
    if(p == freep)
 8a5:	a1 d4 0b 00 00       	mov    0xbd4,%eax
 8aa:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 8ad:	75 1b                	jne    8ca <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 8af:	8b 45 ec             	mov    -0x14(%ebp),%eax
 8b2:	89 04 24             	mov    %eax,(%esp)
 8b5:	e8 ed fe ff ff       	call   7a7 <morecore>
 8ba:	89 45 f4             	mov    %eax,-0xc(%ebp)
 8bd:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 8c1:	75 07                	jne    8ca <malloc+0xcb>
        return 0;
 8c3:	b8 00 00 00 00       	mov    $0x0,%eax
 8c8:	eb 13                	jmp    8dd <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8cd:	89 45 f0             	mov    %eax,-0x10(%ebp)
 8d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8d3:	8b 00                	mov    (%eax),%eax
 8d5:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 8d8:	e9 70 ff ff ff       	jmp    84d <malloc+0x4e>
}
 8dd:	c9                   	leave  
 8de:	c3                   	ret    
