---
tags:
  - DevOps
  - IaC
  - InfrastructureasCode
  - Ansible
---
## What is IaC?

Infrastructure as code is the process of managing and provisioning hardware through tools that use human readable code to manage infrastructure.

These configuration files can be versioned, which is one of the main benefits of IaC, allowing you to store the definition of your infrastructure in the same way you store code, allowing for rollbacks and deployment pipelines in a similar manner. 
## When is IaC used?

IaC has three befits, cost, speed and risk.

Cost: Having to have an engineer manually configure and provision servers can be very time intensive, especially if there are a large number, IaC can deploy dozen or hundreds of instances just as easily as a single instance, saving the business the cost of paying a skilled engineer to do that work manually.

Speed: In the same example, the IaC config files can be read and performed much faster than a human, saving a lot of time.

Risk: Having to manually deploy servers, especially a large number, opens you up to risks, such as forgetting to set a correct security configuration on one server out of dozens. With IaC you know that every server will be provisioned and deployed the same, so this risk is reduced. And in the event something is missed, it is easy to modify the config files and rerun the provisioning to update the servers.
## Where should IaC be used?

IaC should be used where a one configuration might be reused to reran multiple times. Eg, setting up test environments within a pipeline.

## IaC Tools

Ansible, terraform, puppet, chef

## What is Ansible?

Ansible is used to manage the configuration of multiple machines at once, you can define a spec (things to install, files to modify) within a YAML (?) file called a Playbook where you can define your machine spec. You can then run this Playbook across an "Inventory" of machines, ansible will SSH into these (?) and deploy the spec to each machine, making sure that they all have the same configuration.

## Who uses IaC and Ansible?

Ansible is built by Red Hat

