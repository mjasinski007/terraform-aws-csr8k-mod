data "aws_region" "current" {}

# Retrieve my public IP address
data "http" "my_public_ip" {
    url = "http://ipv4.icanhazip.com"
}

# CSR AMI
data "aws_ami" "this" {
    owners      = ["aws-marketplace"]
    #owners      = ["679593333241"] # Cisco Systems
    most_recent = true

    filter {
        name   = "name"
        #values = var.csr_ami == "BYOL" ? [var.csr_ami_byol_ami] : [var.csr_ami_sec_ami]
        #values = var.prioritize == "price" ? ["cisco_CSR-17.03.06-BYOL-624f5bb1-7f8e-4f7c-ad2c-03ae1cd1c2d3ami-0d8ad992c259060ef"] : ["cisco_CSR-.17.3.3-SEC-dbfcb230-402e-49cc-857f-dacb4db08d34"]
        values = ["Cisco-C8K-PAYG-ESS-17.08.01a-0973be0f-17dc-43c1-9677-13348bbfe587"]
    }
}

data "template_file" "running_config" {
    template = file("${path.module}/running-config.tpl")

    vars = {
        admin_password = var.admin_password
        hostname       = var.csr_hostname
    }
}
