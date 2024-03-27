---
tags:
  - DevOps
  - IaC
  - InfrastructureasCode
  - Terraform
  - AWS
---
## Basic Commands
```bash
# plan checks the main.tf file is correct
terraform plan

# apply builds the infrastructure
terraform apply

# destroy removes the infrastruture
terraform destroy

# init downloads any required terraform dependencies
terraform init
```

terraform files are in the ``.tf`` and are JSON like in format.

## Keys

Access keys should be kept as Environment Variables ([[Linux Environment Variables]])

For AWS these are

AWS_ACCESS_KEY
AWS_SECRET_ACCESS_KEY

See [Docs for AWS](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/aws-build)

## Basic Terraform Script

*ignore that this code block is formatted as yaml, that's just so the syntax highlighter works nicely with HCL2 syntax.*

```YAML
# Need to set the following env vars
# AWS_ACCESS_KEY
# AWS_SECRET_ACCESS_KEY

# cloud provider and region
# terraform will auto download the required dependencies if you use a new region  

provider "aws" {
    region = "eu-west-1"
}


# network security group
resource "aws_security_group" "nsg" {
  name        = "tech257-oliver-terraform-nsg"
  description = "Allow inbound traffic on port 22 and port 80"  

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

  
# aws_instance is the resource type, the app is the name within terraform name
resource "aws_instance" "app" {
    # amazon machine image
    ami = "ami-02f0341ac93c96375"
  
    # nsg
    security_groups = [aws_security_group.nsg.name]

    # ssh access key
    key_name = "tech257"

    # vm type
    instance_type = "t2.micro"

    # add public ip
    associate_public_ip_address = true

    # service name
    tags = {
        Name = "tech257-oliver-terraform"
    }
}
```

## Terraform State Files

There are ``.tfstate`` files that keep track of what exists on the cloud that TF created, if you modify a terraform created instance on the cloud it will not know about this. (is this correct? Need to check this... //TODO)

**Do Not Push ``.tfstate`` files to GitHub! (They have sensitive information within them!) Only the ``main.tf``  or other ``.tf`` files can be pushed to GitHub!**

## Desired State vs Current State

Desired state is the state that you want your infrastructure to be as defined in your Terraform Configuration files. The current state is the actual state of the infrastructure as represented in the Terraform state file
## Push vs Pull Configuration

For the push method, the controlling server will push configurations and artifacts to the destination system, usually using SSH. For the pull method, the destination system will pull its configuration and artifacts from the controlling server, using an agent installed on the destination system to do that.   
  
Examples of IaC tools that use the push method by default are Terraform, AWS CloudFormation, Ansible, and Pulumi. Chef and Puppet use the pull method.