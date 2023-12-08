module "onprem_csr" {
    source  = "github.com/mjasinski007/terraform-aws-onprem-csr.git"
    create_vpc = true
    vpc_name   = "OnPremCSR-VPC"
    vpc_cidr   = "10.10.0.0/16"


    #vpc_id         = module.csr_vpc.vpc_id
    #gig1_subnet_id = module.csr_vpc.public_subnets[0]
    #gig2_subnet_id = module.csr_vpc.private_subnets[0]
    #key_name       = var.csr_keypair
}