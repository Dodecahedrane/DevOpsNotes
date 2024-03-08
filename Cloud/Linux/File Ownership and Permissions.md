---
tags:
  - Linux
  - DevOps
  - Permissions
---
There are ways to restrict the permissions of files within [[Linux]]

## File Ownership

### Why is managing file ownership important?

In the Linux operating system, file ownership and permissions play a crucial role in maintaining security and controlling access to files and directories

### What is the command to view file ownership?

```bash
ls -l
```

Output

```bash
-rwxrwxr-x 1 adminuser usergroup 223 Mar  7 14:47 prov-nginx.sh
```

For the file ``prov-nginx.sh`` the owner is ``adminuser``
### What permissions are set when a user creates a file or directory? Who does file or directory belong to?

The user who created the file/directory is the default owner

For files, the default permissions are often 666, which translates to ``rw-rw-rw-``. This means that the owner, group, and others have read and write permissions, but not execute permissions.

For directories, the default permissions are often 777, which translates to ``rwxrwxrwx``. This means that the owner, group, and others have read, write, and execute permissions.

### Why does the owner, by default, not receive X permissions when they create a file?

Makes it easy if differentiate between files meant for execution and those not.

For security, allows users to explicitly enable on a per file basic, so they cant accidently run a file they do not trust.

**'Least privilege principle'** States that permissions should be kept to the absolute minimum required.

### What command is used to change the owner of a file or directory?

```bash
chown <owner>:<group> <file_or_directory>
```

## File Permissions

### Do Owners have full permissions on a file?

By default yes, the owner will have full permissions for that file, if they choose to enable them (eg, execute). By default its just read and write permissions.
### If you give permissions to the User entity, what does this mean?

When you give permissions to the "User" entity, you're specifying the permissions for the owner of the file or directory. This means you're setting permissions for the user who created the file or directory (unless the owner/user has be changed).

### If you give permissions to the [[Group]] entity, what does this mean?

Every user on a Linux system belongs to one or more groups. When you assign permissions to the "Group" entity, you're specifying the permissions for the group that the file or directory belongs to.

### If you give permissions to the Other entity, what does this mean?

The "Other" entity refers to users who are neither the owner of the file nor members of the group associated with the file

### You give the following permissions to a file. User permissions are read-only, Group permissions are read and write, Other permissions are read, write and execute. You are logged in as the user which is owner of the file. What permissions will you have on this file? Explain.

- User permissions: Read-only
- Group permissions: Read and write
- Other permissions: Read, write, and execute

If you are logged in as the owner of that file, you will have read-only access to it.

### Explain all parts of: `-rwxr-xr-- 1 tcboony staff 123 Nov 25 18:36 keeprunning.sh`

1. `-rwxr-xr--`: This part describes the permissions of the file. It consists of ten characters, which are divided into four sections:
    - The first character indicates the type of the file or directory. In this case, it's a regular file because it starts with a hyphen (`-`). `d` is for directory.
    - The next three characters (`rwx`) represent the permissions for the owner (`tcboony`). `r` indicates read permission, `w` indicates write permission, and `x` indicates execute permission. In this case, the owner has read (`r`), write (`w`), and execute (`x`) permissions.
    - The next three characters (`r-x`) represent the permissions for the group (`staff`). In this case, the group has read (`r`) and execute (`x`) permissions, but does not have write permission (`-`).
    - The last three characters (`r--`) represent the permissions for others (users not in the owner's group). In this case, others have only read (`r`) permission, but do not have write or execute permissions (`--`).
2. `1`  - This part indicates the number of hard links to the file. In this example, there is one hard link to the file.
3. `tcboony` - This part indicates the owner of the file. In this case, the owner is `tcboony`.
4. `staff` - This part indicates the group associated with the file. In this case, the group is `staff`.
5. `123` - This part indicates the size of the file in bytes. In this example, the file size is 123 bytes.
6. `Nov 25 18:36` - This part indicates the date and time when the file was last modified. In this example, it was last modified on November 25th at 18:36.
7. `keeprunning.sh` - This part indicates the name of the file


## Managing File Permissions with Numeric Values

Each digit in the three-digit number represents the permissions for the owner, group, and others, respectively, as follows:

- The first digit represents the permissions for the owner.
- The second digit represents the permissions for the group.
- The third digit represents the permissions for others.

Each digit is calculated by adding the values for the permissions:

- Read (r) = 4
- Write (w) = 2
- Execute (x) = 1

*This works as every sum has a unique combination.*

Therefor:

- `rwx` = 4 + 2 + 1 = 7
- `rw-` = 4 + 2 + 0 = 6
- `r-x` = 4 + 0 + 1 = 5
- `r--` = 4 + 0 + 0 = 4
- `-wx` = 0 + 2 + 1 = 3
- `--x` = 0 + 0 + 1 = 1

If you want to set file permissions to `rw-r--r--`, you would assign the numeric value 644, where:

- Owner permissions = 6 (read + write)
- Group permissions = 4 (read)
- Others permissions = 4 (read)

Apply the permissions with

```bash
chmod 644 file.txt
```

This can be run by any user who has the appropriate permissions for the file and directory


### Give examples of some different ways/syntaxes to set permissions on a new file (named _testfile.txt_) to:

- Set User to read, Group to read + write + execute, and Other to read and write only
```bash
chmod 476 testfile.txt
```
- Add execute permissions (to all entities)
```bash
chmod a+x testfile.txt
```

The + adds the permission

Nothing before = user
- ``g`` = Group
- ``o`` = Other
- ``a`` = all

- Take write permissions away from Group
```bash
chmod g-w testfile.txt
```

The - takes away a permission, in the same way + works

- Use numeric values to give read + write access to User, read access to Group, and no access to Other.
```bash
chmod 640 testfile.txt
```

0 = no permissions