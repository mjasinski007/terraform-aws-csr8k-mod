data "aws_availability_zones" "aws_azs" {
    state = "available"
}

# Retrieve my public IP address
data "http" "my_public_ip" {
    url = "http://ipv4.icanhazip.com"
}

# # CSR8k AMI
data "aws_ami" "ami_csr" {
    #owners      = ["aws-marketplace"]
    owners      = ["679593333241"] # Cisco Systems
    most_recent = true

    filter {
        name   = "name"
        values = var.csr8k_ami == "BYOL" ? [var.csr_ami_byol_ami] : [var.csr_ami_payg_ami]
        #values = ["Cisco-C8K-*"]
    }
}

data "template_file" "initial_config" {
    template = file("${path.module}/initial_config.tpl")

    vars = {
        admin_password = var.admin_password
        hostname       = var.hostname
    }
}
