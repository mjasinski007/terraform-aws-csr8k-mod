variable "create_vpc" {
    description = "Controls if VPC should be created"
    type        = bool
    default     = true
}

variable "vpc_name" {
    description = "Name for this VPC"
    type        = string

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
}


variable "public_subnet_cidr" {
    description = "First Public Subnet for gig1"
    type        = string
}

variable "private_subnet_cidr" {
    description = "First Private Subnet for gig2"
    type        = string
}






# variable "azs" {
#     description = "A list of availability zones names or ids in the region"
#     type        = list(string)
#     default     = []
# }

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



# #### Public Subnets ####

# variable "public_subnet_names" {
#     description = "Explicit values to use in the Name tag on public subnets. If empty, Name tags are generated"
#     type        = list(string)
#     default     = []
# }

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

# variable "public_subnet_tags" {
#   description = "Additional tags for the public subnets"
#   type        = map(string)
#   default     = {}
# }

# variable "public_subnet_tags_per_az" {
#   description = "Additional tags for the public subnets where the primary key is the AZ"
#   type        = map(map(string))
#   default     = {}
# }

# variable "public_route_table_tags" {
#   description = "Additional tags for the public route tables"
#   type        = map(string)
#   default     = {}
# }







# variable "vpc_id" {
#     description = "VPC ID, for using an existing VPC."
#     type        = string
#     default     = ""
#     nullable    = false
# }

# variable "private_subnet" {
#     description = "Private Subnet. Required when use_existing_vpc is true"
#     type        = string
#     default     = ""
#     nullable    = false

#     validation {
#         condition     = var.private_subnet == "" || can(cidrnetmask(var.private_subnet))
#         error_message = "This does not like a valid CIDR."
#     }
# }

# variable "public_subnet" {
#     description = "Public Subnet. Required when use_existing_vpc is true and ha_gw is true"
#     type        = string
#     default     = ""
#     nullable    = false

#     validation {
#         condition     = var.public_subnet == "" || can(cidrnetmask(var.public_subnet))
#         error_message = "This does not like a valid CIDR."
#     }
# }
















# variable "csr_ami_byol_ami" {
#     description = "Cisco Cloud Services Router (CSR) 1000V - BYOL for Maximum Performance"
#     type        = string
#     default     = "cisco_CSR-17.03.07-BYOL-624f5bb1-7f8e-4f7c-ad2c-03ae1cd1c2d3"
# }

# variable "csr_ami_sec_ami" {
#     description = "Cisco Cloud Services Router (CSR) 1000V - Security Pkg. Max Performance"
#     type        = string
#     default     = "cisco_CSR-17.03.07-SEC-dbfcb230-402e-49cc-857f-dacb4db08d34"
# }

# variable "custom_bootstrap" {
#     description = "Enable custom bootstrap"
#     default     = false
# }

# variable "bootstrap_data" {
#     description = "Bootstrap data"
#     default     = null
# }

# variable "admin_password" {
#     description = "Admin password for CSR"
#     type        = string
#     default     = "Cisco123#"
# }

# variable "prioritize" {
#     description = "Possible values: price, performance. Instance ami adjusted depending on this"
#     type = string
#     default = "price"
# }

# variable "csr_hostname" {
#     description = "Admin password for CSR"
#     type        = string
#     default     = "OnPremCSR"
# }

# variable "vpc_id" {
#     description = "Existing VPC ID"
#     type        = string
# }

# variable "gig1_subnet_id" {
#     description = "Existing subnet ID for interface GigabitEthernet1"
#     type        = string
# }

# variable "gig2_subnet_id" {
#     description = "Existing subnet ID interface GigabitEthernet1"
#     type        = string
# }

# variable "key_name" {
#     description = "Key name of the Key Pair to use for the instance"
#     type        = string
#     default     = null
# }

# variable "csr_ami" {
#     description = "BYOL or SEC"
#     type        = string
#     default     = "BYOL"
# }

# variable "instance_type" {
#     description = "Cisco CSR instance size"
#     type        = string
#     default     = "t3.medium"
# }

# variable "ssh_allow_ip" {
#     description = "List of custom IP address blocks to be allowed for SSH e.g. [\"1.2.3.4/32\"] or [\"1.2.3.4/32\",\"2.3.4.5/32\"]"
#     type        = list(string)
#     default     = null
# }

# variable "ingress_cidr_blocks" {
#     description = "CIDR blocks to be allowed for ingress"
#     type        = list(string)
#     default     = ["0.0.0.0/0"]
# }

# variable "egress_cidr_blocks" {
#     description = "CIDR blocks to be allowed for egress"
#     type        = list(string)
#     default     = ["0.0.0.0/0"]
# }

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
