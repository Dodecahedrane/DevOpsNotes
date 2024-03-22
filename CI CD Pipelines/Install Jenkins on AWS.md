---
tags:
  - CICD
  - DevOps
  - Jenkins
---
## EC2 Instance

Ubuntu 22.04LTS
t2.micro
Allow SSH and HTTP traffic, as well as TCP on port 8080 (this Jenkins Port)

## Installing Jenkins

Following [this guide](https://www.cherryservers.com/blog/how-to-install-jenkins-on-ubuntu-22-04)

```bash
sudo apt-get update
sudo apt-get upgrade -y

# install java (jenkins runs on java)
sudo apt install openjdk-11-jdk -y

# add jenkins GPG Key
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null

# add the jenkins source to the local repository
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]  https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt-get update

sudo apt-get install Jenkins

sudo systemctl start Jenkins
```

```bash
sudo systemctl status Jenkins
```

### In the browser

Navigate to the Jenkins page normally this is ``<ip>:8080``

You should see

![[Pasted image 20240322143822.png]]

Run this in the terminal to get the admin password

```bash
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```

Copy and paste the password into the form.

We will need the following addons in Jenkins

- SSH Agent
- GitHub
- Git Parameter
- SSH Build Agents

You should get a page showing the install happening with the selected addons

![[Pasted image 20240322144328.png]]

Create the main Admin user

![[Pasted image 20240322144437.png]]

Set it to allow SSH connections to Git

![[Pasted image 20240322145153.png]]

