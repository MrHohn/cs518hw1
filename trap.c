// #include "types.h"
// #include "defs.h"
// #include "param.h"
// #include "memlayout.h"
// #include "mmu.h"
// #include "proc.h"
// #include "x86.h"
// #include "traps.h"
// #include "spinlock.h"

// // Interrupt descriptor table (shared by all CPUs).
// struct gatedesc idt[256];
// extern uint vectors[];  // in vectors.S: array of 256 entry pointers
// struct spinlock tickslock;
// uint ticks;

// void
// tvinit(void)
// {
//   int i;

//   for(i = 0; i < 256; i++)
//     SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
//   SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
  
//   initlock(&tickslock, "time");
// }

// void
// idtinit(void)
// {
//   lidt(idt, sizeof(idt));
// }

// //PAGEBREAK: 41
// void
// trap(struct trapframe *tf)
// {
//   if(tf->trapno == T_SYSCALL){
//     if(proc->killed)
//       exit();
//     proc->tf = tf;
//     syscall();
//     if(proc->killed)
//       exit();
//     return;
//   }

//   switch(tf->trapno){
//   case T_IRQ0 + IRQ_TIMER:
//     if(cpu->id == 0){
//       acquire(&tickslock);
//       ticks++;
//       wakeup(&ticks);
//       release(&tickslock);
//     }
//     lapiceoi();
//     break;
//   case T_IRQ0 + IRQ_IDE:
//     ideintr();
//     lapiceoi();
//     break;
//   case T_IRQ0 + IRQ_IDE+1:
//     // Bochs generates spurious IDE1 interrupts.
//     break;
//   case T_IRQ0 + IRQ_KBD:
//     kbdintr();
//     lapiceoi();
//     break;
//   case T_IRQ0 + IRQ_COM1:
//     uartintr();
//     lapiceoi();
//     break;
//   case T_IRQ0 + 7:
//   case T_IRQ0 + IRQ_SPURIOUS:
//     cprintf("cpu%d: spurious interrupt at %x:%x\n",
//             cpu->id, tf->cs, tf->eip);
//     lapiceoi();
//     break;
   
//   //PAGEBREAK: 13
//   default:
//     if(proc == 0 || (tf->cs&3) == 0){
//       // In kernel, it must be our mistake.
//       cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
//               tf->trapno, cpu->id, tf->eip, rcr2());
//       panic("trap");
//     }
//     // In user space, assume process misbehaved.
//     cprintf("pid %d %s: trap %d err %d on cpu %d "
//             "eip 0x%x addr 0x%x--kill proc\n",
//             proc->pid, proc->name, tf->trapno, tf->err, cpu->id, tf->eip, 
//             rcr2());
//     proc->killed = 1;
//   }

//   // Force process exit if it has been killed and is in user space.
//   // (If it is still executing in the kernel, let it keep running 
//   // until it gets to the regular system call return.)
//   if(proc && proc->killed && (tf->cs&3) == DPL_USER)
//   {
//     cprintf("in trap's killed judging function\n");
//     if(tf->trapno != 0)
//     {
//       exit(); 
//     }
//     else
//     {
//       cprintf("trapno is 0, stop killing the proc, return to self-handler\n");
//       // cprintf("cs %d\n", tf->cs);
//       tf->eip = 0x11;
//       proc->killed = 0;
//       // tf->eax = 23;
//       // syscall();
//     }
//   }

//   // Force process to give up CPU on clock tick.
//   // If interrupts were on while locks held, would need to check nlock.
//   if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
//     yield();

//   // Check if the process has been killed since we yielded
//   if(proc && proc->killed && (tf->cs&3) == DPL_USER)
//     exit();
// }






#include "types.h"
#include "defs.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"
#include "x86.h"
#include "traps.h"
#include "spinlock.h"

// Interrupt descriptor table (shared by all CPUs).
struct gatedesc idt[256];
extern uint vectors[];  // in vectors.S: array of 256 entry pointers
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
  
  initlock(&tickslock, "time");
}

void
idtinit(void)
{
  lidt(idt, sizeof(idt));
}

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
  if(tf->trapno == T_SYSCALL){
    if(proc->killed)
      exit();
    proc->tf = tf;
    syscall();
    if(proc->killed)
      exit();
    return;
  }

  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpu->id == 0){
      acquire(&tickslock);
      ticks++;
      wakeup(&ticks);
      release(&tickslock);
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
  case T_IRQ0 + IRQ_KBD:
    kbdintr();
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_COM1:
    uartintr();
    lapiceoi();
    break;
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
            cpu->id, tf->cs, tf->eip);
    lapiceoi();
    break;
  case T_DIVIDE:
    if(proc->signum== 23)
    {
      cprintf("trapno is T_DIVIDE = 0\n");
      cprintf("exception for this trapno is on\n");
      cprintf("stop killing the proc, return to self-handler\n");
      tf->eip = proc->handler;
      tf->ebp = proc->fakeebp;
      tf->esp = proc->fakeesp;
      // int *num = (int *)(tf->ebp + 0x08);
      // uint ebp = tf->ebp;
      // uint esp = tf->esp;
      // ushort ss = tf->ss;
      // cprintf("tf ebp = %d\n", ebp);
      // cprintf("tf esp = %d\n", esp);
      // cprintf("tf ss = %d\n", ss);
      // *num = 0x17;
      // num = tf->ebp;
      // cprintf("tf ebp = %d\n", num);
      // cprintf("proc->record %d\n", proc->record);
      // *num = 0x17;
      // *(tf->esp + 0x08) = 0x17;
      break;
    }
  //PAGEBREAK: 13
  default:
    if(proc == 0 || (tf->cs&3) == 0){
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpu->id, tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpu->id, tf->eip, 
            rcr2());
    proc->killed = 1;
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running 
  // until it gets to the regular system call return.)
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
  {
    // cprintf("in trap's killed judging function\n");
    // if(tf->trapno != 0)
    // {
      exit(); 
    // }
    // else
    // {
    //   cprintf("trapno is 0, stop killing the proc, return to self-handler\n");
    //   // cprintf("cs %d\n", tf->cs);
    //   tf->eip = 0x11;
    //   proc->killed = 0;
    //   // tf->eax = 23;
    //   // syscall();
    // }
  }

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
    exit();
}
