---
tags:
  - Azure
  - DevOps
  - Cloud
  - WebServer
  - AutoScale
---
## Prerequisites

Create a image of the NodeJS VM from [[Deploying Test Application]] 

[Link To Image](https://portal.azure.com/#@spartaglobal.com/resource/subscriptions/cd36dfff-6e85-4164-b64e-b4078a773259/resourcegroups/tech257/providers/Microsoft.Compute/images/tech257-oliver-web-vm-image-20240314143508/overview)

When starting the VM, insert this script as user data

```bash
#!/bin/bash

cd repo/app

pm2 start app.js
```

## How they work

[Azure Scale Set Explination](https://learn.microsoft.com/en-us/azure/virtual-machine-scale-sets/overview)

Azure Virtual Machine Scale Sets let you create and manage a group of load balanced VMs. 

The number of VM instances can automatically increase or decrease in response to demand or a defined schedule. 

Scale sets provide the following benefits
- Easy management of VMs
- High Availability across multiple zones
- Automatic Scaling
- Restores VMs with faults

![[Pasted image 20240315153100.png]]

## Load Balancers

A load balancer distributes inbound traffic between a number of VM instances. This distributes the load between these instances, allowing for 'scale out' of a service. (Rather than just using a larger and larger VM type). This also adds redundancy, which can be further increased by spreading these VMs across multiple zones.


## Building a Scale Set


![[Pasted image 20240315122106.png]]

### Basics

You can have your VMs hosted on up to 3 zones.

![[Pasted image 20240315122234.png]]

You can have scale sets made of various sizes of VMs. We want to scale the same sized VMs, so we have chosen Uniform.

![[Pasted image 20240315122255.png]]

This is the image we want our VMs to be based on

![[Pasted image 20240315122329.png]]

### Network

This is the virtual network we want our VMs to be part of

![[Pasted image 20240315122834.png]]

You can modify the network interface to allow the required ports, we just need to allow port 80 for this application.

![[Pasted image 20240315122844.png]]

![[Pasted image 20240315123001.png]]

We want to use the Azure Load Balancer

![[Pasted image 20240315123200.png]]


![[Pasted image 20240315123209.png]]

We want the load balancer to be publicly accessible. 

You can also set rules for port forwarding, but for this application we want to port 80 to go to port 80.

There is a NAT rule for the SSH ports, see the section bellow on how this works.

![[Pasted image 20240315123255.png]]


### Scaling

Initial instance count is the number of instances the scale set will start with.

We want a custom scaling policy.

You can set a minimum and maximum number of instances.

You need to set rules for the scale out and scale in based on the average CPU threashold of all VMs across the set over a period of time, as well as a number of instances to add/remove when that rule is met.


![[Pasted image 20240315124227.png]]

### Health

Health can monitor our VMs and restart them if they do not meet a certian criteria, for this example, if a request on port 80 does not return true for 10 minutes that VM will be reimaged.

![[Pasted image 20240315124321.png]]
![[Pasted image 20240315124334.png]]

### Advanced

Don't forget the user data required to start the VMs correctly when they are created.

![[Pasted image 20240315124310.png]]


## Once It Is Created

Under instances you can see the VMs that are in the scale set, along with their status (running and health)

![[Pasted image 20240315141243.png]]

Health is the checker that Health section above. This checks to make sure the nodes return a 200 HTTP status, if they return another status code for too long Azure will automatically stop and restart that instance.

In the case of this scale set pm2 does not start when the VM is rebooted, so you need to 'reimage' the instances to reload the user data and restart the web servers. This will remove any local data.

![[Pasted image 20240315141719.png]]

## Manage Instances

![[Pasted image 20240315155943.png]]

You can select instances and start, stop, restart, reimage or delete them manually, as well as set protection levels which will stop that VM from being included in the scale out/in.

![[Pasted image 20240315160050.png]]
## SSH

The SSH port 22 is NAT'd to port 50000+, where 50000 is the first instance, 50001 is the second, 50002, the third and so on. Use the ``-p`` parameter in ``ssh`` to specify the port number.

![[Pasted image 20240315141754.png]]

```bash
# first instance
ssh -i .\tech257-oliver-linux-vm-key.pem adminuser@4.159.34.29 -p 50000

# second instance
ssh -i .\tech257-oliver-linux-vm-key.pem adminuser@4.159.34.29 -p 50001
```

You can tell what you need to add to 50000 to get by looking at the numbers on the VM name, in this case 000001, 000002. It will normally start from 000000. Add this to 50000 to get the correct port number.
## Break an Instance

For the [[Deploying Test Application]] app you can do this by just restarting an instance.

You should get an unhealthy status.

![[Pasted image 20240315142938.png]]

After the grace period is up, you'll see that the unhealthy VM is deleted and a new one created to replace it.

![[Pasted image 20240315144045.png]]

After it has finished you'll end up with

![[Pasted image 20240315144207.png]]

Notice the new VM has a different name.

## Deleting a Scale Set

You will have to first delete the scale set, then the NSG, public ip, and the load balancer separately after the scale set is deleted.

The public IP must be deleted after the load balancer.

## Spot Instances

[Azure Spot Virtual Machines for Scale Sets](https://learn.microsoft.com/en-us/azure/virtual-machine-scale-sets/use-spot)

You can use spot instances within Azure Scale Sets for cheaper pricing. This might mean instances are pulled, but you can (I think) set up rules to increase the number of instances of other types (either non spot or spot) if this happens.

## Availability Sets

Availability sets have a fixed number of VMs, but with the same redundancy and multi zone VMs as scale sets.






















