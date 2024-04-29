variable "cidr" {
    description = "CIDR block for the VPC"
}

variable "public_subnet_cidrs" {
    description = "List of CIDR blocks for the public subnets"
    type = list(string)
}

variable "private_subnet_cidrs" {
    description = "List of CIDR blocks for the private subnets"
    type = list(string)
}

variable "vpc_name" {
    description = "Name of the VPC"
}

variable "region" {
    description = "AWS region where the VPC will be created"
}