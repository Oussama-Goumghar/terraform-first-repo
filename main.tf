provider "aws" {
}

variable "subnet_cidr_block" {
  description = "Subnet cidr block"
}
# to assign a the variable:
#     -$ terraform apply -var "subnet_cidr_block=10.0.30.0/24"

variable "vpc_cidr_block" {
  description = "vpc cidr block"
  default = "10.0.0.0/16"
}

variable "environment" {
  description = "deployment environment"
}


resource "aws_vpc" "development-vpc" {
    cidr_block = var.vpc_cidr_block
    tags = {
        Name: var.environment
    }
}

variable availability_zone {
  description = "this zone is setted by using custem environment variable"
}


resource "aws_subnet" "dev-subnet-1" {
    vpc_id = aws_vpc.development-vpc.id
    cidr_block= var.subnet_cidr_block
    # availability_zone = "eu-west-3a"
    availability_zone = var.availability_zone

    tags = {
        Name: "subnet-1-dev"
    }
}

# data "aws_vpc" "existing_vpc" {
#     default =true
# }

# resource "aws_subnet" "dev-subnet-2" {
#     vpc_id = data.aws_vpc.existing_vpc.id
#     cidr_block= "172.31.48.0/20"
#     availability_zone = "eu-west-3a"
#     tags = {
#         Name: "subnet-2-default"
#     }
# }

# output "dev-vpc-id" {
#   value = aws_vpc.development-vpc.id
# }

# output "dev-subnet-id" {
#   value = aws_subnet.dev-subnet-1.id
# }
