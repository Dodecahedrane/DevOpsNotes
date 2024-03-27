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

```YAML
# Need to set the following env vars
# AWS_ACCESS_KEY
# AWS_SECRET_ACCESS_KEY

# cloud provider and region
# terraform will auto download the required dependencies if you use a new region
provider "aws" {
    region = "eu-west-1"
}

# aws_instance is the resource type, the tech257-... is the resource name
resource "aws_instance" "app_server" {
    # amazon machine image
    ami = "ami-02f0341ac93c96375"
  
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
