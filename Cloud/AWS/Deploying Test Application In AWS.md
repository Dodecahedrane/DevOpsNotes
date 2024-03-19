This is the same app as from [[Deploying Test Application in Azure]]


## Creating the Web Server VM

Name your instance
![[Pasted image 20240319120748.png]]

Choose Ubuntu 22.04lts, x86
![[Pasted image 20240319120813.png]]

The instance type should be t2.micro
![[Pasted image 20240319120831.png]]

Choose the correct SSH key
![[Pasted image 20240319120849.png]]

Click advanced on network settings

Name it appropriately, with a description

Add a rule to allow HTTP traffic from anywhere.

![[Pasted image 20240319120906.png]]

Click 'Launch Instance'

This is the public IP of the instance
![[Pasted image 20240319121119.png]]

Click connect to get the correct ssh command
![[Pasted image 20240319121137.png]]

Copy the ssh connection command, it expects you to be in the same directory as the ssh key is stored in
![[Pasted image 20240319121221.png]]

To set up the VM run the same script from [[Deploying Test Application in Azure]] with one modification, see the next section
## How to stop the need restart dialog when outdated services have been updated with ``apt upgrade``

Go to 

```bash
sudo nano /etc/needrestart/needrestart.conf
```

Uncomment and modify this line

![[Pasted image 20240319113655.png]]

The ``a`` will need to changing from the ``i`` 

This will stop the dialog coming up asking to restart services after an ``apt upgrade``. This is the first command of the script.

## Web App Install Script

Use the same script as [[Deploying Test Application in Azure]]

```bash
#!/bin/bash

#extra line to disable reboot dialog
sudo sed -i "s/#\$nrconf{restart} = 'i';/\$nrconf{restart} = 'a';/g" /etc/needrestart/needrestart.conf    

mkdir repo

cd repo

# upgrade
sudo apt-get update

# update
sudo DEBIAN_FRONTEND=noninteractive apt-get upgrade -y

# install git
sudo DEBIAN_FRONTEND=noninteractive apt-get install git -y

# git clone
git clone https://github.com/Dodecahedrane/test-app

# move app folder out of git folder
mv test-app/app/ app/

# remove git folder as not needed anymore
sudo rm -r test-app/

# install nginx
sudo DEBIAN_FRONTEND=noninteractive apt-get install nginx -y

# enable nginx (it should by default.. but should do it just to make sure)
sudo systemctl enable nginx

# update nginx to redirect port 3000 to port 80
sudo sed -i "s@try_files \$uri \$uri/ =404;@proxy_pass http://127.0.0.1:3000;@" /etc/nginx/sites-available/default

# restart nginx
sudo systemctl restart nginx

# install nodejs version 20.x
# https://github.com/nodesource/distributions/blob/master/README.md 
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash - &&\
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y nodejs

# install pm2 to run the nodejs server
sudo npm install pm2 -g

# this part assums the source files were copied across to the server
cd app

# set DB_HOST env var where it equals the private IP of the MongoDB VM
export DB_HOST=mongodb://10.0.3.4:27017/posts

# this needs to be installed to make it work
sudo -E npm install
sudo npm install express

# stop existing pm2 app process if it is already running
# this will error if it isnt running, but it doesnt cause an issue 
# and allows for the rerunning of the script if required
pm2 stop app

# start the app with pm2 (in the background)
pm2 start app.js
```
