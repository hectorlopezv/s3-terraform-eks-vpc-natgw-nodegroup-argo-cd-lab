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