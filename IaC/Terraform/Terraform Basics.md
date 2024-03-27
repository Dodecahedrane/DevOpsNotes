## What is Terraform?


## What is orchestration?

## Basic Commands

terraform plan
terraform apply
terraform destroy

terraform init - this downloads dependencies, run on creation of a new tf file

terraform files are .tf

Use Env vars for the aws access keys

export KEY=value
printenv key

https://developer.hashicorp.com/terraform/tutorials/aws-get-started/aws-build


```Terraform
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
