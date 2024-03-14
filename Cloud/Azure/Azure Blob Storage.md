---
tags:
  - Azure
  - DevOps
  - Cloud
  - BlobStorage
---
## What is Blob Storage?

Blob storage is for storing large amounts of unstructured data.

Blob = Binary Large Object

It has high availability and scalability and allows for access from anywhere over HTTP/S.

There are [three types of blob storage](https://learn.microsoft.com/en-us/rest/api/storageservices/understanding-block-blobs--append-blobs--and-page-blobs)

- Block
	- Designed for storing binary data (text, images)
- Page
	- Designed for high random IO. Often used for VM storage.
- Append
	- Use for append only use cases, such as logs
## Advantages and Disadvantages of Blob Storage?

### Advantages

- Scalable
- Redundant
- Pay for what you use
- Accessibility (over HTTP/S)
- Supports encryption

### Disadvantages

- Can be high latency (when compared to local storage)
- Data Egress Cost
- Vendor Lock In (because of the data egress costs)

## Pricing

![[Pasted image 20240314091501.png]]
![[Pasted image 20240314091538.png]]

[Azure Access Tiers](https://learn.microsoft.com/en-us/azure/storage/blobs/access-tiers-overview)

![[Pasted image 20240314091944.png]]

## Account, Container, Blobs

Within a resource you need a storage account
Within that account, you can create containers
Within the containers, you can have blobs

A container can be only one type of tier/type (eg, premium, block)
A storage account can have multiple types of containers

## Redundancy

- LRS
	- Locally Redundant Storage (3 Copies, all local to a DC)
- ZRS
    - Zone-Redundant Storage (3 Copies, across multiple availability zones within a region)
- GRS
    - Geo-Redundant Storage (6 Copies, 3 locally redundant copies in primary region, 3 geo-redundant copies in secondary region)
- RA-GRS
    - Read-Access Geo-Redundant Storage (Same as GRS with the additional capability of read access to the data in the secondary region)
- GZRS
    - Geo-Zone-Redundant Storage (Same as GRS but with zone redundancy in secondary region as well)
- RA-GZRS
    - Read-Access Geo-Zone-Redundant Storage (Combination of RA-GRS and GZRS, providing read access to data in the secondary region with zone redundancy)

[View Redundancy Pricing Here](https://azure.microsoft.com/en-gb/pricing/details/storage/blobs/#pricing)

Select in this drop down
![[Pasted image 20240314155444.png]]

Between LRS and RA-GZRS there is approximately a 3x price increase for the cost per GB stored on the *Hot* tier. (1.5p vs 4.45p)

## UK South vs UK West Cost

Very little?

Microsoft operating and capital costs are different for different locations, this will result in minor price differences

## How to change redundancy setting in portal

Under the redundancy tab

![[Pasted image 20240314160139.png]]

With the drop down you can select, for example GRS

Once set, it will show where it is georedundant to

![[Pasted image 20240314160240.png]]