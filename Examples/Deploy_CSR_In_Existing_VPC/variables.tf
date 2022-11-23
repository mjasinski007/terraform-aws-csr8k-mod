variable "aws_profile" {
    type = string
    default = "169444603265"
}

variable "aws_region" {
    type = string
    default = "eu-west-2"
}

variable "csr_keypair" {
    type = string
    default = "OnPremCSR_KeyPair"
}

variable "existing_vpc_id" {
    type = string
}

variable "gig1_existing_subnet_id" {
    type = string
}

variable "gig2_existing_subnet_id" {
    type = string
}
