
## Jenkins Workflow

![[Pasted image 20240321133508.png]]

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

![[Pasted image 20240321153639.png]]



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


## Run tests from dev branch commit, then merge them into main automatically

You could set the merge to happen in the test job, but this runs on the agent node, rather than the main node. The agent node has a lot more compute, as well as dependencies, for running builds and tests. So we set up this second job to do the merge, which happens on the master node, tying up less of the resources on the agent node that is used for builds and testing.

Specify the new dev branch in the Jenkins Test Job

![[Pasted image 20240321101614.png]]

Set up second job for merge to run if the build is successful

![[Pasted image 20240321102903.png]]

Set up the Post Build Git Publisher actions

![[Pasted image 20240321111401.png]]

## Push the code to AWS

Set up a new job with access to GitHub via ssh same as above

Set it to run after the merge job

Select SSH Agent in the Build Environment section, select the correct SSH key to connect to the AWS EC2 Instance

![[Pasted image 20240321114730.png]]

Execute Shell

![[Pasted image 20240321121710.png]]

Actual bash script

```bash
# transfer app folder
rsync -avz -e "ssh -o StrictHostKeyChecking=no" app ubuntu@34.244.77.138:~/

ssh -o "StrictHostKeyChecking=no" ubuntu@34.244.77.138 <<EOF
	sudo apt-get update -y
    sudo apt-get upgrade -y
    sudo apt-get install nginx -y
    sudo systemctl restart nginx
    
    cd app/app
    sudo chmod 700 ../environment/app/provision.sh
    sudo ../environment/app/provision.sh
    pm2 stop app.js
    pm2 start app.js
```

