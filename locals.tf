locals {
    cidrbits              = tonumber(split("/", var.vpc_cidr)[1]) # get the length of mask e.q 16
    newbits               = 26 - local.cidrbits
    netnum                = pow(2, local.newbits)
    az1                   = data.aws_availability_zones.aws_azs.names[0]
    csr_bootstrap         = var.custom_bootstrap ? var.bootstrap_data : data.template_file.initial_config.rendered
    ssh_cidr_blocks       = var.ssh_allow_ip != null ? var.ssh_allow_ip : ["${chomp(data.http.my_public_ip.response_body)}/32"]

    ingress_ports = {
        "Allow SSH TCP 22" = {
            port        = 22,
            protocol    = "tcp",
            cidr_blocks = local.ssh_cidr_blocks,
        }
        "Allow ESP UDP 500" = {
            port        = 500,
            protocol    = "udp",
            cidr_blocks = var.gig1_ingress_cidr_blocks,
        }
        "Allow IPsec UDP 4500" = {
            port        = 4500,
            protocol    = "udp",
            cidr_blocks = var.gig1_ingress_cidr_blocks,
        }
    }
}