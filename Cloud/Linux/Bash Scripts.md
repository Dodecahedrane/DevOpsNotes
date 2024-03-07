---
tags:
  - Bash
  - DevOps
  - Linux
  - SoftwareEngineering
  - Scripts
---
Shell scripts have the `.sh` extension and can be used to run a series of commands in the [[Linux]] Bash shell.

You make it a bash shell script by adding `#!/bin/bash` to the first line

```shell
#!/bin/bash

# this is a comment

# update
sudo apt update

# upgrade
sudo apt upgrade -y

# install nginx
sudo apt install nginx -y

# restart nginx
sudo systemctl restart nginx

# enable nginx
sudo systemctl enable
```

## Make a shell script runnable

Enable permissions for the script to run

This adds the execute permission to the file

```bash
chmod +x <path-to-script>
```

Run with

```bash
./<path-to-script>
```

### What if the a command brings up a menu?

Some commands, like `apt-get upgrade` will bring up menus that require choices to be made. 

You can do this in your shell script to bypass those choices

```shell
#TODO Find this????
```

## Variables in Scripts

```bash
# this is a variable
MYNAME=oli

# this will print it
echo $MYNAME
```