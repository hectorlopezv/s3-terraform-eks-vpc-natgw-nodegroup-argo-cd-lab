variable "region" {
    description = "the aws region to deploy the resources"
    type = string
}

variable "instance_type" {
    description = "the instance type to deploy"
    type = string
}

variable "instance_name" {
    description = "the name of the instance"
    type = string 
}

variable "instance_az" {
    description = "availability zone 1"
    type        = string
}

variable "tfstate_bucket_name" {
    description = "bucket name where we store tfstate"
    type = string
}
variable "tfstate_bucket_key" {
    description = "key name where we store tfstate"
    type = string
}

variable "dynamodb_table_name" {
    description = "dynamodb table name"
    type = string
}

variable "project_name" {
    description = "the name of the project to deploy"
    type = string
}

variable "vpc_cidr" {
    description = "value for the vpc cidr"
    type = string
}

variable "pub_sub1_cidr" {
    description = "value for the public subnet 1 cidr"
    type = string
}

variable "pub_sub2_cidr" {
    description = "value for the public subnet 2 cidr"
    type = string
}

variable "pri_sub3_cidr" {
    description = "value for the private subnet 3 cidr"
    type = string
}

variable "pri_sub4_cidr" {
    description = "value for the private subnet 4 cidr"
    type = string
}