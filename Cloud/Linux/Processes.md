---
tags:
  - DevOps
  - Linux
---
## What is a process?

A program that is loaded into memory and is currently running (either actively or idle and waiting)

## Foreground and Background Processes

#### Foreground

Depends on the user for input
Also know as interactive processes
#### Background

Runs independently of the user
Also know as a non interactive process
## View Running Processes

### View User Processes

```bash
ps
```

Output:

```bash
  PID TTY          TIME CMD
 2754 pts/0    00:00:00 bash
 3711 pts/0    00:00:00 ps
```

``PID`` is the Process ID
``TTY`` is the code for the current terminal session it is running in

### View All Process

```bash
ps -e
```

Output

```bash
  PID TTY          TIME CMD
    1 ?        00:00:04 systemd
    2 ?        00:00:00 kthreadd
    3 ?        00:00:00 rcu_gp
    4 ?        00:00:00 rcu_par_gp
    6 ?        00:00:00 kworker/0:0H-kb
    8 ?        00:00:00 mm_percpu_wq
    9 ?        00:00:00 ksoftirqd/0
   10 ?        00:00:00 rcu_sched
   11 ?        00:00:00 migration/0
   13 ?        00:00:00 cpuhp/0
   14 ?        00:00:00 kdevtmpfs
   15 ?        00:00:00 netns
```

Extra Detail

```bash
ps aux
```

Output

```bash
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root         1  0.1  1.0 225512  9232 ?        Ss   10:04   0:04 /sbin/init
root         2  0.0  0.0      0     0 ?        S    10:04   0:00 [kthreadd]
root         3  0.0  0.0      0     0 ?        I<   10:04   0:00 [rcu_gp]
root         4  0.0  0.0      0     0 ?        I<   10:04   0:00 [rcu_par_gp]
root         6  0.0  0.0      0     0 ?        I<   10:04   0:00 [kworker/0:0H-kb]
root         8  0.0  0.0      0     0 ?        I<   10:04   0:00 [mm_percpu_wq]
root         9  0.0  0.0      0     0 ?        S    10:04   0:00 [ksoftirqd/0]
root        10  0.0  0.0      0     0 ?        I    10:04   0:00 [rcu_sched]
root        11  0.0  0.0      0     0 ?        S    10:04   0:00 [migration/0]
root        13  0.0  0.0      0     0 ?        S    10:04   0:00 [cpuhp/0]
root        14  0.0  0.0      0     0 ?        S    10:04   0:00 [kdevtmpfs]
```
### ``top``

top updates every 3 seconds. Press ``d`` to change it

top ranks process via CPU usage

To change this to rank by:
Memory: ``shift+m``
PID; ``shift+n` (Ranks by newest)
CPU; `shift+p`

```bash
top
```

``q`` or ``ctrl+c`` to quit

Output:

```bash
  PID USER      PR  NI    VIRT    RES    SHR S %CPU %MEM     TIME+ COMMAND
 3360 root      20   0       0      0      0 I  0.3  0.0   0:00.21 kworker/u2:0-ev
    1 root      20   0  225512   9232   6660 S  0.0  1.1   0:04.12 systemd
    2 root      20   0       0      0      0 S  0.0  0.0   0:00.00 kthreadd
    3 root       0 -20       0      0      0 I  0.0  0.0   0:00.00 rcu_gp
    4 root       0 -20       0      0      0 I  0.0  0.0   0:00.00 rcu_par_gp
    6 root       0 -20       0      0      0 I  0.0  0.0   0:00.00 kworker/0:0H-kb
    8 root       0 -20       0      0      0 I  0.0  0.0   0:00.00 mm_percpu_wq
    9 root      20   0       0      0      0 S  0.0  0.0   0:00.27 ksoftirqd/0
   10 root      20   0       0      0      0 I  0.0  0.0   0:00.64 rcu_sched
   11 root      rt   0       0      0      0 S  0.0  0.0   0:00.02 migration/0
   13 root      20   0       0      0      0 S  0.0  0.0   0:00.00 cpuhp/0
```

### ``htop``

There is also ``htop`` for a nicer, more interactive and customizable view.

```bash
htop
```

## System Process States

- Running
- Sleeping
	- Interruptible
	- Uninterruptable
- Stopped
- Zombie
## Controlling System Processes

### Sleep

You can put the terminal to 'sleep'

```bash
sleep <number-of-seconds>
```

### Background Processes

```bash
sleep <number-of-seconds> &
```

The ``&`` works on any commands (??????) to make it run in the background

### View Background Processes

To view running commands (that are in the background)

```bash
jobs
```

Output:

```bash
[1]+  Running                 sleep 300 &
```

### Kill Process

The kill command will try to gracefully end running processes, including child processes.

```bash
kill <pid>
```

The default kill is ``-15`` (``SIGTERM``) (see bellow)

Output:

```bash
[1]+  Terminated              sleep 300
```

Be carful to only kill processes you know the function of. If you kill the wrong process it can cause crashes or create zombie processes.

A zombie process is a processes created by another process. If the parent process is 'killed' the child process becomes a zombie as it is no longer being controlled by the parent.

If  `kill` doesn't work (it can be ignored), you may need to `sigkill`

```bash
kill -9 <pid>
```

View all the kill commands/levels with

```bash
kill -L
```

Output

```bash
 1) SIGHUP       2) SIGINT       3) SIGQUIT      4) SIGILL       5) SIGTRAP
 6) SIGABRT      7) SIGBUS       8) SIGFPE       9) SIGKILL     10) SIGUSR1
11) SIGSEGV     12) SIGUSR2     13) SIGPIPE     14) SIGALRM     15) SIGTERM
16) SIGSTKFLT   17) SIGCHLD     18) SIGCONT     19) SIGSTOP     20) SIGTSTP
21) SIGTTIN     22) SIGTTOU     23) SIGURG      24) SIGXCPU     25) SIGXFSZ
26) SIGVTALRM   27) SIGPROF     28) SIGWINCH    29) SIGIO       30) SIGPWR
31) SIGSYS      34) SIGRTMIN    35) SIGRTMIN+1  36) SIGRTMIN+2  37) SIGRTMIN+3
38) SIGRTMIN+4  39) SIGRTMIN+5  40) SIGRTMIN+6  41) SIGRTMIN+7  42) SIGRTMIN+8
43) SIGRTMIN+9  44) SIGRTMIN+10 45) SIGRTMIN+11 46) SIGRTMIN+12 47) SIGRTMIN+13
48) SIGRTMIN+14 49) SIGRTMIN+15 50) SIGRTMAX-14 51) SIGRTMAX-13 52) SIGRTMAX-12
53) SIGRTMAX-11 54) SIGRTMAX-10 55) SIGRTMAX-9  56) SIGRTMAX-8  57) SIGRTMAX-7
58) SIGRTMAX-6  59) SIGRTMAX-5  60) SIGRTMAX-4  61) SIGRTMAX-3  62) SIGRTMAX-2
63) SIGRTMAX-1  64) SIGRTMAX
```

### Process Priority

All processes have a priority between 19 and -20. 0 is the default. This is also known as the ``niceness`` value.

The **lower** the value the higher the priority. (-19 is the highest priority)

Priority effects how much of the system the process can 'hog' (i.e., how *nice* it needs to be to the other processes, more nice (higher value) means less hogging)

Start a new processes with a given priority

```bash
$ nice -n <value> <process>
```

Change the niceness of a running process

```bash
renice <value> -p <PID>
```




