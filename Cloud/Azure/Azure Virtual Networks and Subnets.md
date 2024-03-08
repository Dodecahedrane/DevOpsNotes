[What is an Azure Virtual Network](https://learn.microsoft.com/en-us/azure/virtual-network/virtual-networks-overview)
[What is an Azure Subnet](https://learn.microsoft.com/en-us/azure/virtual-network/concepts-and-best-practices)

![[Pasted image 20240308123230.png]]

A virtual network has an address space (eg. 10.0.0.0/16, this 16 being the number of fixed bits - within the 32 bit address. So this is from 10.0.0.0 to 10.0.255.255)

The subnet is a sub set of that virtual network, this allows you to segment infrastructure and control the traffic between each subnet. Such as not allowing a subnet access to the internet.

> **Subnets:** Subnets enable you to segment the virtual network into one or more subnetworks and allocate a portion of the virtual network's address space to each subnet. You can then deploy Azure resources in a specific subnet. Just like in a traditional network, subnets allow you to segment your virtual network address space into segments that are appropriate for the organization's internal network. Segmentation improves address allocation efficiency.

Source: [Azure](https://learn.microsoft.com/en-us/azure/virtual-network/concepts-and-best-practices)