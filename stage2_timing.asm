
_stage2_timing:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:

void handle_signal(int);


int main(int argc, char *argv[])
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 e4 f0             	and    $0xfffffff0,%esp
   6:	83 ec 30             	sub    $0x30,%esp
	int x = 5;
   9:	c7 44 24 2c 05 00 00 	movl   $0x5,0x2c(%esp)
  10:	00 
	int y = 0;
  11:	c7 44 24 28 00 00 00 	movl   $0x0,0x28(%esp)
  18:	00 
	int begin, end;
	int counts = count;
  19:	a1 60 0b 00 00       	mov    0xb60,%eax
  1e:	89 44 24 24          	mov    %eax,0x24(%esp)

	// printf(1, "anything\n");

	signal(SIGFPE, handle_signal);
  22:	c7 44 24 04 d5 00 00 	movl   $0xd5,0x4(%esp)
  29:	00 
  2a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  31:	e8 ce 03 00 00       	call   404 <signal>

	// printf(1, "anything\n");
	
	begin = uptime();
  36:	e8 b9 03 00 00       	call   3f4 <uptime>
  3b:	89 44 24 20          	mov    %eax,0x20(%esp)
	// printf(1, "The clock cycle now is: %d\n", begin);	
	x = x / y;
  3f:	8b 44 24 2c          	mov    0x2c(%esp),%eax
  43:	89 c2                	mov    %eax,%edx
  45:	c1 fa 1f             	sar    $0x1f,%edx
  48:	f7 7c 24 28          	idivl  0x28(%esp)
  4c:	89 44 24 2c          	mov    %eax,0x2c(%esp)
	end = uptime();
  50:	e8 9f 03 00 00       	call   3f4 <uptime>
  55:	89 44 24 1c          	mov    %eax,0x1c(%esp)

	// printf(1, "The clock cycle now is: %d\n", end);	
	printf(1, "Traps Performed: %d times\n", counts);
  59:	8b 44 24 24          	mov    0x24(%esp),%eax
  5d:	89 44 24 08          	mov    %eax,0x8(%esp)
  61:	c7 44 24 04 a7 08 00 	movl   $0x8a7,0x4(%esp)
  68:	00 
  69:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  70:	e8 6e 04 00 00       	call   4e3 <printf>
	printf(1, "Total Elapsed Time: %d us\n", (end - begin) * 4348);
  75:	8b 44 24 20          	mov    0x20(%esp),%eax
  79:	8b 54 24 1c          	mov    0x1c(%esp),%edx
  7d:	89 d1                	mov    %edx,%ecx
  7f:	29 c1                	sub    %eax,%ecx
  81:	89 c8                	mov    %ecx,%eax
  83:	69 c0 fc 10 00 00    	imul   $0x10fc,%eax,%eax
  89:	89 44 24 08          	mov    %eax,0x8(%esp)
  8d:	c7 44 24 04 c2 08 00 	movl   $0x8c2,0x4(%esp)
  94:	00 
  95:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  9c:	e8 42 04 00 00       	call   4e3 <printf>
	printf(1, "Average Time Per Trap: %d us\n", (end - begin) / counts);
  a1:	8b 44 24 20          	mov    0x20(%esp),%eax
  a5:	8b 54 24 1c          	mov    0x1c(%esp),%edx
  a9:	89 d1                	mov    %edx,%ecx
  ab:	29 c1                	sub    %eax,%ecx
  ad:	89 c8                	mov    %ecx,%eax
  af:	89 c2                	mov    %eax,%edx
  b1:	c1 fa 1f             	sar    $0x1f,%edx
  b4:	f7 7c 24 24          	idivl  0x24(%esp)
  b8:	89 44 24 08          	mov    %eax,0x8(%esp)
  bc:	c7 44 24 04 dd 08 00 	movl   $0x8dd,0x4(%esp)
  c3:	00 
  c4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  cb:	e8 13 04 00 00       	call   4e3 <printf>

	exit();
  d0:	e8 87 02 00 00       	call   35c <exit>

000000d5 <handle_signal>:
}

void handle_signal(int signum)
{
  d5:	55                   	push   %ebp
  d6:	89 e5                	mov    %esp,%ebp
	// printf(1, "inside self handler\n");
	// printf(1, "modify the return address\n");
	// printf(1, "count = %d\n", count);
	--count;
  d8:	a1 60 0b 00 00       	mov    0xb60,%eax
  dd:	83 e8 01             	sub    $0x1,%eax
  e0:	a3 60 0b 00 00       	mov    %eax,0xb60
	if(!count)
  e5:	a1 60 0b 00 00       	mov    0xb60,%eax
  ea:	85 c0                	test   %eax,%eax
  ec:	75 07                	jne    f5 <handle_signal+0x20>
	{
		__asm__ ("movl $0x50,4(%ebp)\n\t");
  ee:	c7 45 04 50 00 00 00 	movl   $0x50,0x4(%ebp)
	}
  f5:	5d                   	pop    %ebp
  f6:	c3                   	ret    
  f7:	90                   	nop

000000f8 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  f8:	55                   	push   %ebp
  f9:	89 e5                	mov    %esp,%ebp
  fb:	57                   	push   %edi
  fc:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  fd:	8b 4d 08             	mov    0x8(%ebp),%ecx
 100:	8b 55 10             	mov    0x10(%ebp),%edx
 103:	8b 45 0c             	mov    0xc(%ebp),%eax
 106:	89 cb                	mov    %ecx,%ebx
 108:	89 df                	mov    %ebx,%edi
 10a:	89 d1                	mov    %edx,%ecx
 10c:	fc                   	cld    
 10d:	f3 aa                	rep stos %al,%es:(%edi)
 10f:	89 ca                	mov    %ecx,%edx
 111:	89 fb                	mov    %edi,%ebx
 113:	89 5d 08             	mov    %ebx,0x8(%ebp)
 116:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 119:	5b                   	pop    %ebx
 11a:	5f                   	pop    %edi
 11b:	5d                   	pop    %ebp
 11c:	c3                   	ret    

0000011d <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 11d:	55                   	push   %ebp
 11e:	89 e5                	mov    %esp,%ebp
 120:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 123:	8b 45 08             	mov    0x8(%ebp),%eax
 126:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 129:	90                   	nop
 12a:	8b 45 0c             	mov    0xc(%ebp),%eax
 12d:	0f b6 10             	movzbl (%eax),%edx
 130:	8b 45 08             	mov    0x8(%ebp),%eax
 133:	88 10                	mov    %dl,(%eax)
 135:	8b 45 08             	mov    0x8(%ebp),%eax
 138:	0f b6 00             	movzbl (%eax),%eax
 13b:	84 c0                	test   %al,%al
 13d:	0f 95 c0             	setne  %al
 140:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 144:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
 148:	84 c0                	test   %al,%al
 14a:	75 de                	jne    12a <strcpy+0xd>
    ;
  return os;
 14c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 14f:	c9                   	leave  
 150:	c3                   	ret    

00000151 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 151:	55                   	push   %ebp
 152:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 154:	eb 08                	jmp    15e <strcmp+0xd>
    p++, q++;
 156:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 15a:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 15e:	8b 45 08             	mov    0x8(%ebp),%eax
 161:	0f b6 00             	movzbl (%eax),%eax
 164:	84 c0                	test   %al,%al
 166:	74 10                	je     178 <strcmp+0x27>
 168:	8b 45 08             	mov    0x8(%ebp),%eax
 16b:	0f b6 10             	movzbl (%eax),%edx
 16e:	8b 45 0c             	mov    0xc(%ebp),%eax
 171:	0f b6 00             	movzbl (%eax),%eax
 174:	38 c2                	cmp    %al,%dl
 176:	74 de                	je     156 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 178:	8b 45 08             	mov    0x8(%ebp),%eax
 17b:	0f b6 00             	movzbl (%eax),%eax
 17e:	0f b6 d0             	movzbl %al,%edx
 181:	8b 45 0c             	mov    0xc(%ebp),%eax
 184:	0f b6 00             	movzbl (%eax),%eax
 187:	0f b6 c0             	movzbl %al,%eax
 18a:	89 d1                	mov    %edx,%ecx
 18c:	29 c1                	sub    %eax,%ecx
 18e:	89 c8                	mov    %ecx,%eax
}
 190:	5d                   	pop    %ebp
 191:	c3                   	ret    

00000192 <strlen>:

uint
strlen(char *s)
{
 192:	55                   	push   %ebp
 193:	89 e5                	mov    %esp,%ebp
 195:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 198:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 19f:	eb 04                	jmp    1a5 <strlen+0x13>
 1a1:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 1a5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 1a8:	03 45 08             	add    0x8(%ebp),%eax
 1ab:	0f b6 00             	movzbl (%eax),%eax
 1ae:	84 c0                	test   %al,%al
 1b0:	75 ef                	jne    1a1 <strlen+0xf>
    ;
  return n;
 1b2:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 1b5:	c9                   	leave  
 1b6:	c3                   	ret    

000001b7 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1b7:	55                   	push   %ebp
 1b8:	89 e5                	mov    %esp,%ebp
 1ba:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
 1bd:	8b 45 10             	mov    0x10(%ebp),%eax
 1c0:	89 44 24 08          	mov    %eax,0x8(%esp)
 1c4:	8b 45 0c             	mov    0xc(%ebp),%eax
 1c7:	89 44 24 04          	mov    %eax,0x4(%esp)
 1cb:	8b 45 08             	mov    0x8(%ebp),%eax
 1ce:	89 04 24             	mov    %eax,(%esp)
 1d1:	e8 22 ff ff ff       	call   f8 <stosb>
  return dst;
 1d6:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1d9:	c9                   	leave  
 1da:	c3                   	ret    

000001db <strchr>:

char*
strchr(const char *s, char c)
{
 1db:	55                   	push   %ebp
 1dc:	89 e5                	mov    %esp,%ebp
 1de:	83 ec 04             	sub    $0x4,%esp
 1e1:	8b 45 0c             	mov    0xc(%ebp),%eax
 1e4:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 1e7:	eb 14                	jmp    1fd <strchr+0x22>
    if(*s == c)
 1e9:	8b 45 08             	mov    0x8(%ebp),%eax
 1ec:	0f b6 00             	movzbl (%eax),%eax
 1ef:	3a 45 fc             	cmp    -0x4(%ebp),%al
 1f2:	75 05                	jne    1f9 <strchr+0x1e>
      return (char*)s;
 1f4:	8b 45 08             	mov    0x8(%ebp),%eax
 1f7:	eb 13                	jmp    20c <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 1f9:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 1fd:	8b 45 08             	mov    0x8(%ebp),%eax
 200:	0f b6 00             	movzbl (%eax),%eax
 203:	84 c0                	test   %al,%al
 205:	75 e2                	jne    1e9 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 207:	b8 00 00 00 00       	mov    $0x0,%eax
}
 20c:	c9                   	leave  
 20d:	c3                   	ret    

0000020e <gets>:

char*
gets(char *buf, int max)
{
 20e:	55                   	push   %ebp
 20f:	89 e5                	mov    %esp,%ebp
 211:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 214:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 21b:	eb 44                	jmp    261 <gets+0x53>
    cc = read(0, &c, 1);
 21d:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 224:	00 
 225:	8d 45 ef             	lea    -0x11(%ebp),%eax
 228:	89 44 24 04          	mov    %eax,0x4(%esp)
 22c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 233:	e8 3c 01 00 00       	call   374 <read>
 238:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 23b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 23f:	7e 2d                	jle    26e <gets+0x60>
      break;
    buf[i++] = c;
 241:	8b 45 f4             	mov    -0xc(%ebp),%eax
 244:	03 45 08             	add    0x8(%ebp),%eax
 247:	0f b6 55 ef          	movzbl -0x11(%ebp),%edx
 24b:	88 10                	mov    %dl,(%eax)
 24d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(c == '\n' || c == '\r')
 251:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 255:	3c 0a                	cmp    $0xa,%al
 257:	74 16                	je     26f <gets+0x61>
 259:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 25d:	3c 0d                	cmp    $0xd,%al
 25f:	74 0e                	je     26f <gets+0x61>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 261:	8b 45 f4             	mov    -0xc(%ebp),%eax
 264:	83 c0 01             	add    $0x1,%eax
 267:	3b 45 0c             	cmp    0xc(%ebp),%eax
 26a:	7c b1                	jl     21d <gets+0xf>
 26c:	eb 01                	jmp    26f <gets+0x61>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 26e:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 26f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 272:	03 45 08             	add    0x8(%ebp),%eax
 275:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 278:	8b 45 08             	mov    0x8(%ebp),%eax
}
 27b:	c9                   	leave  
 27c:	c3                   	ret    

0000027d <stat>:

int
stat(char *n, struct stat *st)
{
 27d:	55                   	push   %ebp
 27e:	89 e5                	mov    %esp,%ebp
 280:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 283:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 28a:	00 
 28b:	8b 45 08             	mov    0x8(%ebp),%eax
 28e:	89 04 24             	mov    %eax,(%esp)
 291:	e8 06 01 00 00       	call   39c <open>
 296:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 299:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 29d:	79 07                	jns    2a6 <stat+0x29>
    return -1;
 29f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 2a4:	eb 23                	jmp    2c9 <stat+0x4c>
  r = fstat(fd, st);
 2a6:	8b 45 0c             	mov    0xc(%ebp),%eax
 2a9:	89 44 24 04          	mov    %eax,0x4(%esp)
 2ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
 2b0:	89 04 24             	mov    %eax,(%esp)
 2b3:	e8 fc 00 00 00       	call   3b4 <fstat>
 2b8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 2bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
 2be:	89 04 24             	mov    %eax,(%esp)
 2c1:	e8 be 00 00 00       	call   384 <close>
  return r;
 2c6:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 2c9:	c9                   	leave  
 2ca:	c3                   	ret    

000002cb <atoi>:

int
atoi(const char *s)
{
 2cb:	55                   	push   %ebp
 2cc:	89 e5                	mov    %esp,%ebp
 2ce:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 2d1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 2d8:	eb 23                	jmp    2fd <atoi+0x32>
    n = n*10 + *s++ - '0';
 2da:	8b 55 fc             	mov    -0x4(%ebp),%edx
 2dd:	89 d0                	mov    %edx,%eax
 2df:	c1 e0 02             	shl    $0x2,%eax
 2e2:	01 d0                	add    %edx,%eax
 2e4:	01 c0                	add    %eax,%eax
 2e6:	89 c2                	mov    %eax,%edx
 2e8:	8b 45 08             	mov    0x8(%ebp),%eax
 2eb:	0f b6 00             	movzbl (%eax),%eax
 2ee:	0f be c0             	movsbl %al,%eax
 2f1:	01 d0                	add    %edx,%eax
 2f3:	83 e8 30             	sub    $0x30,%eax
 2f6:	89 45 fc             	mov    %eax,-0x4(%ebp)
 2f9:	83 45 08 01          	addl   $0x1,0x8(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2fd:	8b 45 08             	mov    0x8(%ebp),%eax
 300:	0f b6 00             	movzbl (%eax),%eax
 303:	3c 2f                	cmp    $0x2f,%al
 305:	7e 0a                	jle    311 <atoi+0x46>
 307:	8b 45 08             	mov    0x8(%ebp),%eax
 30a:	0f b6 00             	movzbl (%eax),%eax
 30d:	3c 39                	cmp    $0x39,%al
 30f:	7e c9                	jle    2da <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 311:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 314:	c9                   	leave  
 315:	c3                   	ret    

00000316 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 316:	55                   	push   %ebp
 317:	89 e5                	mov    %esp,%ebp
 319:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 31c:	8b 45 08             	mov    0x8(%ebp),%eax
 31f:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 322:	8b 45 0c             	mov    0xc(%ebp),%eax
 325:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 328:	eb 13                	jmp    33d <memmove+0x27>
    *dst++ = *src++;
 32a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 32d:	0f b6 10             	movzbl (%eax),%edx
 330:	8b 45 fc             	mov    -0x4(%ebp),%eax
 333:	88 10                	mov    %dl,(%eax)
 335:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 339:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 33d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
 341:	0f 9f c0             	setg   %al
 344:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
 348:	84 c0                	test   %al,%al
 34a:	75 de                	jne    32a <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 34c:	8b 45 08             	mov    0x8(%ebp),%eax
}
 34f:	c9                   	leave  
 350:	c3                   	ret    
 351:	90                   	nop
 352:	90                   	nop
 353:	90                   	nop

00000354 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 354:	b8 01 00 00 00       	mov    $0x1,%eax
 359:	cd 40                	int    $0x40
 35b:	c3                   	ret    

0000035c <exit>:
SYSCALL(exit)
 35c:	b8 02 00 00 00       	mov    $0x2,%eax
 361:	cd 40                	int    $0x40
 363:	c3                   	ret    

00000364 <wait>:
SYSCALL(wait)
 364:	b8 03 00 00 00       	mov    $0x3,%eax
 369:	cd 40                	int    $0x40
 36b:	c3                   	ret    

0000036c <pipe>:
SYSCALL(pipe)
 36c:	b8 04 00 00 00       	mov    $0x4,%eax
 371:	cd 40                	int    $0x40
 373:	c3                   	ret    

00000374 <read>:
SYSCALL(read)
 374:	b8 05 00 00 00       	mov    $0x5,%eax
 379:	cd 40                	int    $0x40
 37b:	c3                   	ret    

0000037c <write>:
SYSCALL(write)
 37c:	b8 10 00 00 00       	mov    $0x10,%eax
 381:	cd 40                	int    $0x40
 383:	c3                   	ret    

00000384 <close>:
SYSCALL(close)
 384:	b8 15 00 00 00       	mov    $0x15,%eax
 389:	cd 40                	int    $0x40
 38b:	c3                   	ret    

0000038c <kill>:
SYSCALL(kill)
 38c:	b8 06 00 00 00       	mov    $0x6,%eax
 391:	cd 40                	int    $0x40
 393:	c3                   	ret    

00000394 <exec>:
SYSCALL(exec)
 394:	b8 07 00 00 00       	mov    $0x7,%eax
 399:	cd 40                	int    $0x40
 39b:	c3                   	ret    

0000039c <open>:
SYSCALL(open)
 39c:	b8 0f 00 00 00       	mov    $0xf,%eax
 3a1:	cd 40                	int    $0x40
 3a3:	c3                   	ret    

000003a4 <mknod>:
SYSCALL(mknod)
 3a4:	b8 11 00 00 00       	mov    $0x11,%eax
 3a9:	cd 40                	int    $0x40
 3ab:	c3                   	ret    

000003ac <unlink>:
SYSCALL(unlink)
 3ac:	b8 12 00 00 00       	mov    $0x12,%eax
 3b1:	cd 40                	int    $0x40
 3b3:	c3                   	ret    

000003b4 <fstat>:
SYSCALL(fstat)
 3b4:	b8 08 00 00 00       	mov    $0x8,%eax
 3b9:	cd 40                	int    $0x40
 3bb:	c3                   	ret    

000003bc <link>:
SYSCALL(link)
 3bc:	b8 13 00 00 00       	mov    $0x13,%eax
 3c1:	cd 40                	int    $0x40
 3c3:	c3                   	ret    

000003c4 <mkdir>:
SYSCALL(mkdir)
 3c4:	b8 14 00 00 00       	mov    $0x14,%eax
 3c9:	cd 40                	int    $0x40
 3cb:	c3                   	ret    

000003cc <chdir>:
SYSCALL(chdir)
 3cc:	b8 09 00 00 00       	mov    $0x9,%eax
 3d1:	cd 40                	int    $0x40
 3d3:	c3                   	ret    

000003d4 <dup>:
SYSCALL(dup)
 3d4:	b8 0a 00 00 00       	mov    $0xa,%eax
 3d9:	cd 40                	int    $0x40
 3db:	c3                   	ret    

000003dc <getpid>:
SYSCALL(getpid)
 3dc:	b8 0b 00 00 00       	mov    $0xb,%eax
 3e1:	cd 40                	int    $0x40
 3e3:	c3                   	ret    

000003e4 <sbrk>:
SYSCALL(sbrk)
 3e4:	b8 0c 00 00 00       	mov    $0xc,%eax
 3e9:	cd 40                	int    $0x40
 3eb:	c3                   	ret    

000003ec <sleep>:
SYSCALL(sleep)
 3ec:	b8 0d 00 00 00       	mov    $0xd,%eax
 3f1:	cd 40                	int    $0x40
 3f3:	c3                   	ret    

000003f4 <uptime>:
SYSCALL(uptime)
 3f4:	b8 0e 00 00 00       	mov    $0xe,%eax
 3f9:	cd 40                	int    $0x40
 3fb:	c3                   	ret    

000003fc <halt>:
SYSCALL(halt)
 3fc:	b8 16 00 00 00       	mov    $0x16,%eax
 401:	cd 40                	int    $0x40
 403:	c3                   	ret    

00000404 <signal>:
 404:	b8 17 00 00 00       	mov    $0x17,%eax
 409:	cd 40                	int    $0x40
 40b:	c3                   	ret    

0000040c <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 40c:	55                   	push   %ebp
 40d:	89 e5                	mov    %esp,%ebp
 40f:	83 ec 28             	sub    $0x28,%esp
 412:	8b 45 0c             	mov    0xc(%ebp),%eax
 415:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 418:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 41f:	00 
 420:	8d 45 f4             	lea    -0xc(%ebp),%eax
 423:	89 44 24 04          	mov    %eax,0x4(%esp)
 427:	8b 45 08             	mov    0x8(%ebp),%eax
 42a:	89 04 24             	mov    %eax,(%esp)
 42d:	e8 4a ff ff ff       	call   37c <write>
}
 432:	c9                   	leave  
 433:	c3                   	ret    

00000434 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 434:	55                   	push   %ebp
 435:	89 e5                	mov    %esp,%ebp
 437:	83 ec 48             	sub    $0x48,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 43a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 441:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 445:	74 17                	je     45e <printint+0x2a>
 447:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 44b:	79 11                	jns    45e <printint+0x2a>
    neg = 1;
 44d:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 454:	8b 45 0c             	mov    0xc(%ebp),%eax
 457:	f7 d8                	neg    %eax
 459:	89 45 ec             	mov    %eax,-0x14(%ebp)
 45c:	eb 06                	jmp    464 <printint+0x30>
  } else {
    x = xx;
 45e:	8b 45 0c             	mov    0xc(%ebp),%eax
 461:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 464:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 46b:	8b 4d 10             	mov    0x10(%ebp),%ecx
 46e:	8b 45 ec             	mov    -0x14(%ebp),%eax
 471:	ba 00 00 00 00       	mov    $0x0,%edx
 476:	f7 f1                	div    %ecx
 478:	89 d0                	mov    %edx,%eax
 47a:	0f b6 90 64 0b 00 00 	movzbl 0xb64(%eax),%edx
 481:	8d 45 dc             	lea    -0x24(%ebp),%eax
 484:	03 45 f4             	add    -0xc(%ebp),%eax
 487:	88 10                	mov    %dl,(%eax)
 489:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  }while((x /= base) != 0);
 48d:	8b 55 10             	mov    0x10(%ebp),%edx
 490:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 493:	8b 45 ec             	mov    -0x14(%ebp),%eax
 496:	ba 00 00 00 00       	mov    $0x0,%edx
 49b:	f7 75 d4             	divl   -0x2c(%ebp)
 49e:	89 45 ec             	mov    %eax,-0x14(%ebp)
 4a1:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 4a5:	75 c4                	jne    46b <printint+0x37>
  if(neg)
 4a7:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 4ab:	74 2a                	je     4d7 <printint+0xa3>
    buf[i++] = '-';
 4ad:	8d 45 dc             	lea    -0x24(%ebp),%eax
 4b0:	03 45 f4             	add    -0xc(%ebp),%eax
 4b3:	c6 00 2d             	movb   $0x2d,(%eax)
 4b6:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)

  while(--i >= 0)
 4ba:	eb 1b                	jmp    4d7 <printint+0xa3>
    putc(fd, buf[i]);
 4bc:	8d 45 dc             	lea    -0x24(%ebp),%eax
 4bf:	03 45 f4             	add    -0xc(%ebp),%eax
 4c2:	0f b6 00             	movzbl (%eax),%eax
 4c5:	0f be c0             	movsbl %al,%eax
 4c8:	89 44 24 04          	mov    %eax,0x4(%esp)
 4cc:	8b 45 08             	mov    0x8(%ebp),%eax
 4cf:	89 04 24             	mov    %eax,(%esp)
 4d2:	e8 35 ff ff ff       	call   40c <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 4d7:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 4db:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 4df:	79 db                	jns    4bc <printint+0x88>
    putc(fd, buf[i]);
}
 4e1:	c9                   	leave  
 4e2:	c3                   	ret    

000004e3 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 4e3:	55                   	push   %ebp
 4e4:	89 e5                	mov    %esp,%ebp
 4e6:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 4e9:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 4f0:	8d 45 0c             	lea    0xc(%ebp),%eax
 4f3:	83 c0 04             	add    $0x4,%eax
 4f6:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 4f9:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 500:	e9 7d 01 00 00       	jmp    682 <printf+0x19f>
    c = fmt[i] & 0xff;
 505:	8b 55 0c             	mov    0xc(%ebp),%edx
 508:	8b 45 f0             	mov    -0x10(%ebp),%eax
 50b:	01 d0                	add    %edx,%eax
 50d:	0f b6 00             	movzbl (%eax),%eax
 510:	0f be c0             	movsbl %al,%eax
 513:	25 ff 00 00 00       	and    $0xff,%eax
 518:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 51b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 51f:	75 2c                	jne    54d <printf+0x6a>
      if(c == '%'){
 521:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 525:	75 0c                	jne    533 <printf+0x50>
        state = '%';
 527:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 52e:	e9 4b 01 00 00       	jmp    67e <printf+0x19b>
      } else {
        putc(fd, c);
 533:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 536:	0f be c0             	movsbl %al,%eax
 539:	89 44 24 04          	mov    %eax,0x4(%esp)
 53d:	8b 45 08             	mov    0x8(%ebp),%eax
 540:	89 04 24             	mov    %eax,(%esp)
 543:	e8 c4 fe ff ff       	call   40c <putc>
 548:	e9 31 01 00 00       	jmp    67e <printf+0x19b>
      }
    } else if(state == '%'){
 54d:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 551:	0f 85 27 01 00 00    	jne    67e <printf+0x19b>
      if(c == 'd'){
 557:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 55b:	75 2d                	jne    58a <printf+0xa7>
        printint(fd, *ap, 10, 1);
 55d:	8b 45 e8             	mov    -0x18(%ebp),%eax
 560:	8b 00                	mov    (%eax),%eax
 562:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 569:	00 
 56a:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 571:	00 
 572:	89 44 24 04          	mov    %eax,0x4(%esp)
 576:	8b 45 08             	mov    0x8(%ebp),%eax
 579:	89 04 24             	mov    %eax,(%esp)
 57c:	e8 b3 fe ff ff       	call   434 <printint>
        ap++;
 581:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 585:	e9 ed 00 00 00       	jmp    677 <printf+0x194>
      } else if(c == 'x' || c == 'p'){
 58a:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 58e:	74 06                	je     596 <printf+0xb3>
 590:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 594:	75 2d                	jne    5c3 <printf+0xe0>
        printint(fd, *ap, 16, 0);
 596:	8b 45 e8             	mov    -0x18(%ebp),%eax
 599:	8b 00                	mov    (%eax),%eax
 59b:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 5a2:	00 
 5a3:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 5aa:	00 
 5ab:	89 44 24 04          	mov    %eax,0x4(%esp)
 5af:	8b 45 08             	mov    0x8(%ebp),%eax
 5b2:	89 04 24             	mov    %eax,(%esp)
 5b5:	e8 7a fe ff ff       	call   434 <printint>
        ap++;
 5ba:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5be:	e9 b4 00 00 00       	jmp    677 <printf+0x194>
      } else if(c == 's'){
 5c3:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 5c7:	75 46                	jne    60f <printf+0x12c>
        s = (char*)*ap;
 5c9:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5cc:	8b 00                	mov    (%eax),%eax
 5ce:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 5d1:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 5d5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 5d9:	75 27                	jne    602 <printf+0x11f>
          s = "(null)";
 5db:	c7 45 f4 fb 08 00 00 	movl   $0x8fb,-0xc(%ebp)
        while(*s != 0){
 5e2:	eb 1e                	jmp    602 <printf+0x11f>
          putc(fd, *s);
 5e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5e7:	0f b6 00             	movzbl (%eax),%eax
 5ea:	0f be c0             	movsbl %al,%eax
 5ed:	89 44 24 04          	mov    %eax,0x4(%esp)
 5f1:	8b 45 08             	mov    0x8(%ebp),%eax
 5f4:	89 04 24             	mov    %eax,(%esp)
 5f7:	e8 10 fe ff ff       	call   40c <putc>
          s++;
 5fc:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 600:	eb 01                	jmp    603 <printf+0x120>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 602:	90                   	nop
 603:	8b 45 f4             	mov    -0xc(%ebp),%eax
 606:	0f b6 00             	movzbl (%eax),%eax
 609:	84 c0                	test   %al,%al
 60b:	75 d7                	jne    5e4 <printf+0x101>
 60d:	eb 68                	jmp    677 <printf+0x194>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 60f:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 613:	75 1d                	jne    632 <printf+0x14f>
        putc(fd, *ap);
 615:	8b 45 e8             	mov    -0x18(%ebp),%eax
 618:	8b 00                	mov    (%eax),%eax
 61a:	0f be c0             	movsbl %al,%eax
 61d:	89 44 24 04          	mov    %eax,0x4(%esp)
 621:	8b 45 08             	mov    0x8(%ebp),%eax
 624:	89 04 24             	mov    %eax,(%esp)
 627:	e8 e0 fd ff ff       	call   40c <putc>
        ap++;
 62c:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 630:	eb 45                	jmp    677 <printf+0x194>
      } else if(c == '%'){
 632:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 636:	75 17                	jne    64f <printf+0x16c>
        putc(fd, c);
 638:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 63b:	0f be c0             	movsbl %al,%eax
 63e:	89 44 24 04          	mov    %eax,0x4(%esp)
 642:	8b 45 08             	mov    0x8(%ebp),%eax
 645:	89 04 24             	mov    %eax,(%esp)
 648:	e8 bf fd ff ff       	call   40c <putc>
 64d:	eb 28                	jmp    677 <printf+0x194>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 64f:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 656:	00 
 657:	8b 45 08             	mov    0x8(%ebp),%eax
 65a:	89 04 24             	mov    %eax,(%esp)
 65d:	e8 aa fd ff ff       	call   40c <putc>
        putc(fd, c);
 662:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 665:	0f be c0             	movsbl %al,%eax
 668:	89 44 24 04          	mov    %eax,0x4(%esp)
 66c:	8b 45 08             	mov    0x8(%ebp),%eax
 66f:	89 04 24             	mov    %eax,(%esp)
 672:	e8 95 fd ff ff       	call   40c <putc>
      }
      state = 0;
 677:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 67e:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 682:	8b 55 0c             	mov    0xc(%ebp),%edx
 685:	8b 45 f0             	mov    -0x10(%ebp),%eax
 688:	01 d0                	add    %edx,%eax
 68a:	0f b6 00             	movzbl (%eax),%eax
 68d:	84 c0                	test   %al,%al
 68f:	0f 85 70 fe ff ff    	jne    505 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 695:	c9                   	leave  
 696:	c3                   	ret    
 697:	90                   	nop

00000698 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 698:	55                   	push   %ebp
 699:	89 e5                	mov    %esp,%ebp
 69b:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 69e:	8b 45 08             	mov    0x8(%ebp),%eax
 6a1:	83 e8 08             	sub    $0x8,%eax
 6a4:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6a7:	a1 80 0b 00 00       	mov    0xb80,%eax
 6ac:	89 45 fc             	mov    %eax,-0x4(%ebp)
 6af:	eb 24                	jmp    6d5 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6b1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6b4:	8b 00                	mov    (%eax),%eax
 6b6:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 6b9:	77 12                	ja     6cd <free+0x35>
 6bb:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6be:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 6c1:	77 24                	ja     6e7 <free+0x4f>
 6c3:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6c6:	8b 00                	mov    (%eax),%eax
 6c8:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6cb:	77 1a                	ja     6e7 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6cd:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6d0:	8b 00                	mov    (%eax),%eax
 6d2:	89 45 fc             	mov    %eax,-0x4(%ebp)
 6d5:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6d8:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 6db:	76 d4                	jbe    6b1 <free+0x19>
 6dd:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6e0:	8b 00                	mov    (%eax),%eax
 6e2:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6e5:	76 ca                	jbe    6b1 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 6e7:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6ea:	8b 40 04             	mov    0x4(%eax),%eax
 6ed:	c1 e0 03             	shl    $0x3,%eax
 6f0:	89 c2                	mov    %eax,%edx
 6f2:	03 55 f8             	add    -0x8(%ebp),%edx
 6f5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6f8:	8b 00                	mov    (%eax),%eax
 6fa:	39 c2                	cmp    %eax,%edx
 6fc:	75 24                	jne    722 <free+0x8a>
    bp->s.size += p->s.ptr->s.size;
 6fe:	8b 45 f8             	mov    -0x8(%ebp),%eax
 701:	8b 50 04             	mov    0x4(%eax),%edx
 704:	8b 45 fc             	mov    -0x4(%ebp),%eax
 707:	8b 00                	mov    (%eax),%eax
 709:	8b 40 04             	mov    0x4(%eax),%eax
 70c:	01 c2                	add    %eax,%edx
 70e:	8b 45 f8             	mov    -0x8(%ebp),%eax
 711:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 714:	8b 45 fc             	mov    -0x4(%ebp),%eax
 717:	8b 00                	mov    (%eax),%eax
 719:	8b 10                	mov    (%eax),%edx
 71b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 71e:	89 10                	mov    %edx,(%eax)
 720:	eb 0a                	jmp    72c <free+0x94>
  } else
    bp->s.ptr = p->s.ptr;
 722:	8b 45 fc             	mov    -0x4(%ebp),%eax
 725:	8b 10                	mov    (%eax),%edx
 727:	8b 45 f8             	mov    -0x8(%ebp),%eax
 72a:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 72c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 72f:	8b 40 04             	mov    0x4(%eax),%eax
 732:	c1 e0 03             	shl    $0x3,%eax
 735:	03 45 fc             	add    -0x4(%ebp),%eax
 738:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 73b:	75 20                	jne    75d <free+0xc5>
    p->s.size += bp->s.size;
 73d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 740:	8b 50 04             	mov    0x4(%eax),%edx
 743:	8b 45 f8             	mov    -0x8(%ebp),%eax
 746:	8b 40 04             	mov    0x4(%eax),%eax
 749:	01 c2                	add    %eax,%edx
 74b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 74e:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 751:	8b 45 f8             	mov    -0x8(%ebp),%eax
 754:	8b 10                	mov    (%eax),%edx
 756:	8b 45 fc             	mov    -0x4(%ebp),%eax
 759:	89 10                	mov    %edx,(%eax)
 75b:	eb 08                	jmp    765 <free+0xcd>
  } else
    p->s.ptr = bp;
 75d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 760:	8b 55 f8             	mov    -0x8(%ebp),%edx
 763:	89 10                	mov    %edx,(%eax)
  freep = p;
 765:	8b 45 fc             	mov    -0x4(%ebp),%eax
 768:	a3 80 0b 00 00       	mov    %eax,0xb80
}
 76d:	c9                   	leave  
 76e:	c3                   	ret    

0000076f <morecore>:

static Header*
morecore(uint nu)
{
 76f:	55                   	push   %ebp
 770:	89 e5                	mov    %esp,%ebp
 772:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 775:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 77c:	77 07                	ja     785 <morecore+0x16>
    nu = 4096;
 77e:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 785:	8b 45 08             	mov    0x8(%ebp),%eax
 788:	c1 e0 03             	shl    $0x3,%eax
 78b:	89 04 24             	mov    %eax,(%esp)
 78e:	e8 51 fc ff ff       	call   3e4 <sbrk>
 793:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 796:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 79a:	75 07                	jne    7a3 <morecore+0x34>
    return 0;
 79c:	b8 00 00 00 00       	mov    $0x0,%eax
 7a1:	eb 22                	jmp    7c5 <morecore+0x56>
  hp = (Header*)p;
 7a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7a6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 7a9:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7ac:	8b 55 08             	mov    0x8(%ebp),%edx
 7af:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 7b2:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7b5:	83 c0 08             	add    $0x8,%eax
 7b8:	89 04 24             	mov    %eax,(%esp)
 7bb:	e8 d8 fe ff ff       	call   698 <free>
  return freep;
 7c0:	a1 80 0b 00 00       	mov    0xb80,%eax
}
 7c5:	c9                   	leave  
 7c6:	c3                   	ret    

000007c7 <malloc>:

void*
malloc(uint nbytes)
{
 7c7:	55                   	push   %ebp
 7c8:	89 e5                	mov    %esp,%ebp
 7ca:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7cd:	8b 45 08             	mov    0x8(%ebp),%eax
 7d0:	83 c0 07             	add    $0x7,%eax
 7d3:	c1 e8 03             	shr    $0x3,%eax
 7d6:	83 c0 01             	add    $0x1,%eax
 7d9:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 7dc:	a1 80 0b 00 00       	mov    0xb80,%eax
 7e1:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7e4:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 7e8:	75 23                	jne    80d <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 7ea:	c7 45 f0 78 0b 00 00 	movl   $0xb78,-0x10(%ebp)
 7f1:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7f4:	a3 80 0b 00 00       	mov    %eax,0xb80
 7f9:	a1 80 0b 00 00       	mov    0xb80,%eax
 7fe:	a3 78 0b 00 00       	mov    %eax,0xb78
    base.s.size = 0;
 803:	c7 05 7c 0b 00 00 00 	movl   $0x0,0xb7c
 80a:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 80d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 810:	8b 00                	mov    (%eax),%eax
 812:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 815:	8b 45 f4             	mov    -0xc(%ebp),%eax
 818:	8b 40 04             	mov    0x4(%eax),%eax
 81b:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 81e:	72 4d                	jb     86d <malloc+0xa6>
      if(p->s.size == nunits)
 820:	8b 45 f4             	mov    -0xc(%ebp),%eax
 823:	8b 40 04             	mov    0x4(%eax),%eax
 826:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 829:	75 0c                	jne    837 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 82b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 82e:	8b 10                	mov    (%eax),%edx
 830:	8b 45 f0             	mov    -0x10(%ebp),%eax
 833:	89 10                	mov    %edx,(%eax)
 835:	eb 26                	jmp    85d <malloc+0x96>
      else {
        p->s.size -= nunits;
 837:	8b 45 f4             	mov    -0xc(%ebp),%eax
 83a:	8b 40 04             	mov    0x4(%eax),%eax
 83d:	89 c2                	mov    %eax,%edx
 83f:	2b 55 ec             	sub    -0x14(%ebp),%edx
 842:	8b 45 f4             	mov    -0xc(%ebp),%eax
 845:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 848:	8b 45 f4             	mov    -0xc(%ebp),%eax
 84b:	8b 40 04             	mov    0x4(%eax),%eax
 84e:	c1 e0 03             	shl    $0x3,%eax
 851:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 854:	8b 45 f4             	mov    -0xc(%ebp),%eax
 857:	8b 55 ec             	mov    -0x14(%ebp),%edx
 85a:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 85d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 860:	a3 80 0b 00 00       	mov    %eax,0xb80
      return (void*)(p + 1);
 865:	8b 45 f4             	mov    -0xc(%ebp),%eax
 868:	83 c0 08             	add    $0x8,%eax
 86b:	eb 38                	jmp    8a5 <malloc+0xde>
    }
    if(p == freep)
 86d:	a1 80 0b 00 00       	mov    0xb80,%eax
 872:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 875:	75 1b                	jne    892 <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 877:	8b 45 ec             	mov    -0x14(%ebp),%eax
 87a:	89 04 24             	mov    %eax,(%esp)
 87d:	e8 ed fe ff ff       	call   76f <morecore>
 882:	89 45 f4             	mov    %eax,-0xc(%ebp)
 885:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 889:	75 07                	jne    892 <malloc+0xcb>
        return 0;
 88b:	b8 00 00 00 00       	mov    $0x0,%eax
 890:	eb 13                	jmp    8a5 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 892:	8b 45 f4             	mov    -0xc(%ebp),%eax
 895:	89 45 f0             	mov    %eax,-0x10(%ebp)
 898:	8b 45 f4             	mov    -0xc(%ebp),%eax
 89b:	8b 00                	mov    (%eax),%eax
 89d:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 8a0:	e9 70 ff ff ff       	jmp    815 <malloc+0x4e>
}
 8a5:	c9                   	leave  
 8a6:	c3                   	ret    
