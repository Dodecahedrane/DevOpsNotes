
There are many types of jobs Jenkins can run, we will start with the freestyle project type.

![[Pasted image 20240320120037.png]]

You can connect it to GitHub and Git

![[Pasted image 20240320120130.png]]
![[Pasted image 20240320120122.png]]

You can have it execute a shell script
![[Pasted image 20240320120153.png]]

You can set build triggers
![[Pasted image 20240320120205.png]]

You can manually build jobs and see the build history
![[Pasted image 20240320120408.png]]

You can see the build status, console output and build info
![[Pasted image 20240320120450.png]]

## Add a GitHub Repo to Jenkins via SSH

Add the GitHub HTTPS URL under the GitHub Project section
![[Pasted image 20240320132941.png]]

Choose Git for Source Code Management
![[Pasted image 20240320132957.png]]

Add the SSH URL as Repo URL
![[Pasted image 20240320133016.png]]

Add the SSH Private Key
![[Pasted image 20240320133136.png]]

You should have no errors
![[Pasted image 20240320133204.png]]

If it has any red errors, something is wrong!
![[Pasted image 20240320133227.png]]