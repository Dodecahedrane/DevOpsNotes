
## Jenkins Workflow

![[Pasted image 20240320162823.png]]

//TODO Update this once Jenkins to Cloud part is completed





## How to set up a job

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

Dont forget to specify the branch
![[Pasted image 20240320140838.png]]

Add the SSH Private Key
![[Pasted image 20240320133136.png]]

You should have no errors
![[Pasted image 20240320133204.png]]

If it has any red errors, something is wrong!
![[Pasted image 20240320133227.png]]

## Deploying App from [[Deploying Test Application In AWS]]

Set up with SSH access to git repo as above, with the bellow settings and shell commands.

Set build to run on this node
![[Pasted image 20240320141359.png]]

![[Pasted image 20240320141119.png]]



## Web hooks

To enable Jenkins to run whenever there is a Push on the repo you can use web hooks

To do this, check the ``GitHub hook trigger for GITScm polling`` check box in the Jenkins config
![[Pasted image 20240320155123.png]]

On GitHub set up the web hook
![[Pasted image 20240320155158.png]]

The payload URL is the ``http://<jenkins-server-address>/github-webhooks/``

You can choose to send just push requests, everything or select some events (PR, Push, Merge etc. depending on what your Jenkins job does)

You can see what caused a Jenkins job on the web UI

![[Pasted image 20240320155533.png]]