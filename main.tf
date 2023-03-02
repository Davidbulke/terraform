provider "aws" {
    region = "us-east-1"
}

variable "subnet_cidr_block" {
    description = "subnet cidr block"
}


resource "aws_vpc" "development-vpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
         Name: "Dev-vpc"
         vpc_env: "dev"
    }
}

resource "aws_subnet" "dev-subnet-1" {
    vpc_id = aws_vpc.development-vpc.id
    cidr_block = "10.0.10.0/24"
    availability_zone = "us-east-1a"
    tags = {
        Name: "dev-subnet-1"
    }
}

data "aws_vpc" "existing_vpc" {
    default = true   
}

resource "aws_subnet" "dev-subnet-2" {
    vpc_id = data.aws_vpc.existing_vpc.id
    cidr_block = "172.31.160.0/20"
    availability_zone = "us-east-1a"
    tags = {
         Name: "dev-subnet-2-default"
    }
}

output "dev-vpc-id" {
    value = aws_vpc.development-vpc.id
}

output "dev-subnet-02-id" {
    value = aws_subnet.dev-subnet-2.id
}

output "dev-subnet-01-id" {
    value = aws_subnet.dev-subnet-1.id
}
