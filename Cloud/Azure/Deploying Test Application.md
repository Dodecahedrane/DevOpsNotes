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

# non interactive (so no multi choice q)
export DEBIAN_FRONTEND=noninteractive

# upgrade
sudo apt update

# update
sudo apt upgrade -y

# git clone
git clone https://github.com/Dodecahedrane/test-app

# move app folder out of git folder
mv test-app/app/ app/

# remove git folder as not needed anymore
sudo rm -r test-app/

# install nginx
sudo apt install nginx -y

# enable nginx (it should by default.. but should do it just to make sure)
sudo systemctl enable nginx

# update nginx to redirect port 3000 to port 80
sudo sed -i "s@try_files \$uri \$uri/ =404;@proxy_pass http://127.0.0.1:3000;@" /etc/nginx/sites-available/default

# restart nginx
sudo systemctl restart nginx

# install nodejs version 20.x
# https://github.com/nodesource/distributions/blob/master/README.md 
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash - &&\
sudo apt-get install -y nodejs

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
## How to transfer files from one machine to another

### ``scp``

```bash
scp -i ~/.ssh/Azure_tech257/tech257-oliver-linux-vm-key.pem -r app/ adminuser@172.167.178.177:~/
```

```bash
scp -i <ssh-key> -r <local-file-path> <user-name>@<ip-address>:<remote-file-path>
```

``-r`` is for recursive transfer
### ``rsync``

This is running in WSL as its not natively available on Windows.

```bash
rsync -avz -e "ssh -i ../../.ssh/Azure_tech257/tech257-oliver-linux-vm-key.pem" ./app adminuser@172.167.178.177:~/
```

```bash
rsync -avz -e "ssh -i <ssh-key>" <local-file-path> <user>@<ip-address>:<remote-file-path>
```

``-avz`` transfers with file compression
``-e`` is the argument for the SSH command

## Azure User Data (run script on VM creation automatically!)

When creating a VM set the user data in the Advanced tab

![[Pasted image 20240311151825.png]]

Just add the bash script in the user data section. this will run as the root user, not adminuser or any other user. So it is running from the root directory, make sure any relative file paths still work from the root directory (or use all absolute file paths)

// TODO Run this and make sure it works as expected

## Make an Azure VM Image for faster creation of a standardized VM

Install the [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)

In the VM run these commands to prepare the VM to be imaged

This will remove the all the users and their home directories!

```bash
sudo waagent -deprovision+user
```

Log into Azure on the CLI

```bash
az login
```

View Account

```bash
az account show
```

Output

```bash
{
  "environmentName": "AzureCloud",
  "homeTenantId": "ff15c67c-2870-4e9f-adc1-7d61d855b667",
  "id": "cd36dfff-6e85-4164-b64e-b4078a773259",
  "isDefault": true,
  "managedByTenants": [],
  "name": "Azure Training",
  "state": "Enabled",
  "tenantId": "ff15c67c-2870-4e9f-adc1-7d61d855b667",
  "user": {
    "name": "OGuy@spartaglobal.com",
    "type": "user"
  }
}
```

Stop VM

```bash
az vm deallocate --resource-group <resource-group> --name <vm-name>
```

```bash
az vm deallocate --resource-group tech257 --name tech257-oliver
```

Generalize VM image

```bash
az vm generalize --resource-group <yourResourceGroup> --name <yourVMName>
```

```bash
az vm generalize --resource-group tech257 --name tech257-oliver
```

In Portal click Capture

![[Pasted image 20240311155107.png]]

Fill out details, click create, be aware this will destroy this instance of the VM.

Click create image

To make an image from this VM, this will only work if the VM is set to security type of 'Standard'. Otherwise you wont be able to make an image.

Click 'See All Images'

![[Pasted image 20240311161018.png]]

Click 'My Images'

![[Pasted image 20240311161047.png]]

Select From List

![[Pasted image 20240311161058.png]]

Create the rest of the VM as standard following [[Create a VM on Azure]] guide