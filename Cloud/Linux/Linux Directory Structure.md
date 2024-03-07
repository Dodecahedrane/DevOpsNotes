## Root Directories

[Linux Directory Structure](https://www.geeksforgeeks.org/linux-directory-structure/)

| Directories     | Description                                                                                                                         |
| --------------- | ----------------------------------------------------------------------------------------------------------------------------------- |
| **/bin**        | binary or executable programs.                                                                                                      |
| **/etc**        | system configuration files.                                                                                                         |
| **/home**       | home directory. It is the default current directory.                                                                                |
| **/opt**        | optional or third-party software.                                                                                                   |
| **/tmp**        | temporary space, typically cleared on reboot.                                                                                       |
| **/usr**        | User related programs.                                                                                                              |
| **/var**        | log files.                                                                                                                          |
| **/boot**       | It contains all the boot-related information files and folders such as conf, grub, etc.                                             |
| **/dev**        | It is the location of the device files such as dev/sda1, dev/sda2, etc.                                                             |
| **/lib**        | It contains kernel modules and a shared library.                                                                                    |
| **/lost+found** | It is used to find recovered bits of corrupted files.                                                                               |
| **/media**      | It contains subdirectories where removal media devices are inserted.                                                                |
| **/mnt**        | It contains temporary mount directories for mounting the file system.                                                               |
| **/proc**       | It is a virtual and pseudo-file system to contains info about the running processes with a specific process ID or PID.              |
| **/run**        | It stores volatile runtime data.                                                                                                    |
| **/sbin**       | binary executable programs for an administrator.                                                                                    |
| **/srv**        | It contains server-specific and server-related files.                                                                               |
| **/sys**        | It is a virtual file system for modern Linux distributions to store and allows modification of the devices connected to the system. |
## Home Directory

Accessible with `cd ~` or `cd`

## Root Directory

Accessible with `cd /`

## Root Home Directory

`/root` is the root users *'home'* folder

If you want to navigate into the root folder (or do other root only stuff), you need to login as the root user.

Do this with 

```bash
sudo su
```

Type ``exit`` to logout of root

