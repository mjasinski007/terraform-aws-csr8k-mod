variable "csr_ami_byol_ami" {
    description = "Cisco Cloud Services Router (CSR) 1000V - BYOL for Maximum Performance"
    type        = string
    #default     = "cisco_CSR-17.03.07-BYOL-624f5bb1-7f8e-4f7c-ad2c-03ae1cd1c2d3"
    default     = "Cisco-C8K-17.07.01a-42cb6e93-8d9d-490b-a73c-e3e56077ffd1"
}

variable "csr_ami_sec_ami" {
    description = "Cisco Cloud Services Router (CSR) 1000V - Security Pkg. Max Performance"
    type        = string
    default     = "cisco_CSR-17.03.07-SEC-dbfcb230-402e-49cc-857f-dacb4db08d34"
}

variable "custom_bootstrap" {
    description = "Enable custom bootstrap"
    default     = false
}

variable "bootstrap_data" {
    description = "Bootstrap data"
    default     = null
}

variable "admin_password" {
    description = "Admin password for CSR"
    type        = string
    default     = "Cisco123#"
}

variable "prioritize" {
    description = "Possible values: price, performance. Instance ami adjusted depending on this"
    type = string
    default = "price"
}

variable "csr_hostname" {
    description = "Admin password for CSR"
    type        = string
    default     = "OnPremCSR"
}

variable "vpc_id" {
    description = "Existing VPC ID"
    type        = string
}

variable "gig1_subnet_id" {
    description = "Existing subnet ID for interface GigabitEthernet1"
    type        = string
}

variable "gig2_subnet_id" {
    description = "Existing subnet ID interface GigabitEthernet1"
    type        = string
}

variable "key_name" {
    description = "Key name of the Key Pair to use for the instance"
    type        = string
    default     = null
}

variable "csr_ami" {
    description = "BYOL or SEC"
    type        = string
    default     = "BYOL"
}

variable "instance_type" {
    description = "Cisco CSR instance size"
    type        = string
    default     = "t3.medium"
}

variable "ssh_allow_ip" {
    description = "List of custom IP address blocks to be allowed for SSH e.g. [\"1.2.3.4/32\"] or [\"1.2.3.4/32\",\"2.3.4.5/32\"]"
    type        = list(string)
    default     = null
}

variable "ingress_cidr_blocks" {
    description = "CIDR blocks to be allowed for ingress"
    type        = list(string)
    default     = ["0.0.0.0/0"]
}

variable "egress_cidr_blocks" {
    description = "CIDR blocks to be allowed for egress"
    type        = list(string)
    default     = ["0.0.0.0/0"]
}
