
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