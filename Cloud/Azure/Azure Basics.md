# Azure Fundamentals

## Regions and Availability Zones

Regions are geographical areas

Availability Zones are data centers within a region

## VMs Resources

- Resource groups:
    - Group related resources (e.g., VMs, databases) for easier management and access control.
    - Subscriptions: Represent a billing unit for your Azure usage. You can have multiple subscriptions for different projects or cost centers.
    - Management groups: Optionally organize multiple subscriptions for centralized governance and policy application across your Azure environment. Control resource groups (allow only certain resources/VM sizes) and control what certain users can/can't do
    
![[Pasted image 20240312105540.png]]
## Azure Products

- Compute: Virtual Machines (VMs), containers, Serverless functions for building and running applications.
- Storage: Blob storage for unstructured data, disk storage for VMs, databases for structured data.
- Networking: Virtual networks, firewalls, load balancers for connecting and securing your resources.
- Management: Tools for monitoring, managing, and automating your Azure resources.
- Security: Identity and access management, data encryption, threat protection solutions.
- Artificial Intelligence: Machine learning, cognitive services, and other AI tools for building intelligent applications.
- Web & Mobile: Tools for building and deploying web and mobile applications.
- Data & Analytics: Services for storing, managing, and analyzing big data.

## Azure Pricing Calculator

- The Azure Pricing Calculator is an invaluable resource for estimating the cost of using various Azure services.
- You can specify the resources you plan to use (e.g., VM type, storage size) and the duration of use to get a personalized cost estimate.
- This helps you plan your budget and choose cost-effective solutions for your needs.

There is also a TCO calculator

# Create  VM

See [[Create a VM on Azure]] for how to create a VM
### Connect with SSH

![[Pasted image 20240307092320.png]]

![[Pasted image 20240307094336.png]]

You can connect using the Azure web portal, Azure CLI or locally with [[Azure SSH]] using open[[SSH]]

