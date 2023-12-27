variable "create_vpc" {
    description = "Controls if VPC should be created"
    type        = bool
    default     = true
}

variable "vpc_id" {
    description = "VPC ID. Used when create_vpc = false"
    type        = string
    default     = null
}

variable "vpc_name" {
    description = "Name for this VPC"
    type        = string
    default     = ""

    validation {
        condition     = length(var.vpc_name) <= 30
        error_message = "Name is too long. Max length is 30 characters."
    }

    validation {
        condition     = can(regex("^[a-zA-Z0-9-_]*$", var.vpc_name))
        error_message = "Only a-z, A-Z, 0-9 and hyphens and underscores are allowed."
    }
}

variable "vpc_cidr" {
    description = "The IPv4 CIDR block for the VPC"
    type        = string
    default     = ""
}

variable "enable_dns_hostnames" {
    description = "Should be true to enable DNS hostnames in the VPC"
    type        = bool
    default     = true
}

variable "enable_dns_support" {
    description = "Should be true to enable DNS support in the VPC"
    type        = bool
    default     = true
}

variable "public_subnet_suffix" {
    description = "Suffix to append to public subnets name"
    type        = string
    default     = "public"
}

variable "private_subnet_suffix" {
    description = "Suffix to append to private subnets name"
    type        = string
    default     = "private"
}

variable "csr_ami_byol_ami" {
    description = "Cisco Cloud Services Router (CSR) 8000V - BYOL"
    type        = string
    default     = "Cisco-C8K-17.13.01a-42cb6e93-8d9d-490b-a73c-e3e56077ffd1"
}

# Subscribe: https://aws.amazon.com/marketplace/pp?sku=k585h9fyh5prlazwh3vb0yh3
variable "csr_ami_payg_ami" {
    description = "Cisco Cloud Services Router (CSR) 8000V - PAYG"
    type        = string
    default     = "Cisco-C8K-PAYG-ESS-17.07.01a-0973be0f-17dc-43c1-9677-13348bbfe587"
}

variable "custom_bootstrap" {
    description = "Enable custom bootstrap"
    default = false
}

variable "bootstrap_data" {
    description = "Bootstrap data"
    default = null
}

variable "admin_password" {
    description = "Admin password for CSR"
    type        = string
    default     = "Cisco123"
}

variable "hostname" {
    description = "hostname"
    type        = string
    default     = "OnPremCSR-Org"
}

variable "gig1_subnet_id" {
    description = "Existing subnet ID for interface GigabitEthernet1"
    type        = string
}

variable "gig2_subnet_id" {
    description = "Existing subnet ID interface GigabitEthernet1"
    type        = string
}

variable "csr8k_ami" {
    description = "BYOL or SEC"
    type        = string
}

variable "instance_type" {
    description = "Cisco CSR instance size"
    type        = string
}

variable "ssh_allow_ip" {
    description = "List of custom IP address blocks to be allowed for SSH e.g. [\"1.2.3.4/32\"] or [\"1.2.3.4/32\",\"2.3.4.5/32\"]"
    type        = list(string)
    default     = null
}
variable "gig1_ingress_cidr_blocks" {
    description = "CIDR blocks to be allowed for ingress"
    type        = list(string)
    default     = ["0.0.0.0/0"]
}


variable "gig1_egress_cidr_blocks" {
    description = "CIDR blocks to be allowed for egress"
    type        = list(string)
    default     = ["0.0.0.0/0"]
}

variable "gig2_ingress_cidr_blocks" {
    description = "CIDR blocks to be allowed for ingress"
    type        = list(string)
    default     = ["0.0.0.0/0"]
}

variable "gig2_egress_cidr_blocks" {
    description = "CIDR blocks to be allowed for egress"
    type        = list(string)
    default     = ["0.0.0.0/0"]
}

variable "private_ip_list_enabled" {
    type    = bool
    default = true
}

variable "gig1_private_address" {
    type    = list(string)
    default = []
}

variable "gig2_private_address" {
    type    = list(string)
    default = []
}

variable "tags" {
    description = "Map of tags to assign to the gateway."
    type        = map(string)
    default     = null
}

variable "vpc_tags" {
    description = "Additional tags for the VPC"
    type        = map(string)
    default     = {}
}

variable "create_igw" {
    description = "Controls if an Internet Gateway is created for public subnets and the related routes that connect them"
    type        = bool
    default     = true
}

variable "provision_aviatrix_s2c" {
    type    = bool
    default = false
}



