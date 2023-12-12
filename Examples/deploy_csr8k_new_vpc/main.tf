module "csr8k_vpc" {
    source                   = "/Users/vmario/Desktop/vDEVNET_Projects/02.WORK/01.AVIATRIX/01.AVIATRIX_GITHUB/01.Modules/terraform-aws-onprem-csr"
    #source                  = "github.com/mjasinski007/terraform-aws-onprem-csr.git"
    vpc_name                 = var.vpc_name
    vpc_cidr                 = var.vpc_cidr
    csr8k_ami                = var.ami_type
    instance_type            = var.instance_type
    admin_password           = var.admin_password
    hostname                 = var.hostname
    custom_bootstrap         = true # set always as true to use running_config.tpl # Issue 1 in progress
    bootstrap_data           = data.template_file.running_config.rendered
    private_ip_list_enabled  = true
    gig1_private_address     = var.gig1_private_address
    gig2_private_address     = var.gig2_private_address
    gig1_subnet_id           = module.csr8k_vpc.public_subnets[0].cidr_block
    gig2_subnet_id           = module.csr8k_vpc.private_subnets[0].cidr_block
    
    
    
        enable_dns_hostnames     = true
    enable_dns_support       = true
    gig1_ingress_cidr_blocks = var.gig1_ingress_cidr_blocks
    gig1_egress_cidr_blocks  = var.gig1_egress_cidr_blocks
    gig2_ingress_cidr_blocks = var.gig2_ingress_cidr_blocks
    gig2_egress_cidr_blocks  = var.gig2_egress_cidr_blocks
}
