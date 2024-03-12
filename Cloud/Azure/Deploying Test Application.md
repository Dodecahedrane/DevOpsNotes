---
tags:
  - Azure
  - Linux
  - DevOps
  - Bash
  - Scripts
  - rsync
  - scp
  - SSH
---
## Web Server VM Resource Config

OS: Ubuntu 22.04LTS
Type: B1s VM
Storage: Standard SSD
Virtual Network:
	*See [[Azure Virtual Networks and Subnets]] for details*
	10.0.0.0/16 Virtual Network
2 Subnets:
	Public Subnet: 10.0.2.0/24 (It will be a member of this Subnet)
	Private Subnet:  10.0.3.0/24

![[Pasted image 20240308124222.png]]

The Web server needs to be in the **public** subnet

The app requires access to port 3000 (TCP) and HTTP port 80

![[Pasted image 20240308125053.png]]

Your network security group should look like this

![[Pasted image 20240308125134.png]]

Set the Tags appropriately

This is the web server VM set up correctly.

## MongoDB Database Server VM Resource Config

OS: Ubuntu 22.04LTS
Type: B1s
Storage: Standard SSD
Security Type: Standard
	![[Pasted image 20240311155748.png]]
Virtual Network:
	*See [[Azure Virtual Networks and Subnets]] for details*
	10.0.0.0/16 Virtual Network
2 Subnets:
	Public Subnet: 10.0.2.0/24
	Private Subnet:  10.0.3.0/24  (It will be a member of this Subnet)
	*These Subnets should already exist from when we created them for the previous web VM.*


## Set Up Web Server App

**We will make a note and save these commands, taking note on if they require user input (as the automation script wont take any user input)**

### Dependencies

- [x] Ubuntu 22.04LTS
- [x] ``sudo apt update``
- [x] ``sudo apt upgrade``
	- [x] How do you run this without the user prompt??? [Answer](https://stackoverflow.com/questions/73094837/how-to-make-apt-get-upgrade-y-not-interactive)
- [x] Install Nginx
- [x] Enable Nginx
- [x] NodeJS - version 20.x (this also installs ``npm``)
- [x] ``app`` folder for source
	- [x] Git Clone
	- [x] Reorganize Folder Structure
- [x] Source in ``app`` folder
- [x] ``npm install`` (within ``app`` folder)
- [x] ``npm start`` (within ``app`` folder)
- [x] install ``pm2``
- [x] run app with ``pm2``
- [x] Configure Nginx as reverse proxy
- [x] Test bash script on fresh VM


### Install Script

#### Create Script

```bash
nano prov_nodejs.sh
chmod 700 prov_nodejs.sh
./prov_nodejs.sh
```

#### Script

```bash
#!/bin/bash

mkdir repo

cd repo

# upgrade
sudo apt-get update

# update
sudo DEBIAN_FRONTEND=noninteractive apt-get upgrade -y

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

# this needs to be installed to make it work
npm install express

# stop existing pm2 app process if it is already running
# this will error if it isnt running, but it doesnt cause an issue 
# and allows for the rerunning of the script if required
pm2 stop app

# start the app with pm2 (in the background)
pm2 start app.js
```

### Verify it works

Navigate to

To see NodeJS Server Directly:
[http://<public-ip-address\>:3000/](http://<public-ip-address\>:3000/)

To Check Reverse Nginx Proxy
[http://<public-ip-address\>](http://<public-ip-address\>)

You should see

![[Pasted image 20240308165409.png]]

#### On the VM

To see the running PM2 processes

```bash
pm2 list
```

Output:

```bash
┌────┬────────┬─────────────┬─────────┬─────────┬──────────┬────────┬──────┬───────────┬──────────┬──────────┬──────────┬──────────┐
│ id │ name   │ namespace   │ version │ mode    │ pid      │ uptime │ ↺    │ status    │ cpu      │ mem      │ user     │ watching │
├────┼────────┼─────────────┼─────────┼─────────┼──────────┼────────┼──────┼───────────┼──────────┼──────────┼──────────┼──────────┤
│ 0  │ app    │ default     │ 1.0.1   │ fork    │ 4803     │ 16m    │ 0    │ online    │ 0%       │ 71.9mb   │ azu… │ disabled │
└────┴────────┴─────────────┴─────────┴─────────┴──────────┴────────┴──────┴───────────┴──────────┴──────────┴──────────┴──────────┘
```

To get the PM2 process ID run

```bash
ps aux | grep "PM2"
```

Output:

```bash
azureus+    4792  0.1  6.6 1026592 56892 ?       Ssl  16:20   0:00 PM2 v5.3.1: God Daemon (/home/azureuser/.pm2
azureus+    4865  0.0  0.2   7008  2432 pts/0    S+   16:28   0:00 grep --color=auto PM2
```

The PID for PM2 is ``4792``. The second process is the grep command finding this info.

Kill the PM2 Process

```bash
pm2 stop all
pm stop <id>
```

The ``<id>`` is the id from ``pm2 list``. So in the case of the above output, ``0``

## Azure User Data (run script on VM creation automatically!)

When creating a VM set the user data in the Advanced tab

![[Pasted image 20240311151825.png]]

Just add the bash script in the user data section. this will run as the root user, not adminuser or any other user. So it is running from the root directory, make sure any relative file paths still work from the root directory (or use all absolute file paths - this is probably best practice, as then the script can be ran anywhere)

It can take several minutes before the user data script runs, it is not immediately ran on VM created.

You can create an image with all the dependencies installed and just run the commands required to start the services in the user data.

In the case of the web front end this would be

```bash
#!/bin/bash

cd repo
cd app
pm2 start app.js
```

## Set Up MongoDB

### Script

```bash
#!/bin/bash

# upgrade
sudo apt-get update

# update
sudo DEBIAN_FRONTEND=noninteractive apt-get upgrade -y

# install mongodb version 7.0.5
# following this guide:
# https://www.mongodb.com/docs/manual/tutorial/install-mongodb-on-ubuntu/#std-label-install-mdb-community-ubuntu
sudo DEBIAN_FRONTEND=noninteractive apt-get install gnupg curl -y

curl -fsSL https://www.mongodb.org/static/pgp/server-7.0.asc | \
   sudo gpg -o /usr/share/keyrings/mongodb-server-7.0.gpg \
   --dearmor


echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list

sudo apt-get update

# this installs the newest version, need to modify
sudo apt-get install -y mongodb-org

# this should work but doesnt
#sudo apt-get install -y mongodb-org=7.0.6 mongodb-org-database=7.0.6 mongodb-org-server=7.0.6 mongodb-mongosh=7.0.6 mongodb-org-mongos=7.0.6 mongodb-org-tools=7.0.6


# this fixes the mongodb versions so if you apt upgrade, they are skipped
echo "mongodb-org hold" | sudo dpkg --set-selections
echo "mongodb-org-database hold" | sudo dpkg --set-selections
echo "mongodb-org-server hold" | sudo dpkg --set-selections
echo "mongodb-mongosh hold" | sudo dpkg --set-selections
echo "mongodb-org-mongos hold" | sudo dpkg --set-selections
echo "mongodb-org-tools hold" | sudo dpkg --set-selections

ps --no-headers -o comm 1

sudo systemctl daemon-reload

sudo systemctl enable mongod

sudo systemctl start mongod


```