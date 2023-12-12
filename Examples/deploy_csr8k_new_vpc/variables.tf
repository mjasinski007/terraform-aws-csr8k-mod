variable "aws_profile" {
    type = string
}

variable "aws_region" {
    type = string
}

variable "admin_password" {
    type = string
}

variable "hostname" {
    type = string
}

variable "vpc_name" {
    type = string
}

variable "vpc_cidr" {
    type = string
}

variable "ami_type" {
    type = string
}

variable "instance_type" {
    type = string
}


variable "gig1_private_address" {
    type = list(string)
}

variable "gig2_private_address" {
    type = list(string)
}

variable "gig1_ingress_cidr_blocks" {
    type = list(string)
}

variable "gig1_egress_cidr_blocks" {
    type = list(string)
}

variable "gig2_ingress_cidr_blocks" {
    type = list(string)
}

variable "gig2_egress_cidr_blocks" {
    type = list(string)
}




