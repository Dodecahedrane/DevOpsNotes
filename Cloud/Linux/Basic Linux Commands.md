---
tags:
  - Linux
  - DevOps
  - Bash
---
# **[[Linux]] commands are case sensitive!**

![[Linux-Cheat-Sheet-Sponsored-By-Loggly.pdf]]

## The Shell

The shell is a program that takes commands from the keyboard and gives them to the operating system to perform

On most [[Linux]] systems a program called bash (which stands for Bourne Again Shell, an enhanced version of the original Unix shell program, `sh`) acts as the shell program. Besides `bash`, there are other shell programs available for Linux systems. These include: `ksh`, `tcsh` and `zsh`

## Get command history

Press the up arrow to get the previous commands

Or `history` to print the history of commands executed

```bash
azureuser@tech257-oliver-learn-linux-vm:~$ history
    1  clear
    2  ls -a
    3  man ls
    4  exit
    5  clerar
    6  clear
    7  cd
    8  cd ~
    9  ls -a
   10  cd ..
   11  ls -a
   12  cd ..
   13  ls
   14  cd home
   15  cd azureuser/
   16  ls
   17  clear
   18  history
```

The history is persistent with the user, regardless of if they logout or power cycle the VM/Machine
You can clear the history with

```bash
history -c
```

Run a previous command with

```bash
history !<command-number>
```
## Get Help with `man`

```bash
man <command>
```

`man` will give you all details for a specified commands. `man` stands for manual

## Specifying Paths

When typing a path, if the path is in the PWD don't start with `/` as this will do it from the root. Just ignore the `/` for the first folder in the path.

I.e. starting a path with `/` makes it an absolute path (from root), without makes it relative. You can start a path with `~` to make it absolute but from the users home directory

Press tab to auto complete the file paths and names. Double tab will show you all the folders in the current directory when specifying a path.
## Present Working Directory

``pwd`` returns the present working directory
## Change Directory

cd changes directory, use the `~` to navigate from the users home directory

`cd ..` goes back one directory
`cd ~` goes to the home directory or just `cd`

`cd /` takes you to the root

`..` is the parent directory
`.` is the current directory
## List Files

ls lists files in the PWD

use ``ls -a`` to list everything including hidden files
use `ls -l` to list detailed information about the (non hidden) files
use `ls -la` or `ls -al` to list all the details about all the files (including hidden)

**blue** are directories, **white** are files

## Clear Command Line

`clear` removes all the current contents from the terminal

## Combine commands

Use `&&` to combine commands and run them sequentially

```bash
clear && ls -al
```

##  Get contents of a file

`cat` returns the contents of a file

```bash
$ cat file 
line 1
line 2
line 3
line 4
line 5
```

Get top X lines

```bash
head -<num-lines> <file>
```

Get bottom X lines

```bash
tail -<num-lines) <file>
```

Cat but with line numbers

```bash
nl <file-name>
```
## Create a new file

```bash
touch <path-to-new-file-and-file-name>
```

touch create a new file, either specify the path, or just a new file if you want it in the pwd

## Nano (for editing files)

```bash
nano <file)
```

![[Pasted image 20240307112442.png]]

Press `ctrl x` to exit and save.

![[Pasted image 20240307112541.png]]

`Y` to save, `N` to not

![[Pasted image 20240307112610.png]]

Press enter to save over the file, or rename it to save a new copy
## Rename File

```bash
mv <current-name> <new-name>
```
## Copy a file

```bash
cp <file-to-copy> <new-name-and-directory>
```

## Move a file

```bash
mv <file> <new-path-and-name>
```

The new name is optional you can do

```bash
$ tree
.
├── cat.jpg
├── jokes
│   └── jokes.txt
└── pics

2 directories, 2 files
$ mv cat.jpg pics/
$ tree
.
├── jokes
│   └── jokes.txt
└── pics
    └── cat.jpg

2 directories, 2 files
```

### Move to PWD

```bash
mv <path-to-file> ./
```

## Get file type

```bash
$ file cat.jpg
cat.jpg: JPEG image data, baseline, precision 8, 930x620, frames 3
```
## Make Directory

```bash
mkdir <directory-path-and-name> <second-directory-path-and-name>
```

If you want a directory with a space (you don't, but if you *really* do)

```bash
mkdir 'hello world'
```

or 

```bash
mkdir hello\ world
```
## Remove

**Be Careful With Remove**
### Remove file

```bash
rm <file-to-remove>
```

### Remove (empty) directory

```bash
rmdir <directory-to-remove>
```

### Remove directory and its contents

```bash
rm -r <directory>
```


`-rf` force removes directory and its contents forcefully

```bash
rm -rf <directory>
```
## Pipe Command

```bash
command1 | command2
```

- command1: This is the initial command whose output will serve as input to the next command.
- | (pipe symbol): This symbol is the pipe command itself. It facilitates the transfer of output from command1 into command2.
- command2: This is the subsequent command that receives the output of command1 as its input.

Such as 

```bash
ls -l | grep '.txt'
```

## Send command output to a file

Make new file

```bash
<command> > <output_file>  
```

Append to file

```bash
<command> >> <output_file>  
```
## Filtering

Use `grep` to filter files or commands using the pipe `|`

Get the `|` with `shift \` 

```bash
grep 'keyword' <file-name>
```

### ``grep`` with pipe

grep can be used to filter out results from another command. This returns all the files that end in `.txt`

```bash
ls -l | grep '.txt'
```

## ``curl``

`curl <url>` with `-o <file-name-to-save>` or `-O` to save with the current name

```bash
$ curl https://cdn.britannica.com/39/7139-050-A88818BB/Himalayan-chocolate-point.jpg -o cat.jpg
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 71944  100 71944    0     0  1377k      0 --:--:-- --:--:-- --:--:-- 1377k
$ ls
cat.jpg
```
## Install Packages

Install a package with

```bash
sudo apt install <package-name>
```

[[sudo]] is the equivalent of admin on windows, it allows you to perform tasks that modify the system

You may need to run update to update the list of remote packages

```bash
sudo apt update
```

Update packages with

```bash
sudo apt update
```

[apt VS apt-get](https://aws.amazon.com/compare/the-difference-between-apt-and-apt-get/#:~:text=The%20apt%20command%20line%20tool,closely%20with%20core%20Linux%20processes.)

## Tree

### Install Tree
```bash
sudo apt install tree
```

### Tree

Run ``tree`` to see the file structure

```bash
$ tree
.
├── cat.jpg
├── folder1
│   ├── folderA
│   └── folderB
├── folder2
└── joke.txt

4 directories, 2 files
```
## Login as Root

```bash
sudo su
```

## System [[Processes]]

### View Status

```bash
systemctl status <process>
```

Output should look similar to this:

```bash
● nginx.service - A high performance web server and a reverse proxy server
   Loaded: loaded (/lib/systemd/system/nginx.service; enabled; vendor preset: enabled)
   Active: active (running) since Thu 2024-03-07 14:26:58 UTC; 50s ago
     Docs: man:nginx(8)
 Main PID: 3554 (nginx)
    Tasks: 2 (limit: 976)
   CGroup: /system.slice/nginx.service
           ├─3554 nginx: master process /usr/sbin/nginx -g daemon on; master_process on;
           └─3558 nginx: worker process

Mar 07 14:26:58 tech257-oliver-learn-linux-vm systemd[1]: Starting A high performance web server and a reverse proxy server...
Mar 07 14:26:58 tech257-oliver-learn-linux-vm systemd[1]: nginx.service: Failed to parse PID from file /run/nginx.pid: Invalid argument
Mar 07 14:26:58 tech257-oliver-learn-linux-vm systemd[1]: Started A high performance web server and a reverse proxy server.
```

### Restart

```bash
sudo systemctl restart <process>
```

### Start

```bash
sudo systemctl start <process>
```
### Stop

```bash
sudo systemctl stop <process>
```

### Is Enabled

```bash
systemctl is-enabled nginx
```

### Enable Process

```bash
sudo systemctl enable nginx
```

## OS Details

```bash
uname -a
```

Output

```bash
Linux tech257-oliver-linux 6.5.0-1016-azure #16~22.04.1-Ubuntu SMP Fri Feb 16 15:42:02 UTC 2024 x86_64 x86_64 x86_64 GNU/Linux
```

## Modify a line or part of a file with ``sed``

[``sed`` Guide](https://www.digitalocean.com/community/tutorials/the-basics-of-using-the-sed-stream-editor-to-manipulate-text-in-linux)

```bash
sed [options] commands [file-to-edit]
```

```bash
sudo sed -i "s@try_files \$uri \$uri/ =404;@proxy_pass http://127.0.0.1:3000;@" ../../etc/nginx/sites-available/default
```

- `-i`: For editing files in place. That means the changes will be made directly to the file specified
- `"s@try_files \$uri \$uri/ =404;@proxy_pass http://127.0.0.1:3000;@"`: This is the substitution command for `sed`. It's used to find the pattern `try_files $uri $uri/ =404;` and replace it with `proxy_pass http://127.0.0.1:3000;`. The `@` symbol is used as a delimiter instead of the more commonly seen `/` to avoid clashing with the `/` characters in the paths. The backslashes (`\`) before the `$uri` are escaping the dollar sign to prevent it from being interpreted as a special character by the shell.
- `../../etc/nginx/sites-available/default`: This is the path to the file being edited.