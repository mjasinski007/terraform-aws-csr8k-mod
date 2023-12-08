locals {
    create_vpc            = var.create_vpc
    #cidr                  = var.use_existing_vpc ? "10.0.0.0/216" : var.vpc_cidr
    cidrbits              = tonumber(split("/", var.vpc_cidr)[1])
    newbits               = 26 - local.cidrbits
    netnum                = pow(2, local.newbits)
    az1                   = data.aws_availability_zones.aws_azs.names[0]
    az2                   = data.aws_availability_zones.aws_azs.names[1]





    # csr_bootstrap   = var.custom_bootstrap ? var.bootstrap_data : data.template_file.running_config.rendered
    # ssh_cidr_blocks = var.ssh_allow_ip != null ? var.ssh_allow_ip : ["${chomp(data.http.my_public_ip.body)}/32"]

    # ingress_ports = {
    #     "Allow SSH TCP 22" = {
    #         port        = 22,
    #         protocol    = "tcp",
    #         cidr_blocks = local.ssh_cidr_blocks,
    #     }
    #     "Allow DHCP 67" = {
    #         port        = 67,
    #         protocol    = "udp",
    #         cidr_blocks = var.ingress_cidr_blocks,
    #     }
    #     "Allow ESP UDP 500" = {
    #         port        = 500,
    #         protocol    = "udp",
    #         cidr_blocks = var.ingress_cidr_blocks,
    #     }
    #     "Allow IPsec UDP 4500" = {
    #         port        = 4500,
    #         protocol    = "udp",
    #         cidr_blocks = var.ingress_cidr_blocks,
    #     }
    #     "Allow NTP UDP 123" = {
    #         port        = 123,
    #         protocol    = "udp",
    #         cidr_blocks = var.ingress_cidr_blocks,
    #     }
    #     "Allow SMTP UDP 161" = {
    #         port        = 161,
    #         protocol    = "udp",
    #         cidr_blocks = var.ingress_cidr_blocks,
    #     }
    #     "Allow HTTP TCP 80" = {
    #         port        = 80,
    #         protocol    = "tcp",
    #         cidr_blocks = var.ingress_cidr_blocks,
    #     }
    # }
}