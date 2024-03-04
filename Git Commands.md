---
tags:
  - Git
  - DevOps
---

## To Read

https://stackoverflow.com/questions/3689838/whats-the-difference-between-head-working-tree-and-index-in-git

# Git Workflow Diagram

![git workflow](https://champlintechnologiesllc.com/wp-content/uploads/2017/07/git-basic_600x492.jpg)
# Git Cheat Sheet

![[git-cheat-sheet.pdf]]


# Basic Git Commands

If you have a colon (:), press `q` to quit and enter to increase the output (common for `git diff`) 
### Create a new local repository

````bash
git init
`````

### Show all the previous commits

````bash
git log
`````

### git add
##### This add all new files and modifications, not deleted files

````bash
git add .
`````

##### This adds all changes

````bash
git add -A
git add --all
````

##### This adds all modified files and deletions, not new files

````bash
git add -u
````

### Commit

```Bash
git commit -m "This is the commit message"
git commit -am "This auto adds all the files (unstaged, new, modified, deleted) and adds them to this commit (skipping the need to git add -A)"
```
### Undo the last commit

// TODO Check this works the way I think it does

````bash
git reset HEAD~   
````

### Unstage file

````bash
git restore --staged <filename>
`````

### Diffs

Use `git log` to get the correct commit IDs for the diff you want

```bash
git diff <oldest-commit-id> <newest-commit-id>
```

### Git Checkout (to view previous commit)

```bash
git checkout <commit-id-to-view>
```

If you make changes in the *'detached head state'* use this command to save those changes to a new branch that you can later merge

```bash
git switch -c <new-branch-name>
```

To undo any changes and revert back the (attached) HEAD

```
git switch -c
```

or

```bash
git checkout main
git checkout master
```

or whatever branch you want to....

## Revert to previous commit

**Dangerous!!!!!!!!**

This irreversibly reverts to a previous commit, use with caution (not always true... see bellow)

```bash
git reset --hard <commit-id>
```

#### How to fix if you ``reset --hard`` when you don't want to

[Stack Overflow Question](https://stackoverflow.com/questions/5473/how-can-i-undo-git-reset-hard-head1)

If you do run:

```bash
$ git fsck --lost-found
```

``fsck`` stand for file system check

Returns: 

```bash
dangling commit b72e67a9bb3f1fc1b64528bcce031af4f0d6fcbf
```

This will return a list of commit IDs that are 'dangling', the last on this list is the commit you just reset. Use this command to rebase to this commit.

```bash
git rebase <id-of-dangeling-commit>
```

Git only keeps this information for ~30 days before it does garbage collection. You can't recover lost commits after this.
# Branching

![branching diag](https://lh5.googleusercontent.com/MrlV6SPcsgDcaMfFo3NM26byyk-VFvCrH6WoYKCHqKO1DaVFfMSc_qCWn6gbdyGe0JD_yMAPpSR7kydlh1gJnBvxZW3E8wcDRg8ISZpKvXFJIOwQpb-JPbysO3H77h4zK34XxtGh)



