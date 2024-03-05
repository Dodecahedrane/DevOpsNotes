---
tags:
  - Cloud
  - DevOps
  - SoftwareEngineering
---

## What is Cloud Computing? 

> Simply put, cloud computing is the delivery of computing services—including servers, storage, databases, networking, software, analytics, and intelligence—over the Internet (“the cloud”) to offer faster innovation, flexible resources, and economies of scale.

[Azure: What is Cloud Computing?](https://azure.microsoft.com/en-gb/resources/cloud-computing-dictionary/what-is-cloud-computing#:~:text=Simply%20put%2C%20cloud%20computing%20is,resources%2C%20and%20economies%20of%20scale.)
## Quick history/timeline of Cloud Computing.

AWS launch in 2006, but the original idea was from the 60s. The initial concepts of compute time share becoming popularized via remote job entry. The "data center" model, where users submitted jobs to operators to run on mainframes, was predominantly used during this era
## What can you do with Cloud Computing?

- Compute (CPU, GPU, FPGA, Quantum)
- Storage
- Database
- CDNs
- Serverless Functions
- Analytics
- A lot more...

## What are the 4 types of Cloud?

[Red Dat: Types of Cloud Computing](https://www.redhat.com/en/topics/cloud-computing/public-cloud-vs-private-cloud-and-hybrid-cloud#:~:text=Why%20Red%20Hat%3F-,Overview,a%2DService%20(SaaS).)

- Public Cloud
	- Uses shared infrastructure
	- AWS EC2
- Private Cloud
	- Uses dedicated infrastructure rented from a provider
- Hybrid Cloud
	- Multiple environments acting as one 'cloud'
- Multicloud
	- Multiple Cloud Providers operating as one 'unit' through the use of orchestration

All multiclouds are hybrid clouds, not all hybrid clouds are multiclouds.

For example, Azure + On Premises = Hybrid but not Multi
## What are the different providers and types of cloud service?

### Providers
- Azure
- AWS
- GCP
- Digital Ocean
- Hetzner
- etc etc etc etc etc etc
### Types of Service
- klasld
## Advantages/Disadvantages of the Cloud? Specifically for a business.

Good for dynamic workloads where you can scale your infra for short periods of time to meet increased demand without having to have the expense of that infrastructure the other 364 days a year.

Less overhead, someone else manages the hardware, network connection, building and upkeep.

Not locked into a fix contract. (Eg, Leased on premises server, vs monthly billed cloud VM)
## What is OpEx vs CapEx?

OpEx = Operation Expense (recurring)
CapEx = Capital Expense (not recurring)
##  Marketshare - What is the breakdown? 

![Marketshare](https://cdn.statcdn.com/Infographic/images/normal/18819.jpeg)
## What are the 3 largest Cloud providers known for (What makes them popular?)

- AWS
- Azure
- GCP

Reputation, available services, availability zones
##  What are the 4 pillars of DevOps? How do they link into the Cloud?

### Culture

Cloud platforms support sharing and collaboration by providing centralized repositories, version control systems, and collaboration tools
### Automation

Automation is a key pillar of DevOps, enabling teams to streamline and accelerate processes in software development and IT operations. Cloud platforms offer Infrastructure as Code tools, scalable resources, and robust CI/CD pipelines, allowing DevOps teams to automate deployment, testing, and monitoring tasks, increasing efficiency and faster development times.

### Measurement

Cloud platforms provide monitoring and analytics tools that enable DevOps teams to track key performance indicators, such as deployment frequency, uptime, cost and speed, across environments

### Sharing

Cloud platforms support sharing and collaboration by providing centralized repositories, version control systems, and collaboration tools (same as culture???)

## Find up to 3 case studies showing how businesses have migrated to the cloud or used the cloud to improve in some way

// TODO Read case studies and makes notes
### 1

[AWS: Southwest Airlines Automated Mac Test Infrastructure](https://aws.amazon.com/solutions/case-studies/southwest-devicefarm-ec2-case-study/)
### 2

[Lambda Labs: # Voltron Data Case Study: Why ML Teams Are Using Lambda Reserved Cloud Clusters](https://lambdalabs.com/blog/voltron-data-case-study-why-ml-teams-using-reserved-cloud-clusters)
### 3

[Netflix: AWS and their own CDN](https://ayushhsinghh.medium.com/case-study-how-netflix-is-using-aws-and-its-own-cdn-64ca6282eda0)
### 4

[Monzo on AWS](https://d0.awsstatic.com/analyst-reports/EMEA41642116%20Web.pdf)
### Counter Case Study

[We have left the cloud](https://world.hey.com/dhh/we-have-left-the-cloud-251760fb) 
[We stand to save $7m over five years from our cloud exit](https://world.hey.com/dhh/we-stand-to-save-7m-over-five-years-from-our-cloud-exit-53996caa)

## How does Cloud Computing work as a business model?

Offers resources (cloud, storage, etc) on a pay as you go model, where users only need to pay of the resources they want to use, and can shutdown resources whenever they aren't required (to meet demand for example).

Some providers offer discounted spot pricing to provide really cheap compute, with the understanding that it can be pulled from you at any time depending on the requirements from users willing to pay full price for instances. This helps cloud providers ensure that they keep as much of their infrastructure being used by a paying customer at any point in time.
## What sorts of things do you usually need to pay for when using the cloud?

 - Compute
 - Storage
 - Ingress
 - Egress



Cloud Interview Qs

1. Why DevOps?
2. Describe cloud computing?
3. Name 3 services that a cloud provider will have and their uses
4. Why use cloud over on premises?
5. Is the cloud right for every project?