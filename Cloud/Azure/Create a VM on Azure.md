![[Pasted image 20240307090804.png]]

![[Pasted image 20240307090914.png]]

Click create, and the Azure Virtual Machine

![[Pasted image 20240307090955.png]]

Choose the settings

### Subscription

This is the billing subscription

### Resource Group

This is the group within the subscription, use it to group resources appropriately within the subscription group. Eg, prod, dev, test

### VM Name

Name for the VM,

### Region

Where the VM is hosted

### Availability Zones

![[Pasted image 20240307091329.png]]

You can set Availability Zones to duplicate the VM across multiple regions to add redundancy and fault tolerance

![[Pasted image 20240307094654.png]]
Select 'No Infra Redundancy Required' to have no availability zones

### Image

![[Pasted image 20240307091550.png]]

You can choose the base image for the VM. Various flavors of Linux, BSD and Windows

### VM Arch., Spot and Size
![[Pasted image 20240307091736.png]]

You can choose to run the VM as a Spot Instance (cheap pricing, may be pulled at any time)

x64 or Arm available

The size is different spec options for the VM. Be aware of price differences!

### 
![[Pasted image 20240307091934.png]]

Auto generate SSH keys, see [[Azure SSH]] to see how to use them to connect.

### Inbound Ports

You can choose which ports to allow inbound traffic to.

### Disk Type

![[Pasted image 20240307093159.png]]

Various Disk type options are available 

### Tags

![[Pasted image 20240307093219.png]]

You can add tags to the VM/Resources to be able to easy find it, tags may be for who created it, the 'Owner', Department or the Project the resource belongs to