---
tags:
  - Azure
  - Cloud
  - DevOps
  - Networking
---
Network Security Groups, explained in [[Deploying Test Application in Azure]], can not only be assigned to NICs, but can also be assigned to a subnet.

[Azure Tutorial](https://learn.microsoft.com/en-us/azure/virtual-network/tutorial-create-route-table-portal)
## DMZ Architecture Diagram 

![[Pasted image 20240318163606.png]]

## Create a VNET

![[Pasted image 20240318102720.png]]

![[Pasted image 20240318103227.png]]
For the private subnet:
![[Pasted image 20240318103334.png]]
This means anything within ``private-subnet`` cannot access the internet! You'll need to use an image with the dependencies installed already to create a VM with, for example,

![[Pasted image 20240318103842.png]]


## Database VM

Using DB image
In AZ Zone 3 
![[Pasted image 20240318105311.png]]
No public IP
In the private subnet
![[Pasted image 20240318105320.png]]

## Web VM

In AZ Zone 1
Public IP with port 80 allowed
In Public Subnet
User Data for start up

## Network Virtual Appliance

Blank Ubuntu VM 22.04TLS
DMZ Subnet
Public IP, but only for config

## Route Table

![[Pasted image 20240318115404.png]]

![[Pasted image 20240318115618.png]]

Destination IP range = private subnet
Next hop address = NVA

Make the route associated with the public subnet

![[Pasted image 20240318115948.png]]

## Set Up IP Forwarding in the NVA

Check this box in the Azure NIC on the NVA
![[Pasted image 20240318120348.png]]

Set up network forwarding in the VM

See IP forwards

```bash
sysctl net.ipv4.ip_forward
```

Need to edit the config file 
```bash
sudo nano /etc/sysctl.conf
```

Uncomment this line
![[Pasted image 20240318120948.png]]

Then run this to apply it
```bash
sudo sysctl -p
```

You will now be able to send packets between the web VM and the database VM.

## IP Table Rules in the NVA

Bash script to update IP table rules

```bash
#!/bin/bash

# configure iptables

echo "Configuring iptables..."

# allowing all traffic on the loopback interface for incoming packets
sudo iptables -A INPUT -i lo -j ACCEPT

# allows all outgoing traffic on the loopback interface  to be accepted
sudo iptables -A OUTPUT -o lo -j ACCEPT

# matches packets that are in the ESTABLISHED or RELATED states, meaning they are part of existing connections for incomming packets
sudo iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# matches packets that are in the ESTABLISHED or RELATED states, meaning they are part of existing connections for Out going packets
sudo iptables -A OUTPUT -m state --state ESTABLISHED -j ACCEPT


# Drops invalid packets
sudo iptables -A INPUT -m state --state INVALID -j DROP


# allows SSH (port 22) traffic inbound and outbound
sudo iptables -A INPUT -p tcp --dport 22 -m state --state NEW,ESTABLISHED -j ACCEPT
sudo iptables -A OUTPUT -p tcp --sport 22 -m state --state ESTABLISHED -j ACCEPT

# uncomment the following lines if want allow SSH into NVA only through the public subnet (app VM as a jumpbox)
# this must be done once the NVA's public IP address is removed

#sudo iptables -A INPUT -p tcp -s 10.0.2.0/24 --dport 22 -m state --state NEW,ESTABLISHED -j ACCEPT
#sudo iptables -A OUTPUT -p tcp --sport 22 -m state --state ESTABLISHED -j ACCEPT

# uncomment the following lines if want allow SSH to other servers using the NVA as a jumpbox
# if need to make outgoing SSH connections with other servers from NVA

#sudo iptables -A OUTPUT -p tcp --dport 22 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
#sudo iptables -A INPUT -p tcp --sport 22 -m conntrack --ctstate ESTABLISHED -j ACCEPT

# forwards traffic from the public vm to the private vm, specifically the mongodb port, TCP protocal
sudo iptables -A FORWARD -p tcp -s 10.0.2.0/24 -d 10.0.4.0/24 --destination-port 27017 -m tcp -j ACCEPT

# allows all traffic on the ICMP protocal between the private and public subnets
sudo iptables -A FORWARD -p icmp -s 10.0.2.0/24 -d 10.0.4.0/24 -m state --state NEW,ESTABLISHED -j ACCEPT

# Setting the default policy for incoming packets to `DROP`. 
sudo iptables -P INPUT DROP

# Setting the default policy for forwarded packets to `DROP`.
sudo iptables -P FORWARD DROP

echo "Done!"

# make iptables rules persistent
# it will ask for user input by default
echo "Make iptables rules persistent..."
sudo DEBIAN_FRONTEND=noninteractive apt install iptables-persistent -y
echo "Done!"

```