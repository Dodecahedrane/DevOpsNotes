---
tags:
  - DevOps
  - Linux
  - Bash
---
Within a [[Bash Scripts]] you can have environment variables. These are global dictionary of key:value pairs that you can add

## Show all environment variables

```bash
printenv
```

Output:

```bash
SSH_CONNECTION=82.38.203.211 64280 10.0.0.70 22
LESSCLOSE=/usr/bin/lesspipe %s %s
LANG=C.UTF-8
XDG_SESSION_ID=5
USER=azureuser
PWD=/home/azureuser
HOME=/home/azureuser
SSH_CLIENT=82.38.203.211 64280 22
XDG_DATA_DIRS=/usr/local/share:/usr/share:/var/lib/snapd/desktop
SSH_TTY=/dev/pts/1
MAIL=/var/mail/azureuser
TERM=xterm-256color
SHELL=/bin/bash
SHLVL=1
LOGNAME=azureuser
DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus
XDG_RUNTIME_DIR=/run/user/1000
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin
LESSOPEN=| /usr/bin/lesspipe %s
_=/usr/bin/printenv
```

## Get Specific Environment Variable

```bash
printenv USER
```

Output

```bash
<username>
```

## Set an Environment Variable

```bash
# this is a variable
MYNAME=oli

# this will make it an enviroment variable
export MYNAME
```

This also works

```bash
export MYNAME=oli
```

Environment Variables are not persistent across sessions or users.

## Set a **Persistent** Environment Variable

To make Environment variables persistent you need to define those variables in the bash configuration files. In most Linux distributions when you start a new session, environment variables are read from `.bashrc`. You can set persistent environment variables in here

```bash
# set some enviroment varibales
export MYNAME=oli
export PERSIST_Var=ThisIsPersistent
```

Add this to the bottom of the file (using Nano or some other CLI editor) and those environment variables will be persistent across terminal/shell sessions for you (as in, just this **user**)

If you want to apply this to the current session run

```bash
source .bashrc
```

``